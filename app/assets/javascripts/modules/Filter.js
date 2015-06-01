define(['jquery', 'List'], function($, List) {

  'use strict';

  var firmOptions = {
    valueNames: [ 't-frn', 't-firm-name', 't-principal-name' ]
  };

  var firmList = new List('firm-list', firmOptions);

} );