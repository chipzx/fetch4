var app = angular.module('animals', [ ]);

app.controller('AnimalsController', [ "$scope",  "$http",
  function($scope, $http) {
    var page = 0;
    var prevTerm = ''

    $scope.animals = [];

    $http.get("/animals.json").then(
      function(response) {
        $scope.animals = response.data; 
      },
      function(response) {
        alert("Problem retrieving data: " + response.statusText);
      }
    );

    $scope.search = function(searchTerm) {
      $scope.searchedFor = searchTerm;
      if (searchTerm != prevTerm) {
        page = 0
      }
      $http.get("/animals.json", 
        { "params": { "keywords": searchTerm, "page": page }}
      ).then(function(response) {
        $scope.animals = response.data;
      },function(response) {
        alert("Problem retrieving data: " + response.statusText);
      }
      );
      prevTerm = searchTerm
    }
    $scope.previousPage = function() {
      if (page > 0) {
        page = page - 1;
        $scope.search($scope.keywords);
      }
    }
    $scope.nextPage = function() {
      page = page + 1;
      $scope.search($scope.keywords);
    }
  }
]);
