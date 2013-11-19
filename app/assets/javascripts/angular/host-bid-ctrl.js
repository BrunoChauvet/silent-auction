var auctionModule = angular.module('auction');

auctionModule.controller('HostBidsCtrl', ['$scope', '$http', function($scope, $http) {

  $scope.init = function(user_id, item_id, current_price, minimum_price) {
  	$scope.user_id = user_id;
  	$scope.item_id = item_id;
    $scope.currentPrice = current_price;
    $scope.biddingPrice = minimum_price;
    $scope.defaultPrice = minimum_price;
    $scope.error = '';
  };

  $scope.add = function(amount) {
    $scope.error = '';
    $scope.biddingPrice = parseInt($scope.biddingPrice) + parseInt(amount);
  };

  $scope.refresh = function() {
    $scope.error = '';
    $scope.biddingPrice = $scope.defaultPrice;
  };

  $scope.placeBid = function() {
    $scope.error = '';
    
    $http({method: 'POST', url: '/place_bid/' + $scope.user_id + '/' + $scope.item_id + '.json', data: {'price': $scope.biddingPrice}})
         .success(function(data, status, headers, config) {
      if(data.success) {
        window.location = '/select_table';
      } else {
          $scope.currentPrice = data.current_price;
          $scope.biddingPrice = data.minimum_price;
          $scope.defaultPrice = data.minimum_price;
        if(data.message) {
          $scope.error = data.message;
        }
      }
    });
  };

}]);
