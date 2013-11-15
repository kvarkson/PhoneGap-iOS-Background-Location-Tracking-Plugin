PhoneGap-iOS-Background-Location-Tracking-Plugin
================================================

If you need to track a user's location in background this plugin does exactly that. The location updates with an accuracy <code>kCLLocationAccuracyNearestTenMeters</code> and <code>distanceFilter = 10.0</code> (in meters). Basically the plugin will return new location any 10 meters. 

#Installing the plugin

Copy <code>BGLocationTrackingPlugin.h</code> and <code>BGLocationTrackingPlugin.m</code> files to your <code>Classes</code> folder and <code>BGLocationTrackingPlugin.js</code> file to <code>www/js/plugins</code> folder.

Add js file to your <code>index.html</code>.

    <script type="text/javascript" src="js/plugins/BGLocationTracking.js"></script>

Then add the following code to your <code>config.xml</code>:

	<feature name="BGLocationTracking">
		<param name="ios-package" value="BGLocationTracking" />
		<param name="onload" value="true" />
	</feature>

#Using the plugin

When the apps receives <code>Pause</code> event you need to call <code>startUpdatingLocation()</code> function. 
######Example
	
    // start listening "pause" and "resume" events and give them specific callbacks
    document.addEventListener( "pause", onPause, false );
    document.addEventListener( "resume", onResume, false );

    // success callback function
    function yourCallbackFunction( result ) {
    	// your coordinates
        console.log( result.coords.latitude );
        console.log( result.coords.longitude );
    };
    
    // error callback function (optional)
    function yourErrorCallback( result ) {
        console.log( result.message );
    };
    
    function onPause() {
        BGLocationTracking.startUpdatingLocation( yourCallbackFunction, yourErrorCallback );	
	};
    
    function onResume() {
        BGLocationTracking.stopUpdatingLocation();
    };

	

You can specify the callback by name or just pass an anonymous function. It will work fine either way.

After getting <code>Resume</code> event just call <code>stopUpdatingLocation()</code> function.

### NOTICE
You need to move so the success callback function could be fired up by iOS. So try to go for a walk with your device and you'll see the result :)

#License

The MIT License

Copyright (c) 2013 Stas Gorodnichenko, Alex Shmaliy

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
