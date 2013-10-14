var auctionModule = angular.module('auction');

auctionModule.factory('Bids', ['$resource', function($resource) {
  return $resource('/users/:user_id/items/:item_id',{},{
  	show: {method: 'GET'},
  	place_bid: {method: 'POST'}
  });
}]);

auctionModule.controller('BidsCtrl', ['$scope', 'Bids', function($scope, Bids) {

  $scope.init = function(user_id, item_id) {
  	$scope.user_id = user_id;
  	$scope.item_id = item_id;

    var last_bid = Bids.show({user_id: user_id, item_id: item_id}, function success(){
    	$scope.user = last_bid.user;
    	$scope.item = last_bid.item;
    	if(last_bid.bid) {
        $scope.price = last_bid.bid.price;
      } else {
        $scope.price = last_bid.item.start_price;
      }
    });
  };

  $scope.add = function(amount) {
    $scope.message = '';
  	$scope.price = parseInt($scope.price) + parseInt(amount);
  };

  $scope.placeBid = function() {
    $scope.message = '';

  	Bids.place_bid({user_id: $scope.user_id, item_id: $scope.item_id}, {price: $scope.price}, function success(response){
    	if(response.success) {
        console.log('Bid placed');
      } else {
        $scope.price = response.price;
        $scope.message = response.message;
      }
    });
  };

}]);
