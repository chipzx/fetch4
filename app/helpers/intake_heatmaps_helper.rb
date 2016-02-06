module IntakeHeatmapsHelper

  def intake_heatmap(mapId, map_data, max_intensity, latlngs, hotspots, hs_detail)

    str = ""
    # str += "var spinner = new Spinner().spin();"
    # str += "target.appendChild(spinner.el);"

    # create the data for the heatmap
    str += "var testData = "
    str += "  ["
    first = true
    latlngs.each do |ll|
      first ? first = false : str += ", "
      str += "[#{ll.latitude.to_f}, #{ll.longitude.to_f}, #{ll.total}]"
    end
    str += "  ]; "

    str += "var hotspot = L.MakiMarkers.icon({icon: 'fire-station', color: '#ff0000', size: 'l'});"
    str += "var aac = L.MakiMarkers.icon({icon: 'building', color: '#00ff00', size: 'm'});"

    # Create base layer for map
    str += "var #{mapId} = new L.Map('map').setView([#{map_data.center_point_latitude}, 
              #{map_data.center_point_longitude},], #{map_data.default_zoom_level}); "
    str += "var tiles = L.tileLayer('https://api.tiles.mapbox.com/v4/fetchsoft.n3kj8dd1/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiZmV0Y2hzb2Z0IiwiYSI6IjI2NDExZDY1NTlkMmZkMzVkNTc3YzI1YTU4NWM3ODlmIn0.a9ftht9yIWHeKc1eDWRwzw#9', { attribution: 'Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, geocoding <a href=\"http://geoservices.tamu.edu/Services/Geocode\">Texas A&M Geoservices</a>, Imagery @<a href=\"http://mapbox.com\">Mapbox</a>'}).addTo(#{mapId}); "
    str += "var heat = L.heatLayer(testData, { max : #{max_intensity} }).addTo(#{mapId}); "

    str += "var htMarkers =  [];"
    hotspots.to_a.each do |h|
      popup = "Stray Hotspot:<br/><u>#{h.found_location}</u><br/>"
      hs_detail.each do |d|
        if (d.found_location.eql?(h.found_location) && d.latitude == h.latitude && d.longitude == h.longitude)
          popup += "#{d.animal_type} FY #{d.fiscal_year}: #{d.total.to_i}<br/>"
        end
      end
      str += "var htm = L.marker([#{h.latitude},#{h.longitude}], {icon: hotspot}).addTo(#{mapId}).bindPopup('#{popup}');"
      str += "htMarkers.push(htm);"
    end
    layerGroup = "var hotspots = L.layerGroup(htMarkers);"

    str += layerGroup

    str += "var ata = L.marker([30.3090367631705, -97.7092597959172], {icon: aac}).addTo(#{mapId}).bindPopup('Animal Trustees of Austin');"
    str += "var ahs = L.marker([30.3446596859744, -97.7052404308576], {icon: aac}).addTo(#{mapId}).bindPopup('Austin Humane Society');"
    str += "var apa = L.marker([30.269746, -97.7592909], {icon: aac}).addTo(#{mapId}).bindPopup('Austin Pets Alive!');"
    str += "var aac = L.marker([30.2524029, -97.6896799], {icon: aac}).addTo(#{mapId}).bindPopup('Austin Animal Center and Emancipet');"

    str += "var baseMaps = { 'Tiles' : tiles };";
    str += "var overLays = { 'Hotspots' : hotspots };"

   str += "L.control.layers(baseMaps, overLays).addTo(#{mapId});"

   # str += "spinner.stop"

    raw(str)
  end

  def map_intakes(map_id, intakes, center_point, zoom)

    dog_icon = { :name => 'dog',
                 :icon_url => 'http://api.tiles.mapbox.com/v3/marker/pin-l-dog-park+ff0000.png',
                 :icon_size => [35, 90]}
    cat_icon = { :name => 'cat',
                 :icon_url => 'http://api.tiles.mapbox.com/v3/marker/pin-l-dog-park+0000ff.png',
                 :icon_size => [35, 90]}
    other_icon = { :name => 'other',
                 :icon_url => 'http://api.tiles.mapbox.com/v3/marker/pin-l-dog-park+00ff00.png',
                 :icon_size => [35, 90]}
    location_icon = { :name => 'location',
                 :icon_url => 'http://api.tiles.mapbox.com/v3/marker/pin-l-embassy+000066.png',
                 :icon_size => [35, 90]}
    str = "#{map_id} = map(:center => { :latlng => #{center_point},
                            :zoom => #{zoom}}, 
               :markers => [ { :latlng => [ 30.2316037, -97.7175746 ], 
                               :popup => 'East Riverside' }"
    if (intakes.size > 0)
      intakes.to_a.each do |a|
      str += ","
        str += "{ :latlng => [ #{a.latitude}, #{a.longitude} ] "
        if (a.animal_type.eql?("Dog"))
          str += ", :icon => dog_icon"
        elsif (a.animal_type.eql?("Cat"))
          str += ", :icon => cat_icon"

        else
          str += ", :icon => other_icon"
        end
        str += ", :popup => '#{a.animal_id}<br/>#{a.animal_type} - #{a.intake_type}<br/>#{a.found_location}<br/>#{a.intake_date}<br/>#{a.gender} #{a.color} #{a.breed}'"
        str += "}"
      end
    else
      str += ","
    end
    str += "])"
    logger.info(str)
    eval(str)
  end
end
