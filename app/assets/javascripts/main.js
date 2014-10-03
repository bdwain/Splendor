'use strict';

angular.module('splendor.controllers', []);
angular.module('splendor.services', []);

var app = angular.module('splendor', [
  'ngRoute',
  'templates',
  'splendor.controllers',
  'splendor.services'
]);

app.config(['$routeProvider', '$httpProvider', '$locationProvider', 
  function($routeProvider, $httpProvider, $locationProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'home.html',
        controller: 'HomeCtrl'
      }).
      when('/login', {
        templateUrl: 'login.html',
        controller: 'LoginCtrl'
      }).
      otherwise({
        redirectTo: '/'
      });

      $httpProvider.interceptors.push('AuthInterceptor');
      $locationProvider.html5Mode(true);
  }]);