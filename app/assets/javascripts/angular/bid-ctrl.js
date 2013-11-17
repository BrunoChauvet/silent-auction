var auctionModule = angular.module('auction');

auctionModule.controller('BidsCtrl', ['$scope', '$http', function($scope, $http) {

  $scope.init = function(user_id, item_id, price) {
  	$scope.user_id = user_id;
  	$scope.item_id = item_id;
    $scope.price = price;
    $scope.initialPrice = price;
    $scope.error = '';
  };

  $scope.add = function(amount) {
    $scope.error = '';
    $scope.price = parseInt($scope.price) + parseInt(amount);
  };

  $scope.refresh = function() {
    $scope.error = '';
    $scope.price = $scope.initialPrice;
  };

  $scope.placeBid = function() {
    $scope.error = '';
    
    $http({method: 'POST', url: '/place_bid/' + $scope.user_id + '/' + $scope.item_id + '.json', data: {'price': $scope.price}})
         .success(function(data, status, headers, config) {
      if(data.success) {
        window.location = '/select_table';
      } else {
        if(data.price) {
          $scope.price = data.price;
        }
        if(data.message) {
          $scope.error = data.message;
        }
      }
    });
  };

}]);
