var app = angular.module('welcome', [ ]);

app.controller('WelcomeController', [ "$scope",  "$http", 
  function($scope, $http) {
  $scope.get_news = function() {
    $http.get("/welcome.json").then(
      function(response) {
        $scope.news = response.data;
      },
      function(response) {
        alert("Problem retrieving data: " + response.statusText);
      }
    );
  }
  $scope.get_news();
  }
]);

