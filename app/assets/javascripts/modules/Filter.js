define(['jquery', 'List', 'ListFuzzySearch'], function($, List, ListFuzzySearch) {

  'use strict';

  var firmOptions = {
    valueNames: [ 'frn', 'firm-name', 'principal-name' ],
    plugins: [ ListFuzzySearch() ]
  };

  var firmList = new List('firm-list', firmOptions);

} );