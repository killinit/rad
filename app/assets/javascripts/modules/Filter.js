define(['jquery', 'List', 'ListFuzzySearch'], function($, List, ListFuzzySearch) {

  'use strict';

  var firmOptions = {
    valueNames: [ 'js-frn', 'js-firm-name', 'js-principal-name' ],
    plugins: [ ListFuzzySearch() ]
  };

  var firmList = new List('firm-list', firmOptions);

} );