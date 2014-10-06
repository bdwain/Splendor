'use strict';

var services = angular.module('splendor.services');

services.factory('RegistrationService', ['$http', '$q', '$window', function ($http, $q, $window) {
 return {
    register: function (registerData) {
      var deferred = $q.defer();
      $http.post('/api/v1/register', {user: registerData})
        .success(function (response) {
          deferred.resolve(response);
        }).error(function (err, status) {
          deferred.reject(err.message);
        });

      return deferred.promise;
    },

    delete_account: function () {
      var deferred = $q.defer();
      $http.delete('/api/v1/delete_account')
        .success(function (response) {
          deferred.resolve(response);
        }).error(function (err, status) {
          deferred.reject(err.message);
        });

      return deferred.promise;
    }
  };
}]);