var auctionModule = angular.module('auction');

auctionModule.factory('Items', function($resource) {
  return $resource('/auction',{});
});

auctionModule.controller('AuctionCtrl', function($scope, Items) {

  $scope.init = function() {
    $scope.items = Items.query();
  };

});
