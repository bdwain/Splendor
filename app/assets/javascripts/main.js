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
      when('/', {
        templateUrl: 'home.html',
        controller: 'HomeCtrl'
      }).
      otherwise({
        redirectTo: '/'
      });

      $locationProvider.html5Mode(true);
  }]);