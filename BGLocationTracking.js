//
//  BGLocationTracking.js
//
//
//  Created by Stas Gorodnichenko on 20/08/13.
//  MIT Licensed
//

var successCallBackFunction,
    successCallBackName = 'successCallBackFunction',
    BGLocationTracking = {
    
startUpdatingLocation: function( callbackSuccess, callbackStart, callbackError ) {
    if ( typeof callbackSuccess === 'function' ) {
        if ( callbackSuccess.name === '' ) {
            successCallBackFunction = function( result ) { callbackSuccess(result); };
        } else {
            successCallBackName = callbackSuccess.name;
        }
        console.log(successCallBackName);
        cordova.exec( callbackStart, callbackError, "BGLocationTracking", "startUpdatingLocation", [successCallBackName] );
    } else {
        console.log('Wrong callback signature!');
        callbackError.call();
    }
},
    
stopUpdatingLocation: function( callbackStop, callbackError ) {
    cordova.exec( callbackStop, callbackError, "BGLocationTracking", "stopUpdatingLocation", [] );
}
    
};