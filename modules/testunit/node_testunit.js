/**
 * @class testUnit
 * @parent Modules
 * 
 * ###Unit Testing with nodeunit
 * 
 * This module allows appDev to create and run unit tests with nodeunit. 
 * 
 */

// Replace These Tags:
//  testunit  : <-- the name of this module (lowercase)
//  Testunit  : <-- the name of this module (uppercase)
 
var log = AD.Util.Log;



////
//// Testunit Module
////

var testunitModule = new AD.App.Module({
    nameModule: 'testunit',
    pathModule: __dirname,
/*
    // change the default paths like this:
    pathInterfaces:    __dirname + '/interfaces',
    pathServerModels:  __dirname + '/models/node',
    pathClientModels:  __dirname + '/models/client',
    pathModuleScripts: __dirname + '/data/scripts'
*/
/*
    // If you want to override the default notification hub settings:
    hub: {
          wildcard: true, // should the event emitter use wildcards.
          delimiter: '.', // the delimiter used to segment namespaces.
          maxListeners: 0, // the max number of listeners that can be assigned to an event (defautl:10;  0:unlimited).
    }
*/
    
    });
    
testunitModule.createRoutes();
var mI = testunitModule.initialize();  // mI == Module Initialization Done
//$.when(mI).then(function(){
    // do any post initialization setup instructions here.
    // by the time you get here, all module resources are loaded.
//});


module.exports = testunitModule;
exports.version = 1;  // v1 of our AD.App.Module Definition


//var app = [interfaceName]Module.app;


/*
////
//// setup any Testunit specific routes here
////

### If you want to override the default Route Handling then
### remove testunitModule.createRoutes(); and uncomment this section.  
### Make your changes here:

////
//// On any /testunit/* route, we make sure our Client Models are loaded:
//// 
app.get('/init/testunit/*', function(req, res, next) {

        log(req,' init/' + testunitModule.nameModule + '/*  : adding model dependencies.');

        AD.App.Page.addJavascripts( req, testunitModule.moduleScripts );
        AD.App.Page.addJavascripts( req, testunitModule.listModelPaths );

        next();
});





////
//// Return any Module defined resources
////
app.get('/testunit/data/:resourcePath', function(req, res, next) {

    log(req,' /' + testunitModule.nameModule + '/data/ being processed.');

    var parts = req.url.split('/'+testunitModule.nameModule+'/');
    var urlParts = parts[1].split('?');
    var path = urlParts[0]; // without any additional params

    res.sendfile( testunitModule.pathModule+'/'+path);
});







### If you want to change/prevent any of the automatic directory 
### scanning, then remove the testunitModule.initialize()  and 
### uncomment these lines :




//// 
//// Scan any sub interfaces to gather their routes
////

testunitModule.loadInterfaces();



////
//// The Model objects 
////
//// Load the Server side model objects to handle incoming model actions.
////

testunitModule.loadModels();
exports.listModels=testunitModule.listModels;


////
//// 
//// Load the shared scripts that need to be used on each interface.

testunitModule.loadModuleScripts();



//// Load the services associated with this Module.
testunitModule.loadServices();



//// Load any shared CSS files defined by this Module.
testunitModule.loadModuleCSS();

*/