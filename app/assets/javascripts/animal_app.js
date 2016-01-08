var app = angular.module('animals', ['tableSort']);

app.controller('AnimalsController', [ "$scope",  "$http",
  function($scope, $http) {
    var page = 0;
    var prevTerm = ''

    // $scope.animals = [];
    $scope.sortBy = "kennel";
    $scope.pagesize = 30;
    $scope.reverseSort = false;

    // default number of animals to display on a page is 30
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

    // http call to get animal data for search
    $scope.get_animals = function(searchTerm, page, pagesize, sortBy, reverseSort) {
      $http.get("/animals.json",
        { "params": 
          { "keywords": searchTerm, 
            "page": page, 
            "pagesize": pagesize,
            "sortby": sortBy,
            "sortOrder": reverseSort
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

    /* This populates the animals index with all of the available records, sorted by kennel,
       on the default display of the index (e.g., initial display of this page, when there are no
       search params yet)
    */
    $scope.get_animals("", page, $scope.pagesize, $scope.sortBy, $scope.reverseSort);

    // Handler for search box
    // On keyword searches, we want to order results by highest to lowest score from Solr
    $scope.keyword_search = function(searchTerm) {
      if (searchTerm.length == 1) return;
      $scope.sortBy = "score";
      $scope.reverseSort = true;
      $scope.search(searchTerm);
    }

    // handler for previous button 
    $scope.previousPage = function() {
      if (page > 0) {
        page = page - 1;
        $scope.search($scope.keywords);
      }
    }

    // handler for next button
    $scope.nextPage = function() {
      page = page + 1;
      $scope.search($scope.keywords);
    }

    // handler for pagesize select list
    $scope.changePageSize = function() {
      $scope.pagesize = $scope.pagesizes.selectedSize.id
      $scope.search($scope.keywords);
    }

    // handler for column sorts
    $scope.sortedBy = function(sortCol) {
      if ($scope.sortBy == sortCol) {
        $scope.reverseSort = !$scope.reverseSort;
      }
      else {
        $scope.sortBy = sortCol;
      }
      $scope.search($scope.keywords);
    }

    // base search function for handlers
    $scope.search = function(searchTerm) {
      $scope.searchedFor = searchTerm;
      if (searchTerm != prevTerm) {
        page = 0
      }
      $scope.get_animals(searchTerm, page, $scope.pagesize, $scope.sortBy, $scope.reverseSort);
      
      /* We save the previous search term after the search so we can compare it the next 
         time around. If the current search term is different from the previous one we want 
         to display new results starting at page 0.
      */
      prevTerm = searchTerm
    }

  }
]);
