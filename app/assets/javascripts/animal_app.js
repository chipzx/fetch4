var app = angular.module('animals', [ ]);

app.controller('AnimalsController', [ "$scope", 
  function($scope) {
    $scope.search = function(searchTerm) {
      $scope.searchedFor = searchTerm;
    }
  }
]);
