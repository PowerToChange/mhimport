//// Template Replace:
//   testunit     : the name of this interface's module: (lowercase)
//   test  : the name of this interface :  (lowercase)
//   Test  : the name of this interface :  (Uppercase)


////
//// Test
////
//// This is the Interface level definition for the Test page.
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



var testInterface = new AD.App.Interface({
    pathInterface: __dirname,
    testPath: '/test/',
/*
    pathModules: __dirname + '/containers',
    pathScripts: __dirname+'/scripts',
    pathServices: __dirname+'/services',
*/
    listWidgets: [ 
// AppRAD: WIDGET DEPENDENCY //    
                 ]
    });
module.exports = testInterface;   

////
//// View Routes
////

var app = testInterface.app;

////
//// setup any /testunit/test specific routes
////

//// this route is for returning the javascript dependencies for this page
app.get('/init/testunit/test/test.js', function(req, res, next) {

    //// We are returning our dependencies to our dependency manager (steal)
    //// We need to return 
    ////    listJavascripts:  our javascript functions 
    ////    listCSS:          our css dependencies
    ////    nameSetupFunction: the name of our client side javascript setup
    ////                      function.
    //// 
    req.aRAD.response.pathLabels = 'labels/testunit/test/labels.js';
    req.aRAD.response.nameSetupFunction = 'ad.testunit.test.radsetup';
    AD.App.Page.addJavascripts( req, testInterface.getJavascripts() );
    AD.App.Page.returnStealData(req, res);
});



//// this route is for returning the labels for this page
app.get('/labels/testunit/test/labels.js', AD.Lang.loadLabelsByPath, function(req, res, next) {

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
    listLabelPaths.push('/page/testunit/test');
    
    // gather all the labels required by our included widgets:
    for (var iLw = 0; iLw < testInterface.listWidgets.length; iLw++) {
        
        var key = testInterface.listWidgets[iLw];
        
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

var parseInner = function (path, excldirs, req) {

	
}

var parseDirs = function (path, excldirs, req) {
	
    var systemDir = fs.readdirSync(__appdevPath+path);

	for (var i=0, maxcount=systemDir.length; i<maxcount; i++) {
		var systemName = systemDir[i];
    	var systemPath = path + '/' + systemName;

    	if (systemName[0] != '.') {
	        // parse subdirectories
	        var stat = fs.lstatSync(__appdevPath+systemPath);
	        if (stat.isDirectory()) {
	        	//skip excluded directories
	        	var flag = 0;
	        	for (var ii=0, maxc=excldirs.length; ii<maxc; ii++) {
	        		var exclName = excldirs[ii];

	        		if (systemPath+'/' == exclName) 
	        			flag = 1;
	        	}
	    		//skip hidden directories
	    		if (flag == 0)  {
	    			var parse = parseDirs(systemPath, excldirs, req);
	    		}
	        } else {
	        	// skip non .js entries
	            if (systemPath.indexOf('.js') == -1)
	                continue;
	        	req.aRAD.response.unittestresults['notests'].push({
		            'type': 'tests',
		            'name': systemName,
		            'path': systemPath,
		            'installed': 0,
		            'readonly': 0
		        });
	        }
    	}
    }
	return;
}

app.get('/page/testunit/test', AD.Lang.loadLabelsByPath, function (req, res, next) {

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
    
    req.aRAD.response.pathTemplate = __dirname+'/views/testInterface.ejs';
//    req.aRAD.response.themePageStyle = 'empty';  // 'default': default Template Style, 'empty':empty Template Style   
    
    var viewer = AD.Viewer.currentViewer(req);
    req.aRAD.response.labels.langKey = viewer.language_code;
    
    
    req.aRAD.response.templateData = { title:'testInterface', labels:req.aRAD.response.labels };
    
    
    // if we need to add javascripts to the page 
    // (that don't already get included via the steal system)
    // then do: 
    // req.aRAD.response.listJavascripts.push('path/to/script.js');
    req.aRAD.response.pathSteal = '/init/testunit/test';
    
    
    // make sure we load our CSS information
    AD.App.Page.addCSS( req, testInterface.getCSS() );
      
    req.aRAD.response.unittestresults = {
            tests: [],
    		notests: []
        }
    
    var systemDir = fs.readdirSync(__appdevPath+testInterface.testPath);
    for (var count=0; count<systemDir.length; count++) {
        var systemName = systemDir[count];
        var systemPath = testInterface.testPath+systemName;
        // skip non .js entries
        if (systemName.indexOf('.js') == -1) {
            continue;
        }
        // skip directories
        var stat = fs.lstatSync(__appdevPath+systemPath);
        if (stat.isDirectory()) {
            continue;
        }
        req.aRAD.response.unittestresults['tests'].push({
            'type': 'tests',
            'name': systemName,
            'path': systemPath,
            'installed': 0,
            'readonly': 0
        });
    }
    
    var excludeDir = fs.readFileSync(__appdevPath + '/docbuildexcl.txt', 'utf8');
    var excldirs = excludeDir.split('\n');
    parseDirs('', excldirs, req);
    
    req.aRAD.response.templateData = { 
            title: 'Unit Testing Module', 
            labels: req.aRAD.response.labels ,
            systems: {
                'Available Tests': req.aRAD.response.unittestresults['tests'],
                'Create Tests': req.aRAD.response.unittestresults['notests']
            }
        };
    
    //// The AD.js -> AD.App.Page.returnPage() routine is responsible for  
    //// taking this interface's data and wrapping it in our Site Template. The 
    //// response is returned there.
    req.aRAD.returnPage( req, res );
    
});




/*
 * You can override the default setup routine by uncommenting this and 
 * making changes:
 * 
testInterface.setup = function(callback) 
{
    var $ = AD.jQuery;
    var dfd = $.Deferred();

    //// 
    //// Scan any sub containers to gather their routes
    ////
    var dfdContainers = testInterface.loadContainers();
    
    
    //// 
    //// Scan for any services and load them
    ////
    var dfdInterfaces = testInterface.loadServices();
    

    ////
    //// Resolve the deferred when done
    ////
    $.when(dfdContainers, dfdInterfaces).then(function() {
        callback && callback();
        dfd.resolve();
    });
    
    return dfd;
}

*/
