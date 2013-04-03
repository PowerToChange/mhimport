/**
 * @class Site
 * @parent Modules
 * 
 * ###Site Module
 * 
 * This module contains administrative tools for the generic site framework.
 * 
 */


var $ = AD.jQuery;

var siteModule = new AD.App.Module({
    nameModule: 'site',
    pathModule: __dirname,
//    pathInterfaces:   __dirname + '/interfaces',
//    pathServerModels: __dirname + '/models/node/',
//    pathClientModels: __dirname + '/models/client/'
    
    });
    




////
//// setup any Site specific routes here
////



siteModule.createRoutes();
/*
////
//// On any /site/* route, we make sure our Client Models are loaded:
//// 
app.get('/init/site/*', function(req, res, next) {

Log(req,' init/site/*  : adding model dependencies.');

    addJavascripts( req, siteModule.clientModels );

    next();
});
*/



var dI = siteModule.initialize();
module.exports = siteModule;
exports.version = 1;  // which version of AD.App.Module this conforms to:

$.when(dI).then(function(){
    // post a notification to indicate that the site module is loaded & ready
    AD.Comm.Notification.publish('site.ready', {});
});

/*
//// 
//// Scan any sub interfaces to gather their routes
////

siteModule.loadInterfaces();



////
//// The Model objects 
////
//// Load the Server side model objects to handle incoming model actions.
////

siteModule.loadServerModels();
exports.listModels=siteModule.listModels;



////
//// 
//// Load the Client Side models and be sure they are included in the page
//// dependencies.

siteModule.loadClientModels();

*/
