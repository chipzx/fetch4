var app = angular.module('welcome', [ ]);

app.controller('WelcomeController', [ "$scope",  "$http", 
  function($scope, $http) {
  $scope.get_latest = function() {
    $http.get("/welcome.json").then(
      function(response) {
        $scope.latest = response.data;
      },
      function(response) {
        alert("Problem retrieving data: " + response.statusText);
      }
    );
  }
  $scope.get_latest();
  }
]);

