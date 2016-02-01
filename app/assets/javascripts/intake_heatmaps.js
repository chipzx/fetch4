var app = angular.module('intake_heatmaps', ['leaflet-directive']);

app.controller('IntakeHeatmapController',  ['$scope',  '$http', 'leafletData',
  function($scope, $http, leafletData) {

     function _init() {
     var default_tile = "https://api.tiles.mapbox.com/v4/fetchsoft.n3kj8dd1/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiZmV0Y2hzb2Z0IiwiYSI6IjI2NDExZDY1NTlkMmZkMzVkNTc3YzI1YTU4NWM3ODlmIn0.a9ftht9yIWHeKc1eDWRwzw#9', { attribution: 'Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, geocoding <a href=\"http://geoservices.tamu.edu/Services/Geocode\">Texas A&M Geoservices</a>, Imagery @<a href=\"http://mapbox.com\">Mapbox</a>'}).addTo(#{mapId}); ";
    var htmarkers = [];

    $scope.set_view = function(lat, lon, zoom) {
      leafletData.getMap().then(function(map) {
          map.setView([lat, lon], zoom);
      });
    };

    $scope.get_data = function() {
      $http.get('/intake_heatmaps.json').then(
        function(response) {
          $scope.map_data = response.data;
          $scope.set_view($scope.map_data.center_point_latitude, 
                          $scope.map_data.center_point_longitude, 
                          $scope.map_data.default_zoom_level);
        },
        function(response) {
          alert("Problem retrieving data: " + response.statusText);
        }
      );
    };

  $scope.get_data();

  };
  
  _init();
}]);

