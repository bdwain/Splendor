'use strict';

var services = angular.module('splendor.services');

services.factory('PageService', function(){
  var title = 'Splendor';
  return {
    title: function() { return title; },
    setTitle: function(newTitle) { title = newTitle; }
  };
});