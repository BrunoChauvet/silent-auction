var auctionModule = angular.module('auction');

auctionModule.controller('UserBidsCtrl', ['$scope', '$http', function($scope, $http) {

  $scope.init = function() {
  	$scope.message = '';
  	$scope.bidding = false;
    refreshItems();
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
  	$http({method: 'POST', url: '/bids', data: {'item': $scope.biddingItem, 'price': $scope.biddingPrice}}).
    success(function(data, status, headers, config) {
      if(data.success == true) {
      	console.log('Valid bid');
      	refreshItems();
      	$scope.bidding = false;
      } else {
      	$scope.message = data.message;
      	$scope.biddingPrice = data.price;
      }
    });
  };

  function refreshItems() {
    $http({method: 'GET', url: '/bids'}).
    success(function(data, status, headers, config) {
      $scope.items = data;
    });
  }

}]);
