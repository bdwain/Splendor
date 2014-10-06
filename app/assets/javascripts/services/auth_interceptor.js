'use strict';

var services = angular.module('splendor.services');

services.factory('AuthInterceptor', ['$window', '$q', '$location', '$injector',  
  function ($window, $q, $location, $injector) {
    var isApiRequest = function(path){
      return path.indexOf($location.protocol() + "://" + $location.host() + ":" + $location.port() + "/api/v1") == 0 || 
             path.indexOf("/api/v1") == 0;
    }

    return {
      request: function(config) {
        var AuthenticationService = $injector.get('AuthenticationService'); //can't inject directly because of a circular dependency :(
        config.headers = config.headers || {};
        if("url" in config && isApiRequest(config["url"])){
          if (AuthenticationService.isAuthenticated()) {
            config.headers['X-User-Token'] = AuthenticationService.getToken();
            config.headers['X-User-Email'] = AuthenticationService.getUserEmail();
          }
        }
        return config || $q.when(config);
      },
      responseError: function(response) {
        if("url" in response.config && isApiRequest(response.config["url"]) && response.config["url"].indexOf("login") == -1){
          if (response.status === 401) {
            $location.path('/login');
          }
        }
        return $q.reject(response);
      }
    };
  }
]);