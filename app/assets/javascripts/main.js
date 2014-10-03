'use strict';

angular.module('splendor.controllers', []);
angular.module('splendor.services', []);

var app = angular.module('splendor', [
  'ngRoute',
  'templates',
  'splendor.controllers',
  'splendor.services'
]);

app.config(['$routeProvider', '$locationProvider', 
  function($routeProvider, $locationProvider) {
    $routeProvider.
      when('/home', {
        templateUrl: 'home.html',
        controller: 'HomeCtrl'
      }).
      otherwise({
        redirectTo: '/home'
      });

      $locationProvider.html5Mode(true);
  }]);