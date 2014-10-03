'use strict';

var services = angular.module('splendor.services');

services.factory('RegistrationService', ['$http', '$q', '$window', function ($http, $q, $window) {
 return {
    register: function (loginData) {
      var deferred = $q.defer();
      var service = this;
      $http.post('/api/v1/register', {user: loginData})
        .success(function (response) {
          $window.localStorage.setItem(service.authTokenIdentifier, response.auth_token);
          $window.localStorage.setItem(service.userEmailIdentifier, loginData.email);

          deferred.resolve(response);

        }).error(function (err, status) {
          deferred.reject(err.error);
        });

      return deferred.promise;
    },

    delete_account: function () {
      var deferred = $q.defer();
      var service = this;
      $http.delete('/api/v1/logout')
        .success(function (response) {
          $window.localStorage.removeItem(service.authTokenIdentifier);
          $window.localStorage.removeItem(service.userEmailIdentifier);

          deferred.resolve(response);

        }).error(function (err, status) {
          deferred.reject(err.error);
        });

      return deferred.promise;
    }
  };
}]);