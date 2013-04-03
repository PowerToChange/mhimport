
////
//// Portal
////
//// This is the Interface level definition for the Portal page.
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



var portalInterface = new AD.App.Interface({
        pathInterface: __dirname,   

        listWidgets: [  
                      'appdev_list_searchable_new',
                      'appdev_list_select',
                      'appdev_codemirror'
// AppRAD: WIDGET DEPENDENCY //    
                 ]
    });
module.exports = portalInterface;    
    

////
//// View Routes
////

var app = portalInterface.app;


////
//// setup any /appRAD/portal specific routes
////

//// this route is for returning the javascript dependencies for this page
app.get('/init/appRAD/portal/portal.js', function(req, res, next) {

    //// We are returning our dependencies to our dependency manager (steal)
    //// We need to return 
    ////    listJavascripts:  our javascript functions 
    ////    listCSS:          our css dependencies
    ////    nameSetupFunction: the name of our client side javascript setup
    ////                      function.
    //// 
    req.aRAD.response.pathLabels = 'labels/appRAD/portal/labels.js';
    req.aRAD.response.nameSetupFunction = 'ad.appRAD.portal.radsetup';
    AD.App.Page.addJavascripts( req, portalInterface.getJavascripts() );
    AD.App.Page.returnStealData(req, res);
});



////this route is for returning the labels for this page
app.get('/labels/appRAD/portal/labels.js', AD.Lang.loadLabelsByPath, function(req, res, next) {

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
    listLabelPaths.push('/page/appRAD/portal');
    
    // gather all the labels required by our included widgets:
    for (var iLw = 0; iLw < portalInterface.listWidgets.length; iLw++) {
        
        var key = portalInterface.listWidgets[iLw];
        
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



app.get('/page/appRAD/portal', AD.Lang.loadLabelsByPath, function (req, res, next) {

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
    
    req.aRAD.response.pathTemplate = __dirname+'/views/portal.ejs';
    
    var viewer =  AD.Viewer.currentViewer(req);
    req.aRAD.response.labels.langKey = viewer.language_code;
    
    req.aRAD.response.templateData = { title:'portal', labels:req.aRAD.response.labels };
    
    // if we need to add javascripts to the page 
    // (that don't already get included via the steal system)
    // then do: 
    // req.aRAD.response.listJavascripts.push('path/to/script.js');
    
    req.aRAD.response.pathSteal = '/init/appRAD/portal';
    
    AD.App.Page.addCSS( req, portalInterface.getCSS() );
    
    //// The app.js -> returnPage() routine is responsible for taking this 
    //// interface's data and wrapping it in our Site Template.  The 
    //// response is returned there.
    req.aRAD.returnPage( req, res );
    
});






//// 
//// Scan any sub interfaces to gather their routes
////
portalInterface.loadContainers();




//// 
//// Scan for any services and load them
////
portalInterface.loadServices();


