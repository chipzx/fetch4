module AnimalServices311HeatmapsHelper

  def animal_services311_heatmap(mapId, map_data, max_intensity, latlngs, hotspots, hsdetail)

    str = ""

    # create the data for the heatmap
    str += "var testData = "
    str += "  ["
    first = true
    latlngs.each do |ll|
      first ? first = false : str += ", "
      str += "[#{ll.latitude.to_f}, #{ll.longitude.to_f}, #{ll.total}]"
    end
    str += "  ]; "

    str += "var bldg = L.MakiMarkers.icon({icon: 'building', color: '#00ff00', size: 'm'});"

    # Create base layer for map
    str += "var #{mapId} = new L.Map('map').setView([#{map_data.center_point_latitude}, 
              #{map_data.center_point_longitude},], #{map_data.default_zoom_level}); "
    str += "var tiles = L.tileLayer('https://api.tiles.mapbox.com/v4/fetchsoft.n3kj8dd1/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiZmV0Y2hzb2Z0IiwiYSI6IjI2NDExZDY1NTlkMmZkMzVkNTc3YzI1YTU4NWM3ODlmIn0.a9ftht9yIWHeKc1eDWRwzw#9', { attribution: 'Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, geocoding <a href=\"http://geoservices.tamu.edu/Services/Geocode\">Texas A&M Geoservices</a>, Imagery @<a href=\"http://mapbox.com\">Mapbox</a>'}).addTo(#{mapId}); "
    str += "var heat = L.heatLayer(testData, { max : #{max_intensity} }).addTo(#{mapId}); "

    str += "var htMarkers =  [];"
    layerGroup = "var hotspots = L.layerGroup(htMarkers);"

    str += layerGroup

    str += "var ata = L.marker([30.3090367631705, -97.7092597959172], {icon: aac}).addTo(#{mapId}).bindPopup('Animal Trustees of Austin');"
    str += "var ahs = L.marker([30.3446596859744, -97.7052404308576], {icon: aac}).addTo(#{mapId}).bindPopup('Austin Humane Society');"
    str += "var apa = L.marker([30.269746, -97.7592909], {icon: aac}).addTo(#{mapId}).bindPopup('Austin Pets Alive!');"
    str += "var aac = L.marker([30.2524029, -97.6896799], {icon: aac}).addTo(#{mapId}).bindPopup('Austin Animal Center and Emancipet');"

    str += "var baseMaps = { 'Tiles' : tiles };";
    str += "var overLays = { 'Hotspots' : hotspots };"

   str += "L.control.layers(baseMaps, overLays).addTo(#{mapId});"

    raw(str)
  end

  def map_animal_services_311_calls(map_detail, map_id, animal_services311_calls, center_point, zoom)
    str = ""
    iconColors = [ "DC3912", "3366CC", "FF9900", "109618", "990099", "66AA00", "DD4477", "B82E2E", "316395", "994499", "22AA99", "AAAA11", "6633CC", "E67300", "000000", "FFFFFF", "FF0000", "00FF00", "0000FF", "CC0000", "00CC00", "0000CC" ]

    i = 0
    srIcons = Hash.new
    ServiceRequestType.all.to_a.each do |t|
      icon_url = "'http://api.tiles.mapbox.com/v3/marker/pin-l-emergency-telephone+" + iconColors[i] + ".png'"  
      icon = "L.icon({iconUrl: #{icon_url}, shadowUrl: '', iconSize: [35,90], shadowSize: [], iconAnchor: [0,0], shadowAnchor: [0, 0], popupAnchor: [0, 0]})"
      name = t.name.gsub(/\W+/,'_')
logger.info("Added #{name} to icons hash")
      srIcons["#{name}"] =  icon
      str += "var #{name}Icon = #{icon}; "
      i += 1
    end

    str += "var map = L.map('map'); "
    str += "map.setView(#{center_point}, #{zoom}); "
    str += "var center = L.marker(#{center_point}).addTo(map); "
    str += "center.bindPopup('Center point for #{map_detail.map_name} detail map<br/>Found #{animal_services311_calls.size} 311 service calls within a #{map_detail.radius} mile radius from this point'); "

    j = 0
    animal_services311_calls.to_a.each do |o|
      srName = o.service_request_type.name.gsub(/\W+/,'_')
logger.info("Looking up #{srName} in icon hash")
      icon = srIcons[srName]
      if (icon.nil?) 
        logger.error("Unable to find icon for #{srName}")
        break
      end
      id = "#{srName}#{o.id}"
      str += "#{id} = L.marker([#{o.address.latitude}, #{o.address.longitude}], { icon: #{icon}}).addTo(map); "
      str += "#{id}.bindPopup('#{o.service_request_id}<br/>#{o.service_request_type.name} - #{o.service_request_status_type.name}<br/>#{o.service_request_location}<br/>#{o.date_opened}'); "
      break if j == 1500
      j += 1
    end

    str += "L.tileLayer('https://api.tiles.mapbox.com/v4/fetchsoft.n3kj8dd1/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiZmV0Y2hzb2Z0IiwiYSI6IjI2NDExZDY1NTlkMmZkMzVkNTc3YzI1YTU4NWM3ODlmIn0.a9ftht9yIWHeKc1eDWRwzw#9', {
          attribution: 'Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, geocoding <a href=\"http://geoservices.tamu.edu/Services/Geocode\">Texas A&M Geoservices</a>, Imagery @<a href=\"http://mapbox.com\">Mapbox</a>',
          maxZoom: 18,
subdomains: '',
}).addTo(map);"

    raw(str)

  end

end
