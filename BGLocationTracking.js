//
//  BGLocationTracking.js
//
//
//  Created by Stas Gorodnichenko on 20/08/13.
//  MIT Licensed
//

var successCallBackFunction,
    errorCallBackFunction,
    successCallBackName = 'successCallBackFunction',
    errorCallBackName = 'errorCallBackFunction',
    BGLocationTracking = {
    
startUpdatingLocation: function( callbackSuccess , callbackError ) {
    if ( typeof callbackSuccess === 'function' ) {
        
        if ( callbackSuccess.name === '' ) {
            successCallBackFunction = function( result ) { callbackSuccess(result); };
        } else {
            successCallBackName = callbackSuccess.name;
        }
        
        if ( ( typeof callbackError === 'function') ) {
            if (  callbackError.name === '') {
                errorCallBackFunction = function( result ) { callbackError(result); };
            } else {
                errorCallBackName = callbackError.name;
            }
        }
        
        cordova.exec( null, callbackError, "BGLocationTracking", "startUpdatingLocation", [successCallBackName, errorCallBackName] );
    } else {
        callbackError.call({ message: 'invalid signature of the success callback function' });
    }
},
    
stopUpdatingLocation: function( callbackStop, callbackError ) {
    cordova.exec( callbackStop, callbackError, "BGLocationTracking", "stopUpdatingLocation", [] );
}
    
};