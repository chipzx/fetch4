var app = angular.module('show', ['ngRoute']);

app.controller('ShowController', [ "$scope",  "$http", "$location",
  function($scope, $http, $location) {
    $scope.test = "test";
    $scope.sortBy = "kennel";
    $scope.absUrl = $location.absUrl();
    var elems = $scope.absUrl.split("/");
    var id = elems[elems.length-1];    
    var url = "/animals/" + id + ".json";
    $http.get(url).then(
        function(response) {
          $scope.animal = response.data;
        },
        function(response) {
          alert("Problem retrieving data: " + response.statusText);
        }
    );
  }
]);
