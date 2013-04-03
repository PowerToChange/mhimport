//// Template Replace:
//   site     : the name of this interface's module: (lowercase)
//   componentManager  : the name of this interface :  (lowercase)
//   ComponentManager  : the name of this interface :  (Uppercase)


/**
 * @class componentManager
 * @parent site
 *
 * This is the admin Component Manager interface.
 */
 

////
//// ComponentManager
////
//// This is the Interface level definition for the ComponentManager page.
////
//// An "interface" is usually a new page displayed in the browser, 
//// requiring a full page load.  
////
//// An interface is required to load:
////    listJavascripts :  all the javascript files required for this page
////    listCSS : any css files required for this page
////    pathTemplate: the path from the site root to the template file to 
////                  use to render the page content
////    templateData: an object representing all the data to use to render 
////                  the template for this page content


var installer = require('installerTools.js');


var componentManagerInterface = new AD.App.Interface({
    pathInterface: __dirname,
/*
    pathModules: __dirname + '/containers',
    pathScripts: __dirname+'/scripts',
    pathServices: __dirname+'/services',
*/
    listWidgets: [ 
// AppRAD: WIDGET DEPENDENCY //    
                 ]
    });
module.exports = componentManagerInterface;   

////
//// View Routes
////

var app = componentManagerInterface.app;

////
//// setup any /site/componentManager specific routes
////

//// this route is for returning the javascript dependencies for this page
app.get('/init/site/componentManager/componentManager.js', function(req, res, next) {

    //// We are returning our dependencies to our dependency manager (steal)
    //// We need to return 
    ////    listJavascripts:  our javascript functions 
    ////    listCSS:          our css dependencies
    ////    nameSetupFunction: the name of our client side javascript setup
    ////                      function.
    //// 
    req.aRAD.response.pathLabels = 'labels/site/componentManager/labels.js';
    req.aRAD.response.nameSetupFunction = 'ad.site.componentManager.radsetup';
    AD.App.Page.addJavascripts( req, componentManagerInterface.getJavascripts() );
    AD.App.Page.returnStealData(req, res);
});



//// this route is for returning the labels for this page
app.get('/labels/site/componentManager/labels.js', AD.Lang.loadLabelsByPath, function(req, res, next) {

    //// We are initializing a set of labels associated with this 
    //// Interface.
    ////
    //// load the req object with this interface's path
    //// and let the app.js -> returnLabelData() handle the response.
    //// 
    req.aRAD.response.pathInterface = 'test/viewer/';
    
    
    //// gather a list of all the label paths for this interface:
    var listLabelPaths = [];
    
    // Our basic page interface set:
    listLabelPaths.push('/page/site/componentManager');
    
    // gather all the labels required by our included widgets:
    for (var iLw = 0; iLw < componentManagerInterface.listWidgets.length; iLw++) {
        
        var key = componentManagerInterface.listWidgets[iLw];
        
        // if a site widget then pull label info from ListWidgets
        if (typeof ListWidgets[key] != 'undefined') {
            
            var widget = ListWidgets[key];  // defined in app.js
            for (var i=0; i < widget.listLabels.length; i++) {
                var labelPath = widget.listLabels[i];
                listLabelPaths.push(labelPath);
            }
            
        } else {
            
            // look locally for a widget
        
        }
    }
    req.aRAD.response.listLabelPaths = listLabelPaths;
    AD.App.Page.returnLabelData(req, res);
});



app.get('/page/site/componentManager', AD.Lang.loadLabelsByPath, function (req, res, next) {

    //// We are displaying our interface page.  We need to define the 
    //// following:
    ////    pathTemplate : the template to display in the 'content' portion
    ////                   of our siteContent.ejs template
    ////    templateData : any data to send to our template.
    ////                   {
    ////                        key1:value1,
    ////                        key2:value2,
    ////                        ....
    ////                        keyN:valueN
    ////                    }
    ////                    can be referenced in our pathTemplate.ejs file 
    ////                    as <%= data.keyN %>
    ////    listJavascripts : list any javascripts that can be loaded 
    ////                    outside of the steal dependency manager.  
    ////                    (eg only javascripts that do not need to be 
    ////                    loaded before your siteInterfaceRADSetup() is 
    ////                    called.)
    ////    listCSS :       list any css files that can be loaded outside of
    ////                    the steal dependency manager.
    ////    pathSteal:      the url to use for the steal dependency manager.
    ////                    the data returned should be a list of all the 
    ////                    javascript files necessary to load before your
    ////                    setup() routine is called.
    
    req.aRAD.response.pathTemplate = __dirname+'/views/componentManager.ejs';
//    req.aRAD.response.themePageStyle = 'empty';  // 'default': default Template Style, 'empty':empty Template Style   
    
    var viewer = AD.Viewer.currentViewer(req);
    req.aRAD.response.labels.langKey = viewer.language_code;
    
    
    // if we need to add javascripts to the page 
    // (that don't already get included via the steal system)
    // then do: 
    // req.aRAD.response.listJavascripts.push('path/to/script.js');
    req.aRAD.response.pathSteal = '/init/site/componentManager';
    
    
    // make sure we load our CSS information
    AD.App.Page.addCSS( req, componentManagerInterface.getCSS() );
    
    
    installer.findSystems(function(allsystems, modules, themes, widgets) {
        
        // Set all widgets to "installed" and read-only.
        // Widgets cannot be enabled or disabled. They are listed here
        // only for informational purposes.
        for (var i=0; i<widgets.length; i++) {
            widgets[i]['readonly'] = 1;
            widgets[i]['installed'] = 1;
        }
        
        // Make the "site" module read-only.
        for (var i=0; i<modules.length; i++) {
            if (modules[i]['name'] == 'site') {
                modules[i]['readonly'] = 1;
                break;
            }
        }
    
        req.aRAD.response.templateData = { 
            title: 'componentManager', 
            labels: req.aRAD.response.labels ,
            systems: {
                'modules': modules,
                'themes': themes,
                'widgets': widgets
            }
        };
            
        //// The AD.js -> AD.App.Page.returnPage() routine is responsible for  
        //// taking this interface's data and wrapping it in our Site Template. 
        //// The response is returned there.
        req.aRAD.returnPage( req, res );

    });
    
});




