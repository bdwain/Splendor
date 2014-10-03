'use strict';

var services = angular.module('splendor.services');

services.factory('AuthInterceptor', ['$window', '$q', '$location', '$injector',  
  function ($window, $q, $location, $injector) {
    return {
      request: function(config) {
        var AuthenticationService = $injector.get('AuthenticationService'); //can't inject directly because of a circular dependency :(
        config.headers = config.headers || {};
        if("url" in config && config["url"].indexOf("/api/v1/") > -1){
          if (AuthenticationService.isAuthenticated()) {
            config.headers['X-User-Token'] = AuthenticationService.getToken();
            config.headers['X-User-Email'] = AuthenticationService.getUserEmail();
          }
        }
        return config || $q.when(config);
      },
      responseError: function(response) {
        if("url" in response.config && response.config["url"].indexOf("/api/v1/") > -1 && response.config["url"].indexOf("sign_in") == -1){
          if (response.status === 401) {
            $location.path('/login');
          }
        }
        return $q.reject(response);
      }
    };
  }
]);