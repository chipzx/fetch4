var app = angular.module('animals', [ ]);

app.controller('AnimalsController', [ "$scope", 
  function($scope) {
    $scope.animals = [
        {
          "animal_type_id":"1",
          "anumber":"A615234",
          "name":"Kenzie",
          "gender":"Spayed Female",
          "breed":"Scottish Deerhound Mix",
          "coloring":"black",
          "weight":"74",
          "dob":"2009-04-21",
          "dob_known":"false",
          "intake_date":"2012-04-21",
          "intake_type_id":"1",
          "description":"Stray found in SE Travis County",
          "group_id":"0",
          "microchip_number":"NF"
        },
        {
          "animal_type_id":"1",
          "anumber":"A515234",
          "name":"Woodie",
          "gender":"Neutered Male",
          "breed":"Saluki/Greyhound Mix",
          "coloring":"tan",
          "weight":"63",
          "dob":"2006-02-01",
          "dob_known":"false",
          "intake_date":"2006-02-01",
          "intake_type_id":"1",
          "description":"Stray found in SE Travis County",
          "group_id":"0",
          "microchip_number":"NF"
        }
];
    $scope.search = function(searchTerm) {
      $scope.searchedFor = searchTerm;
    }
  }
]);
