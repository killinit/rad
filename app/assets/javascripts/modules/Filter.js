define(['jquery', 'List'], function($, List) {

  'use strict';

  var firmOptions = {
    valueNames: [ 'frn', 'firm-name', 'principal-name' ]
  };

  var firmList = new List('firm-list', firmOptions);

} );