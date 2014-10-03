'use strict';

angular.module('splendor.controllers').controller('LoginCtrl', ['$scope', 'PageService', 'AuthenticationService', '$location',
  function($scope, PageService, AuthenticationService, $location) {
    PageService.setTitle('Log In');
    
    if(AuthenticationService.isAuthenticated())
    {
      $location.path('/home');
      return;
    }

    $scope.loginData = {
        email: "",
        password: ""
    };
    $scope.message = "";
    $scope.login = function () {
      AuthenticationService.login($scope.loginData).then(
        function (response) {
          $location.path('/home');
        },
        function (err) {
          $scope.message = err;
        }
      );
    };
  }
]);
