var auctionModule = angular.module('auction');

auctionModule.factory('Items', ['$resource', function($resource) {
  return $resource('/auction',{}, {
    query: {method: 'GET', isArray: true, timeout: 1000}
  });
}]);

auctionModule.controller('AuctionCtrl', ['$scope', '$timeout', 'Items', function($scope, $timeout, Items) {

  $scope.init = function() {
    $scope.itemsPerPage = 6;
    $scope.pageNumber = 0;
    $scope.totalItems = 0;

    // var source = new EventSource('/auction');
    // source.onmessage = function(event) {
    //   $scope.$apply(function () {
    //     $scope.items = JSON.parse(event.data)
    //   });
    // };

    $scope.allItems = [];
    $scope.pageItems = [];

    (function refreshItems() {
      console.log("Before");
      Items.query({}, function(items) {
console.log("1");
          $scope.totalItems = items.length;
          $scope.allItems = items;
          $scope.pageItems = [];
console.log("2");
          var firstItemIndex = $scope.pageNumber * $scope.itemsPerPage;
          var lastItemIndex = firstItemIndex + $scope.itemsPerPage;
          angular.forEach($scope.allItems, function(item, index) {
            if(index >= firstItemIndex && index < lastItemIndex) {
              $scope.pageItems.push(item);
            }
          });
console.log("3");
          $timeout(refreshItems, 1000);
console.log("4");
      });
      console.log("After");
    })();

    (function nextPage() {
      console.log("Next");
      $scope.pageNumber = $scope.pageNumber + 1;
      if($scope.pageNumber > ($scope.totalItems / $scope.itemsPerPage)) {
        $scope.pageNumber = 0;
      }

      $timeout(nextPage, 10000);
    })();

  };

}]);
