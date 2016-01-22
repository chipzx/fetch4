var app = angular.module("galleries", [])

app.controller("GalleryController", [ "$scope", "$http",
  function($scope, Shttp) {
      $scope.get_animals = function(t) {
      $http.get("/animal_galleries.json",
        { "params":
          { 
          }
        }
      ).then(
        function(response) {
          $scope.animals = response.data;
        },
        function(response) {
          alert("Problem retrieving data: " + response.statusText);
        }
      );
    }
  }
]);


