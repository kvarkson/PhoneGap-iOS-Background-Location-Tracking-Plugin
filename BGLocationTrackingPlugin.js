//
//  BGLocationTrackingPlugin.js
//  
//
//  Created by Stas Gorodnihcenko on 20/08/13.
//  MIT Licensed
//

function BGLocationTrackingPlugin()
{
	console.log('creating plugin');
};

BGLocationTrackingPlugin.prototype.startTraking = function(message, url)
{
	cordova.exec(null, null, "BGLocationTrackingPlugin", "start", [message, url]);
    
};


BGLocationTrackingPlugin.prototype.stopTraking = function( callback )
{

    cordova.exec(callback, null, "BGLocationTrackingPlugin", "stopTraking", [] );
};


BGLocationTrackingPlugin.install = function()
{
    if(!window.plugins)
    {
        window.plugins = {};	
    }

    window.plugins.bgLocationTracking = new BGLocationTrackingPlugin();
    return window.plugins.bgLocationTracking;
};

cordova.addConstructor(BGLocationTrackingPlugin.install);