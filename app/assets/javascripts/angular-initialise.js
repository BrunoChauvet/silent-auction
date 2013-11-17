var auctionModule = angular.module('auction', ['ngResource', 'ui.bootstrap'])
                           .config([
                              "$httpProvider", function($httpProvider) {
                                $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
                              }
                           ]);

angular.module('auction').filter('roundedCurrency', ['$filter', function ($filter) {
  return function(input) {
    input = parseFloat(input);
    if(input % 1 === 0) {
      input = input.toFixed(0);
    }
    return '$' + input;
  };
}]);