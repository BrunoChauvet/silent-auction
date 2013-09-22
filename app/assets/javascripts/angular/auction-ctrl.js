var auctionModule = angular.module('auction');

auctionModule.factory('Items', function($resource) {
  return $resource('/auction',{});
});

auctionModule.controller('AuctionCtrl', function($scope, Items) {

  $scope.init = function() {
    var source = new EventSource('/auction');
    source.onmessage = function(event) {
      $scope.$apply(function () {
        $scope.items = JSON.parse(event.data)
      });
    };
  };

});
