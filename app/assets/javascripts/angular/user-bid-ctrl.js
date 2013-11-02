var auctionModule = angular.module('auction');

auctionModule.controller('UserBidsCtrl', ['$scope', '$http', '$timeout', function($scope, $http, $timeout) {

  $scope.init = function() {
  	$scope.message = '';
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
    $scope.biddingPrice = item.price;
    $scope.biddingItem = item.item;
  };

  $scope.cancelBid = function() {
  	$scope.message = '';
  	$scope.bidding = false;
    $scope.biddingPrice = 0;
    $scope.biddingItem = null;
  };

  $scope.add = function(amount) {
  	$scope.message = '';
  	$scope.biddingPrice = parseInt($scope.biddingPrice) + parseInt(amount);
  };

  $scope.placeBid = function() {
  	$scope.message = '';
  	$http({method: 'POST', url: '/place_bid.json', data: {'item': $scope.biddingItem, 'price': $scope.biddingPrice}}).
    success(function(data, status, headers, config) {
      if(data.success == true) {
      	refreshItems();
      	$scope.bidding = false;
      } else {
      	$scope.message = data.message;
      	$scope.biddingPrice = data.price;
      }
    });
  };

  function refreshItems() {
    $http({method: 'GET', url: '/list_items.json'}).
    success(function(data, status, headers, config) {
      $scope.items = data;
    });
  }

}]);
