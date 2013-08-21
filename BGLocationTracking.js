//
//  BGLocationTracking.js
//  
//
//  Created by Stas Gorodnichenko on 20/08/13.
//  MIT Licensed
//

var BGLocationTracking = {
    

    startUpdatingLocation: function( callbackSuccess, callbackStart, callbackError ) {
        //@TODO convert callback's name in string
        cordova.exec( callbackStart, callbackError, "BGLocationTracking", "startUpdatingLocation", [callbackSuccess] );
    },
    
    stopUpdatingLocation: function( callbackStop, callbackError ) {
        cordova.exec( callbackStop, callbackError, "BGLocationTracking", "stopUpdatingLocation", [] );
    }

};