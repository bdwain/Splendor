'use strict';

angular.module('splendor.controllers').controller('MainCtrl', ['$scope', '$location', 'PageService', 'AuthenticationService',
  function($scope, $location, PageService, AuthenticationService){
    $scope.Page = PageService;

    $scope.$on('$locationChangeSuccess', function(event) {
      $scope.authenticated = AuthenticationService.isAuthenticated();
      $scope.path = $location.path();
    });

    $scope.logout = function(){
      AuthenticationService.logOut().then(
        function (response) {
          $location.path('/login');
        },
        function (err) {
          alert('Error signing out: ' + err);
        }
      );
    };
  }
]);