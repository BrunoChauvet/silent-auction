var auctionModule = angular.module('auction');

auctionModule.controller('UserBidsCtrl', ['$scope', '$http', '$timeout', function($scope, $http, $timeout) {

  $scope.init = function() {
  	$scope.message = '';
    $scope.error = '';
  	$scope.bidding = false;
  	$scope.items = [];
    refreshItems();

    (function tickRefreshItems() {
     refreshItems();

      $timeout(tickRefreshItems, 10000);
    })();
  };

  $scope.createBid = function(item) {
  	$scope.bidding = true;
    $scope.biddingPrice = item.min_price;
    $scope.defaultPrice = item.min_price;
    $scope.biddingItem = item.item;
  };

  $scope.cancelBid = function() {
  	$scope.message = '';
    $scope.error = '';
  	$scope.bidding = false;
    $scope.biddingPrice = 0;
    $scope.biddingItem = null;
  };

  $scope.add = function(amount) {
    $scope.message = '';
    $scope.biddingPrice = parseInt($scope.biddingPrice) + parseInt(amount);
  };

  $scope.refresh = function() {
    $scope.message = '';
    $scope.biddingPrice = $scope.defaultPrice;
  };

  $scope.placeBid = function() {
  	$scope.message = '';
    $scope.error = '';
  	$http({method: 'POST', url: '/place_bid.json', data: {'item': $scope.biddingItem, 'price': $scope.biddingPrice}}).
    success(function(data, status, headers, config) {
      if(data.success == true) {
      	refreshItems();
        $scope.message = 'Bid has been placed';
      	$scope.bidding = false;
      } else {
      	$scope.error = data.message;
      	$scope.biddingPrice = data.price;
      }
    });
  };

  function refreshItems() {
    $http({method: 'GET', url: '/current_bids.json'}).
    success(function(data, status, headers, config) {
      $scope.items = data;
    });
  }

}]);
