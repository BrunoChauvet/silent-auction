var auctionModule = angular.module('auction');

auctionModule.factory('Items', ['$resource', function($resource) {
  return $resource('/auction.json',{}, {
    query: {method: 'GET', isArray: true}
  });
}]);

auctionModule.controller('AuctionCtrl', ['$scope', '$timeout', '$http', 'Items', function($scope, $timeout, $http, Items) {

  $scope.init = function() {
    $scope.itemsPerPage = 6;
    $scope.pageNumber = 0;
    $scope.totalItems = 0;

    $scope.allItems = [];
    $scope.pageItems = [];

    (function refreshItems() {
      Items.query({}, function(items) {
          $scope.totalItems = items.length;
          $scope.allItems = items;
          $scope.pageItems = [];

          var firstItemIndex = $scope.pageNumber * $scope.itemsPerPage;
          var lastItemIndex = firstItemIndex + $scope.itemsPerPage;
          angular.forEach($scope.allItems, function(item, index) {
            if(index >= firstItemIndex && index < lastItemIndex) {
              $scope.pageItems.push(item);
            }
          });

          $timeout(refreshItems, 1000);
      });
    })();

    (function refreshAmountRaised() {
      $http({method: 'GET', url: '/amount_raised'}).
      success(function(data, status, headers, config) {
        $scope.amountRaised = data.amount_raised;
      });

      $timeout(refreshAmountRaised, 1000);
    })();

    (function refreshTimer() {
      $http({method: 'GET', url: '/time_left'}).
      success(function(data, status, headers, config) {
        $scope.timeLeft = data.time_left;
      });

      $timeout(refreshTimer, 60000);
    })();

    (function tickTimeLeft() {
      $scope.timeLeft = $scope.timeLeft - 1;
      duration = moment.duration($scope.timeLeft, 'seconds');
      $scope.timer = moment(duration.asMilliseconds()).format('h:m:s');

      $timeout(tickTimeLeft, 1000);
    })();

    (function nextPage() {
      $scope.pageNumber = $scope.pageNumber + 1;
      if($scope.pageNumber > ($scope.totalItems / $scope.itemsPerPage)) {
        $scope.pageNumber = 0;
      }

      $timeout(nextPage, 10000);
    })();

  };

}]);
