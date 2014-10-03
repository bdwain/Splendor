'use strict';

angular.module('splendor.controllers').controller('RegisterCtrl', ['$scope', 'PageService', 
  'RegistrationService', 'AuthenticationService', '$location',
  function($scope, PageService, RegistrationService, AuthenticationService, $location) {
    PageService.setTitle('Sign Up');
    
    if(AuthenticationService.isAuthenticated())
    {
      $location.path('/home');
      return;
    }

    $scope.registerData = {
        email: "",
        password: ""
    };
    
    $scope.message = "";
    $scope.success = false;

    $scope.register = function () {
      RegistrationService.register($scope.registerData).then(
        function (response) {
          $scope.message = "Please check your email to confirm your account.";
          $scope.success = true;
        },
        function (err) {
          $scope.message = err;
          $scope.success = false;
        }
      );
    };
  }
]);
