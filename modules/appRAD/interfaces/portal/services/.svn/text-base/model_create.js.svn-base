
////
//// Model Create
////
//// This service is created to handle requests to generate new Model 
//// definitions for a Module.
////
////    /appRad/model/create   : tableName=X, module=Y, ModelName=Z, primaryKey=K, labelKey=L
////        Creates a new model from DB table X  under application Module Y
////
////


var myDB = require('database.js').sharedDB();


////
//// Setup the Model Template Definitions:
////
     


var listTemplatesModel = {
    '/modules/appRAD/data/templates/node/modelSQL.js':{
            data:'',
            destDir:'/modules/[module]/models/[ModelName].js',
            userManaged:false
    }
};
    



var listTemplatesMultilingual = {
    '/modules/appRAD/data/templates/node/modelSQLMultilingual.js':{
        data:'',
        destDir:'/modules/[module]/models/[ModelName].js',
        userManaged:false
    }
};
    
    



////---------------------------------------------------------------------
var hasPermission = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.


    // if viewer has 'appRAD.Developer' action
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

}



////---------------------------------------------------------------------
var loadDBTableInfo = function (req, res, next, nameField) {
    // attempt to load the db table info from the provided
    // tableName parameter.
    
    var dbName = AD.Defaults.dbName;
    if (typeof req.aRAD.$_REQUEST.dbName != 'undefined') {
        dbName = req.aRAD.$_REQUEST.dbName;
    }
    
    var tableName = '';
    if (typeof req.aRAD.$_REQUEST[nameField] != 'undefined') {
        tableName = req.aRAD.$_REQUEST[nameField];
    }
    
    // if no tableName given
    if (0 == tableName.length) {
    
        AD.Util.Log(req, 'no tableName:');
        AD.Util.Log(req, 'nameField['+nameField+']');
        AD.Util.Log(req, 'REQUEST:');
        AD.Util.Log(req, req.aRAD.$_REQUEST);
        AD.Util.Log(req, '  ');

        AD.Comm.Service.sendError(req, res, {errorData:nameField+' not found ['+tableName+']'} );
        
    } else {

        var sql = 'DESCRIBE '+dbName+'.'+tableName;
        myDB.query(sql, [], function(err, results, fields) {
        
            if (err) {
            
            	AD.Util.Log(req, err);
                var errorData = {
                    err: err
                };
                
                AD.Comm.Service.sendError(req, res, errorData );
                
            } else {
               
                if (typeof req.aRAD == 'undefined') req.aRAD = {};
                if (typeof req.aRAD.service == 'undefined') req.aRAD.service = {};
                req.aRAD.service[''+nameField]=results;
                next();
            }
        
        });
        
    } // end if tableName found

}



////---------------------------------------------------------------------
var propertyList = function( req, name) {

    // the property list is created from the sql table description:
    var propertyList = '';
    var results = req.aRAD.service[name];
    for (var ri=0; ri < results.length; ri++) {
        var type = simpleType(results[ri].Type);
        propertyList += '		              '+results[ri].Field + ':"' + type + '",\n';
        
    }
    
    return propertyList;

}



////---------------------------------------------------------------------
var simpleType = function (type) {
    // take the given db field type and return a simpler version for our
    // framework to use:
    
    
    // get info before '('
    // switch part0
    //      case 'varchar':
    //      case 'text':
    //          return 'text';
    //      break;
    //      case float:
    //      case int:
    //          return 'number';
    //      case date
    //      case datetime
    //          return 'date';
    // end switch
    
    return type;
}



////---------------------------------------------------------------------
var initData = function (req, res, next) {
    // Gather the required Data for this operation.
    
    
    var hasMissingData = false;
    var missingData = '';
    
    
    
    
    // a list of the required tags necessary in order to complete the
    // templates.  These tags should be supplied via the service call:
    var listTags = {
        module:'?module?',
        ModelName:'?ModelName?',
        dbName:AD.Defaults.dbName,
        tableName:'?tableName?',
        primaryKey:'?primaryKey?',
        labelKey:'?labelKey?'
        
    };
    

    //// Build the DB property List:
    listTags.propertyList= propertyList(req, 'tableName' );
    
    var ignoreFields = {'propertyList':''};
    
    
    
    
    // load Template tags for this model
    for (var ti in listTags) {
    
        if (typeof ignoreFields[ti] == 'undefined') {
            
            if (typeof req.aRAD.$_REQUEST[ti] != 'undefined') {
                listTags[ti] = req.aRAD.$_REQUEST[ti];
            } else if (ti != 'dbName') {
                hasMissingData = true;
                missingData += ti +', ';
            }
            
        }
    }
    
    
    
    // if we have some missing tags 
    if (hasMissingData) {
    
        // respond with an error
        AD.Comm.Service.sendError(req, res, { errorMSG: 'missing parameters:['+missingData+']'} );
        
        
    } else {
    
        templateToolModel.saveValues(req, listTags);
    
        next();
    
    } 
    

}



////---------------------------------------------------------------------
var initMLData = function (req, res, next) {
    // Gather the required Data for this operation.
    
    
    
    // a list of the required tags necessary in order to complete the
    // templates.  These tags should be supplied via the service call:
    var listTags = {
        module:'?module?',
        ModelName:'?ModelName?',
        dbName:AD.Defaults.dbName,
        tableNameData:'?tableNameData?',
        propertyListData:'?propertyListData?',
        tableNameTrans:'?tableNameTrans?',
        propertyListTrans:'?propertyListTrans?',
        listMultilingualFields:'?listMultilingualFields?',
        primaryKey:'?primaryKey?',
        labelKey:'?labelKey?'
        
    };
    

    
    var hasMissingData = false;
    var missingData = '';
    
    
    
    var ignoreFields = {'propertyListData':'', 'propertyListTrans':''};
    
    
    
    
    // load Template tags for this model
    for (var ti in listTags) {
    
        if (typeof ignoreFields[ti] == 'undefined') {
            
            if (typeof req.aRAD.$_REQUEST[ti] != 'undefined') {
                listTags[ti] = req.aRAD.$_REQUEST[ti];
            } else if (ti != 'dbName') {
                hasMissingData = true;
                missingData += ti +', ';
            }
            
        }
    }
    
    
    
    // if we have some missing tags 
    if (hasMissingData) {
    
        // respond with an error
        AD.Comm.Service.sendError(req, res, { errorMSG: 'missing parameters:['+missingData+']'} );
        
        
    } else {
    
    
    
        //  listMultilingualFields = 'fieldname1,fieldname2,...,fieldnameN'
        var mlFields = listTags['listMultilingualFields'].split(',');
        var listFields = '';
        for (var mlfI=0; mlfI < mlFields.length; mlfI++){
            if (listFields != '')  listFields += ",";
            listFields += "'"+mlFields[mlfI]+"'";
        }
        listTags.listMultilingualFields = listFields;
        
        
    
        //// Build the DB property List:
        // the property list is created from the sql table description
        listTags.propertyListData= propertyList(req, 'tableNameData' );
        listTags.propertyListTrans= propertyList(req, 'tableNameTrans' );
        


        // save our data for the template tools 
        templateToolMLModel.saveValues(req, listTags);
        
        
        // everything ok, so continue
        next();

    
    } 
    

}





// be sure to run through these filters before accessing our Create
// Model service:

//// Create our Template Tools object
var TemplateTools = require('./objects/templateTools.js');
var templateToolModel = new TemplateTools({
    listTemplates:listTemplatesModel,
});


var preLoadDBInfo = function (req, res, next) { 
    loadDBTableInfo(req, res, next, 'tableName'); 
}
var createTemplates = function (req, res, next) { templateToolModel.createTemplates(req, res, next); }

var modelStack = [
        AD.App.Page.serviceStack,
        hasPermission,  // make sure we have permission to access this
        preLoadDBInfo,  // prepare the DB Table Info 
        initData,       // prepare data (name & listTags)    
        createTemplates,// create all the expected Templates
        ];
        





// be sure to run through these filters for Create Multilingual
// Model service:

//// Create our Template Tools object
var templateToolMLModel = new TemplateTools({
    listTemplates:listTemplatesMultilingual,
});

var preLoadDBInfoData = function (req, res, next) { 
    loadDBTableInfo(req, res, next, 'tableNameData'); 
}
var preLoadDBInfoTrans = function (req, res, next) { 
    loadDBTableInfo(req, res, next, 'tableNameTrans'); 
}
var createMLTemplates = function (req, res, next) { templateToolMLModel.createTemplates(req, res, next); }


var multilingualStack = [
        AD.App.Page.serviceStack,
        hasPermission,      // make sure we have permission to access this
        preLoadDBInfoData,  // load the Data table info
        preLoadDBInfoTrans, // load the Trans table info
        initMLData,         // prepare data (name & listTags) (Multilingual)    
        createMLTemplates,  // create all the expected Templates
    ];
        



//Asynchronously Load our Model templates when this service is loaded.
for (var ti in listTemplatesModel) {

    var path = __appdevPath+ti;
    templateToolModel.loadTemplate(ti, path, listTemplatesModel);
    
}


//Asynchronously Load our Multilingual templates when this service is loaded.
for (var ti in listTemplatesMultilingual) {

    var path = __appdevPath+ti;
    templateToolMLModel.loadTemplate(ti, path, listTemplatesMultilingual);
    
}


exports.setup = function(app) {

    ////---------------------------------------------------------------------
    app.all('/appRad/model/create', modelStack, function(req, res, next) {
        //// Creates a new model from DB table X  under application Module Y
        // test using: http://localhost:8085/appRad/model/create?module=test&ModelName=Settings&tableName=site_settings&primaryKey=settings_id&labelKey=settings_label
    
        
        // By the time we get here, all the processing has taken place.
    
        AD.Util.LogDump(req, 'finished');
        
        
        // send a success message
        AD.Comm.Service.sendSuccess(req, res, {message:'all model templates written.' } );
    });
    
    ////---------------------------------------------------------------------
    app.all('/appRad/modelmultilingual/create', multilingualStack, function(req, res, next) {
        //// Creates a new model from DB table X  under application Module Y
        // test using: http://localhost:8085/appRad/modelmultilingual/create?module=test&ModelName=VisaType&tableNameData=hris_visatype_data&tableNameTrans=hris_visatype_trans&primaryKey=visatype_id&listMultilingualFields=visatype_label&labelKey=visatype_label
    
    
        // By the time we get here, all the processing has taken place.
    
        AD.Util.LogDump(req, 'finished');
        
        
        // send a success message
        AD.Comm.Service.sendSuccess(req, res, {message:'all model templates written.' } );
        
        
    });
    
}