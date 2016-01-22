var app = angular.module('galleryUpload', ['ngFileUpload']);

app.controller('AnimalGalleryController', ['$scope', 'Upload', '$timeout', function ($scope, Upload, $timeout) {
    $scope.uploadPic = function(photo) {
      $scope.upload = Upload.upload({
        url: '/animal_galleries.json',
        method: 'POST',
        fields: { 'animal_galleries[animal_id]': $scope.animal_id, 'animal_galleries[photo]': photo },
        file: photo,
        fileFormDataName: 'animal_galleries[photo]'
      });

      file.upload.then(function (response) {
        $timeout(function () {
          photo.result = response.data;
        });
      }, function (response) {
        alert(response.status)
        if (response.status > 0) {
          $scope.errorMsg = response.status + ': ' + response.data;
        }
      }, function (evt) {
        // Math.min is to fix IE which reports 200% sometimes
        photo.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
      });
    }
}]);
