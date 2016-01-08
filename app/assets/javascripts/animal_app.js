var app = angular.module('animals', [ ]);

app.controller('AnimalsController', [ "$scope",  "$http",
  function($scope, $http) {
    var page = 0;
    var prevTerm = ''

    $scope.animals = [];
    $scope.pagesize = 30;
    $scope.pagesizes = {
      sizes: [
        {id: '5',   name: 'Show 5 Entries'},
        {id: '10',  name: 'Show 10 Entries'},
        {id: '30',  name: 'Show 30 Entries'},
        {id: '50',  name: 'Show 50 Entries'},
        {id: '100', name: 'Show 100 Entries'},
        {id: '500', name: 'Show 500 Entries'}
      ],
      selectedSize: {id: '30', name: '30 Entries'} 
    };

    $http.get("/animals.json",
        { "params": 
          { "keywords": '', 
            "page": 0, 
            "pagesize": $scope.pagesize
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

    $scope.search = function(searchTerm) {
      $scope.searchedFor = searchTerm;
      if (searchTerm.length == 1) {
        return;
      }
      if (searchTerm != prevTerm) {
        page = 0
      }
      $http.get("/animals.json", 
        { "params": 
          { "keywords": searchTerm, 
            "page": page, 
            "pagesize": $scope.pagesize
          }
        }
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
    $scope.changePageSize = function() {
      $scope.pagesize = $scope.pagesizes.selectedSize.id
      $scope.search($scope.keywords);
    }
  }
]);
