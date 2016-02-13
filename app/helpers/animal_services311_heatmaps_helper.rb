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

end
