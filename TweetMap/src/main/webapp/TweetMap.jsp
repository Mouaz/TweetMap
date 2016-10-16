<%@ page language="java" contentType="text/html;"%>
<!DOCTYPE html>
<html ng-app="tweetAPP">
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Tweet Map</title>
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }
    </style>
  </head>
  <body>
  <div  ng-controller="tweetCtrl"></div>
    <div id="map" ></div>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-route.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-resource.min.js"></script>
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBGws0mfGsHSyKGyjRz9odYtixQyXPYMHU&callback=initMap">
    </script>
    <script>

       function initMap() {
loadTweets();
       }
        function loadTweets(){
        	var labels = ['tweet','tweet'];
        	var markers = []
        	
            // doing it the old way 
            var data_file = "http://localhost:8080/TweetMap/webresources/myresource";
            var http_request = new XMLHttpRequest();
            try{
               // Opera 8;.0+, Firefox, Chrome, Safari
               http_request = new XMLHttpRequest();
            }catch (e){
               // Internet Explorer Browsers
               try{
                  http_request = new ActiveXObject("Msxml2.XMLHTTP");
					
               }catch (e) {
				
                  try{
                     http_request = new ActiveXObject("Microsoft.XMLHTTP");
                  }catch (e){
                     // Something went wrong
                     alert("Your browser broke!");
                     return false;
                  }
					
               }
            }
			
            http_request.onreadystatechange = function(){
	               var markers_ = [];
	               var map = new google.maps.Map(document.getElementById('map'), {
	                   zoom: 3,
	                   center: {lat: 30.0444 , lng: 31.2357}
	                 });
               if (http_request.readyState == 4  ){
                  // Javascript function JSON.parse to parse JSON data
                  var jsonObj = JSON.parse(http_request.responseText);
                  //alert(jsonObj);
                  for (var j=0; j < jsonObj.length; j++) {
                  var marker =  new google.maps.Marker({
                      position: {lat: parseFloat(jsonObj[j].lat), lng: parseFloat(jsonObj[j].lon)},
                    	title: jsonObj[j].userName
                    });
                    var infowindow = new google.maps.InfoWindow({
                        content: jsonObj[j].content
                      });
                    marker.addListener('click', function() {
                        map.setZoom(8);
                        map.setCenter(marker.getPosition());
                        infowindow.open(marker.get('map'), marker);
                      });
                    markers_.push(marker);
               }
              } 
               //alert(markers_.length);
               var markerCluster = new MarkerClusterer(map, markers_,
                       {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
               //return markers_;
               }
            
			
            http_request.open("GET", data_file, true);
            http_request.send();

            
         }
        

      // Trying doing it by angularjs but javascript doesn't reveal what's wrong with it
         //
        /*
        alert("shezo");
        var markers = [];
        var appt = angular.module('tweetAPP', ['ngRoute']);

        function generateMarkers($scope,$http) {
        	var url = "http://localhost:8080/TweetMap/webresources/myresource";

        	   $http.get(url).success( function(response) {
            	   alert(response);
        		   var markers = [];
        		   for (var j=0; j < response.length; j++) {
                   	var marker =  new google.maps.Marker({
                           position: {lat: data[j].lat, lng:data[j].lon},
                           label: labels[i % labels.length],
                         	title: data[j].userName
                         });
                         var infowindow = new google.maps.InfoWindow({
                             content: data[j].content
                           });
                         marker.addListener('click', function() {
                             map.setZoom(8);
                             map.setCenter(marker.getPosition());
                             infowindow.open(marker.get('map'), marker);
                           });
                         markers.push(marker);
                   } 
                   $scope.markers = markers;
                   return markers;
        	   });
        	}
        markers = function() {
        	  $scope.generateMarkers($http);
        	};
    	//markers = generateMarkers();
         appt.controller('tweetCtrl', function() {
        	$scope.getTweetsFromLocalhost = function() {
            $http.get("http://localhost:8080/TweetMap/webresources/myresource")
            .success(function(response) {
                alert(response);
                $scope.content = response.data;
            
        	});
        	};
            $scope.getTweetsFromLocalhost();
        });
        ()alert("shezo tani");
        appt.controller("tweetCtrl", function($scope, $http) {   
        alert("shezo talet");
        function _refreshTweetData() {  
        	alert("shezo taleti");
            $http({  
                method : 'GET',  
                url : 'http://localhost:8080/TweetMap/webresources/myresource'  
            }).then(function successCallback(response) { 
                alert(response); 
                for (var j=0; j < response.length; j++) {
                	var marker =  new google.maps.Marker({
                        position: {lat: data[j].lat, lng:data[j].lon},
                        label: labels[i % labels.length],
                      	title: data[j].userName
                      });
                      var infowindow = new google.maps.InfoWindow({
                          content: data[j].content
                        });
                      marker.addListener('click', function() {
                          map.setZoom(8);
                          map.setCenter(marker.getPosition());
                          infowindow.open(marker.get('map'), marker);
                        });
                      markers.push(marker);
                }
                //$scope.simpletweets = response.data;  
            }, function errorCallback(response) {  
                console.log(response.statusText);  
            });  
        }  
   
        function _success(response) {  
        	_refreshTweetData(); 
        }  
   
        function _error(response) {  
            console.log(response.statusText);  
        }  
     
    });
        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "locations" array.
        // The map() method here has nothing to do with the Google Maps API.
        var markers = locations.map(function(location, i) {
          var marker =  new google.maps.Marker({
            position: location,
            label: labels[i % labels.length],
          	title: 'yaaaaaaay'
          });
          var infowindow = new google.maps.InfoWindow({
              content: 'a messagy'
            });
          marker.addListener('click', function() {
              map.setZoom(8);
              map.setCenter(marker.getPosition());
              infowindow.open(marker.get('map'), marker);
            });
          return marker;
        });
        
        // Add a marker clusterer to manage the markers.
       }
      var locations = [
        {lat: -31.563910, lng: 147.154312}
      ]
      */
    </script>
  </body>
</html>