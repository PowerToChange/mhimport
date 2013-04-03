
////
//// ContactImport
////
//// This service will peridocally poll Mission Hub and import new contacts into 
//// the Connect system.
////
////

var color = require('ansi-color').set;
var querystring = require('querystring');
var url = require('url'); // for parsing URLs
var $ = AD.jQuery;
var exec = require('child_process').exec;

var log = AD.Util.Log;
var logDump = AD.Util.LogDump;
var error = AD.Util.Error;
var outputDebugInfo = true;

var pollInProgress = false;

// TODO:  Update these paths to match your installation
var PHP_PATH = '/Applications/MAMP/bin/php/php5.3.6/bin/php';
var SPREADSHEET_LOG_PATH = '/Volumes/data/Sites/PTC/spreadsheetLog.php';
var BATCH_SIZE = 10;
var POLL_INTERVAL = 15 * 1000; // 15 seconds


var powerToChangeContactImport = new AD.App.Service({});
module.exports = powerToChangeContactImport;


var powerToChangeHub = null;   // Module's Notification Center (note: be sure not to use this until setup() is called)
var powerToChangeDispatch = null;  // Module's Dispatch Center (for sending messages among Clients)

// Output debug information only if outputDebugInfo is set to true
var debug = function() {
    if (outputDebugInfo) {
        console.log.apply(this, arguments);
    }
};


//// This is the P2C Mission Hub configuration info:
var missionHubInfo = {
    listContactsURL:'https://www.missionhub.com/api/contacts/',
    headers: {
        'Accept': 'application/vnd.missionhub-v2+json'         // specify v2 responses'
    },
    accessToken:'',  //'b069b6a361bf74e6a6ca07d1b1858d72bd2272688d1fecc442dde6dedd21990f',
    client_id: '',
    client_secret: '',
    org_id: ,
    start_index: 0,  // determines which contact to start next
    batchSize: BATCH_SIZE // The number of contacts retrieved at a time
};



//// This is the P2C Connect configuration info:
var connectInfo = {
    restURL:'',
//    restURL:'http://localconnect.p2c.com/sites/all/modules/civicrm/extern/rest.php',
    
    phpsessid: '',
    apiKey:'',  // arbitrarily set in DB-> civicrm_contact.api_key, match with the row for your user/pass
    user:'',
    pass:'',
    siteKey:'' // from the CIVICRM_SITE_KEY defined in sites/default/civicrm.settings.php
};



////
//// For 2012 we are asking 4 survey Questions:
////   one thing I crave most
////   I'd like a free magazine
////   I'd like to have a chat
////   on my spiritual journey
////
//// These data structures are used to help translate the MH responses to the Connect Values:
////

//// The Survey ID questions translation between MH -> Connect
//// mhid: connect_id
var xlateID = {
    3539: 64,  // one thing I crave most
    3540: 65,  // I'd like a free magazine
    3541: 66,  // I'd like to have a chat
    3542: 67   // on my spiritual journey
};


//// We need to translate the values returned from MH into values 
//// connect is expecting.
var xlateAnswers = {

    // one thing I crave most
    'fun':'warmup-fun',
    'relationship':'warmup-relationship',
    'money':'warmup-money',
    'good grades':'warmup-grades',
    
    // I'd like a free magazine
    'spiritual connection':'magazine-spiritual',
    'a real justice':'magazine-justice',
    'love without conditions':'magazine-love',
    'escape from the dreariness of life':'magazine-escape',
    'achievement & success':'magazine-success',
    'no, thanks':'magazine-no',
    
    // I'd like to have a chat
    '1)Not':'gauge-1',
    '2)':'gauge-2',
    '3)Maybe':'gauge-3',
    '4)':'gauge-4',
    '5)Very':'gauge-5',
    
    // on my spiritual journey
    'explore the deeper meaning of my cravings':'journey-explore',
    'get connected to online resources about my cravings':'journey-online',
    'hear more about Power to Change':'journey-p2c',
    'grow in my relationship with Jesus':'journey-grow',
    'do nothing right now':'journey-nothing' 
};




//-----------------------------------------------------------------------------
powerToChangeContactImport.setup = function() {
    // setup any handlers, subscriptions, etc... that need to have passed in 
    // private resources from the Module:
    //  this.hub = the module's Notification Hub
    //  this.listModels = the list of Model objects in the current Module
    // 
    
    powerToChangeHub = this.module.hub;
    powerToChangeDispatch = this.module.dispatch;
    
/*    
    var multiHandler = function(event, data) {
        console.log('multiHandler! event received['+event+']' );
    }
    powerToChangeHub.subscribe('test.ping', multiHandler);
    AD.Comm.Notification.subscribe('test.ping', multiHandler);
*/    
    

}; // end setup()




////---------------------------------------------------------------------
var hasPermission = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.


    // if viewer has 'powerToChange.contact.import' action/permission
        next();
    // else
        // var errorData = { message:'No Permission' }
        // AD.Comm.Service.sendError(req, res, errorData );
    // end if

};



////---------------------------------------------------------------------
var initData = function(req, res, next) {
    // Setup our initial data for this process
    
    outputDebugInfo = req.query.debug || req.params.debug ? true : false;
    if (outputDebugInfo) {
debug('Debug output enabled');
    }
    
    if (typeof req.aRAD == 'undefined') req.aRAD = {};
    req.aRAD.hasError = false;
    req.aRAD.responseData = {};
    
    req.aRAD.timeStart = Date.now();
    
    next();

};



////---------------------------------------------------------------------
var authMH = function(req, res, next) {
    // authorize us with MissionHub and store our AccessKey in 
    // req.aRAD.accessKey

    

    // we store a copy of our accessToken that we receive after authentication.
    // this accessToken is valid 'until Jesus returns', so if we're still
    // running this process, then he hasn't returned yet ... 
    if (missionHubInfo.accessToken != '') {
        log(req, 'missionHub authentication already found, reusing accessToken');
        req.aRAD.accessToken = missionHubInfo.accessToken;
        next();
        return;
    }
    
    // Need to Authenticate with Mission Hub and get an Access Token:
    var formData = {
        'grant_type': 'none',
        'client_id': missionHubInfo.client_id,
        'client_secret': missionHubInfo.client_secret
    };
    AD.Comm.HTML.post({
         url:'http://www.missionhub.com/oauth/access_token',
         form: formData
     }).done(function(data) {
        // data is a json obj
         
        // save our access token to use for later
        missionHubInfo.accessToken = data.access_token;
        req.aRAD.accessToken = data.access_token;
        log(req, 'Got accessToken from missionHub');

        // continue on to next step
        next();
    });

};



////---------------------------------------------------------------------
var getMHContacts = function (req, res, next) {
    // request a list of new contacts beyond what we have asked for last
    // time.
    
    
//    https://www.missionhub.com/api/contacts/?access_token=***&org_id=1&filters[status]=contacted|attempted_contact|uncontacted&start=0&limit=3

    // if we have an error, then skip to the end
    if (req.aRAD.hasError) {
        next();
        return;
    }
        
    log('start_index: ['+missionHubInfo.start_index+']');
    // Request a list of all our Contacts
    var formData = {
        'org_id': missionHubInfo.org_id,
        'access_token': missionHubInfo.accessToken,
        'start': missionHubInfo.start_index,
        'limit': missionHubInfo.batchSize,
        'order_by': 'date_created,asc'
    };
    var options = {
        url: missionHubInfo.listContactsURL,
        headers: missionHubInfo.headers,
        form: formData
    };
    debug(options);
    AD.Comm.HTML.get(options).done(function(data) {
        
         // data is a json object
debug(data);
         
         log(data);
         
         // save our list of contacts for the next step
         var listContacts = data.contacts;
         req.aRAD.listContacts = listContacts || [];
         
         // now update our start index so we don't get these contacts next go around
         if (listContacts !== undefined) {
             missionHubInfo.start_index += listContacts.length || 0;
         }
         
         // next step in the process
         next();
    }).fail(function(err) {
         // if we have an error
         if (err != null) {
             
             // log it and bail!
             console.log(color('Could not get contacts', 'red+bold'));
             logToSpreadsheet(null, 'Could not get contacts from MissionHub');
             error(req, err);
             req.aRAD.hasError = true;
             next();
        }
    });
    
};



////---------------------------------------------------------------------
var getMHSurveys = function( req, res, next) {
    // for each of the contacts we are working with, get their survey results.
    
    // url: www.missionhub.com/api/v1/contacts/1282204.json?access_token=c11350a517db90d254a264600b2c7f4c84a7925ca160f9320b2e32f4265e46af&org_id=5380
    
    // if we have an error, then skip to the end
    if (req.aRAD.hasError) {
        next();
        return;
    }
    
    
    if (typeof req.aRAD.listContacts == 'undefined') {
        req.aRAD.listContacts = [];
    }
    
    
    // build a list of contact ids from the given list of contacts
    var listIDs = '';
    var listContacts = req.aRAD.listContacts;
    for (var i=0; i<listContacts.length; i++) {
    
        if (listIDs != '') listIDs += ',';
        listIDs += listContacts[i].person.id;
    }
    
    
    // if we have some contacts to work with
    if (listIDs != '') {
    
        // Request a list of all our Contact Details
        var formData = {
            'org_id':  missionHubInfo.org_id,
            'access_token': missionHubInfo.accessToken
        };
        var options = {
            url:'https://www.missionhub.com/api/v1/contacts/'+listIDs+'.json',
            headers: missionHubInfo.headers,
            form: formData
        };
        AD.Comm.HTML.get(options).done(function(data) {
            // data is a json object
debug('options:');
debug(options);
debug('formData: ');
debug(formData);
debug('>>>>>>');
debug(data);
debug('>>>>>>');
             
            var questions = data.questions;
            var listContacts = data.people;
                
debug(listContacts);
for (var li=0; li<listContacts.length; li++) {
    debug('================');
    debug(listContacts[li].person);
    //debug(JSON.stringify(listContacts[li].person));
    debug(listContacts[li].form);
}
            
            // ok, this list of Contacts has more details and includes their form responses,
            // so keep this one instead of the last one:
            req.aRAD.listContacts = listContacts;
            
            req.aRAD.questions = questions;
             
             // next step in the process
             next();
        }).fail(function(err) {
             if (err != null) {
                 error(req, err);
                 req.aRAD.hasError = true;
                 next();
             }
        });
    
    } else {
        next();
    }

    
};



////---------------------------------------------------------------------
var filterMHContacts = function(req, res, next) {
    // Only import contacts that have actually filled out the survey we are concerned with

debug(''); 
debug(''); 
debug(''); 
debug('---------------------------------------'); 
debug(' listContacts: ');
debug(req.aRAD.listContacts);
debug('---------------------------------------');


   
    // new filteredList of contacts
    var filteredList = [];
    
    var listContacts = req.aRAD.listContacts;
    
    // for each contact
    for(var i=0; i< listContacts.length; i++) {
    
        // to keep false
        var toKeep = false;
       
debug(''); 
debug(''); 
debug(''); 
debug('i['+i+']---------------------------------------'); 
debug(listContacts[i]);

        var answers = listContacts[i].form;
        
        // for each answer
        for (var a =0; a< answers.length; a++) {
        
            // if isCurrentSurvey(answer)
            var qid = answers[a].q;
            if ( typeof xlateID[qid] != 'undefined') {
                // keep this contact
                toKeep = true;
            } // end if
        }// next answer
        // if toKeep
        if (toKeep) {

debug('');
debug('>>>>>>>>> Keeping!  Has filled out our survey ... ');
debug('');

            // filteredList.push(contact) 
            filteredList.push(listContacts[i]); 
        }// end if
    } // next
    
    
debug('---------------------------------------'); 
debug(''); 
debug(''); 
debug(''); 
    // req.list = filteredList
    req.aRAD.listContacts = filteredList;
    
    next();


};



//-----------------------------------------------------------------------------
// Return the first object in arr that has a property with the specified name and value
var lookupProperty = function(arr, propertyName, propertyValue, desiredPropertyName) {
    for (var i = 0; i < arr.length; ++i) {
        if (arr[i][propertyName] === propertyValue) {
            return desiredPropertyName ? arr[i][desiredPropertyName] : arr[i];
        }
    }
//debug('No matching property found!');
//debug(arguments);
    return null;
};



////---------------------------------------------------------------------
var convertToConnect = function(req, res, next) {
    // Convert the contact list obtained from MissionHub to the format useable by Connect
    // Return an array of contacts in the Connect format
    var genderMap = {
        'female': 1,
        'male': 2
    };
    var isInternationalMap = {
        'Yes': 'yes',
        'No': 'no'
    };
    
    var ConnectContacts = [];
    var listContacts = req.aRAD.listContacts;
    for (var i = 0; i < listContacts.length; ++i) {
        var contact = listContacts[i];
        var MHContact = contact.person;
        /*
        questions format:
        
        { id: 3549,
 Ê Ê Ê kind: 'ChoiceField',
 Ê Ê Ê label: 'Gender',
 Ê Ê Ê style: 'radio',
 Ê Ê Ê required: null },
 Ê Ê { id: 3548,
 Ê Ê Ê kind: 'ChoiceField',
 Ê Ê Ê label: 'Your Campus',
 Ê Ê Ê style: 'drop-down',
 Ê Ê Ê required: null },
 Ê Ê { id: 6,
 Ê Ê Ê kind: 'ChoiceField',
 Ê Ê Ê label: 'Year in School',
 Ê Ê Ê style: 'drop-down',
 Ê Ê Ê required: false },
 Ê Ê { id: 3545,
 Ê Ê Ê kind: 'TextField',
 Ê Ê Ê label: 'On Campus Residence',
 Ê Ê Ê style: 'short',
 Ê Ê Ê required: null },
 Ê Ê { id: 2523,
 Ê Ê Ê kind: 'TextField',
 Ê Ê Ê label: 'What is your major?',
 Ê Ê Ê style: 'short',
 Ê Ê Ê required: null },
 Ê Ê { id: 3547,
 Ê Ê Ê kind: 'ChoiceField',
 Ê Ê Ê label: 'I am an international student',
 Ê Ê Ê style: 'radio',
 Ê Ê Ê required: null },
 Ê Ê { id: 3481,
 Ê Ê Ê kind: 'TextField',
 Ê Ê Ê label: 'What school do you hope to attend in September?',
 Ê Ê Ê style: 'short',
 Ê Ê Ê required: null } ],
        */
        var questions = req.aRAD.questions;
        var answers = contact.form;
        var questionIds = {
            gender: 3549,           //lookupProperty(questions, 'label', 'Gender', 'id')
            campus: 3548,           //lookupProperty(questions, 'label', 'Your Campus', 'id')
            year: 6,                //lookupProperty(questions, 'label', 'Year in School', 'id')
            degree: 2523,           //lookupProperty(questions, 'label', 'What is your major?', 'id')
            campusResidence: 3545,  //lookupProperty(questions, 'label', 'On Campus residence', 'id')
            isInternational: 3547   //lookupProperty(questions, 'label', 'I am an international student', 'id')
        };
        
debug('answers');
debug(answers);
        
        var gender = MHContact.gender;  // when pulling from survey answers:   lookupProperty(answers, 'q', questionIds.gender, 'a');
        var campus = lookupProperty(answers, 'q', questionIds.campus, 'a');
        var year = lookupProperty(answers, 'q', questionIds.year, 'a');
        var degree = lookupProperty(answers, 'q', questionIds.degree, 'a');
        var campusResidence = lookupProperty(answers, 'q', questionIds.campusResidence, 'a');
        var isInternational = lookupProperty(answers, 'q', questionIds.isInternational, 'a');
debug('Gathered answers');
debug({
    gender: gender,
    campus: campus,
    year: year,
    degree: degree,
    campusResidence: campusResidence,
    isInternational: isInternational
});
        
        var ConnectContact = {};
        ConnectContact.contact_type = 'Individual';
        ConnectContact.contact_sub_type = ['Student'];
        ConnectContact.gender_id = genderMap[gender ? gender.toLowerCase() : null] || null;
        ConnectContact.custom_57 = year;
        ConnectContact.custom_59 = degree;
        ConnectContact.custom_60 = campusResidence;
        ConnectContact.custom_61 = isInternationalMap[isInternational] || null;
        ConnectContact.campus = campus;
        ConnectContact.answers = answers || [];
        ConnectContact.phone_number = MHContact.phone_number || '';
        ConnectContact.email_address = MHContact.email_address || '';
        ConnectContact.date_surveyed = MHContact.date_surveyed || '';
        ConnectContact.first_name = MHContact.first_name || '';
        ConnectContact.last_name = MHContact.last_name || '';
        ConnectContact.external_identifier = MHContact.id; // save the contact's MissionHub id for future identification
        ConnectContacts.push(ConnectContact);
    }
    
    req.aRAD.connectContacts = ConnectContacts;
    next();
};



//-----------------------------------------------------------------------------
var authConnect = function( req, res, next) {

// eg.org/path/to/civi/codebase/civicrm/extern/rest.php?q=civicrm
//   /login&name=user&pass=password&key=yoursitekey&json=1

    // once authenticated with Connect, we will receive a phpsessid back.
    // we store a copy of our phpsessid that we receive after authentication.
    // this needs to be tacked on to the end our our API calls 
    if (connectInfo.phpsessid != '') {

        log(req, 'connect authentication already found, reusing phpsessid');
//        req.aRAD.accessToken = missionHubInfo.accessToken;
        next();
        
    } else {
    
    
        // Need to Authenticate with Mission Hub and get an Access Token:
        var requestData = {
            'q':'civicrm/login',
            name:connectInfo.user,
            pass:connectInfo.pass,
            key:connectInfo.siteKey,
            json:1
        };
debug('requestData:');
debug(requestData);
        AD.Comm.HTML.post({
            url: connectInfo.restURL,
            form: requestData
        }).done(function(data) {
            
debug('Data Returned:');
debug(data);
debug('--------------');
      
            // data is a string here so convert it into a json obj:
            var cdata = /*JSON.parse(data)*/data;
             
            // save our phpsessid to use for later
            connectInfo.phpsessid = cdata.PHPSESSID;
            connectInfo.myKey = cdata.key;
debug('phpsessid:'+connectInfo.phpsessid);
debug('myKey:'+connectInfo.myKey);
    
            // continue on to next step
            next();
        });
    
    }

};



//-----------------------------------------------------------------------------
// Insert all the properties of obj2 into obj1 (like $.extend) and return obj1
var mergeObjects = function(obj1, obj2) {
    for (var i in obj2) {
        obj1[i] = obj2[i];
    }
    return obj1;
};



//-----------------------------------------------------------------------------
var connectAPICall = function(entity, action, info) {
    // Call a connect REST API function and return a deferred promise
    
debug('connectAPICall(): data sent to '+entity+'.'+action+'():');        
debug(info);

    // Request a list of all our Contact Details
    // setup data with our required API connection info
    var postData = {
//        'q': 'civicrm/'+entity+'/'+action,
        json:1,
        sequential:1,
        debug:0,
        PHPSESSID: connectInfo.phpsessid,
        api_key:connectInfo.apiKey,    // arbitrarily set in DB-> civicrm_contact.api_key
//        key:connectInfo.myKey,
        key:connectInfo.siteKey,
        
        rowCount: 1000, // allow more than 25 rows to be returned
        entity: entity,
        action: action
    };
    
    // now merge in function parameters
    mergeObjects(postData, info);
    
    var dfd = $.Deferred();
    AD.Comm.HTML.post({
        url: connectInfo.restURL,
        form: postData
    }).done(function(data) {
debug('connectAPICall('+postData.entity+':'+postData.action+'):  --------------------------');
debug(data);

        // Check for an API error condition
        if (data.is_error) {
            var message = 'Connect API error('+postData.entity+':'+postData.action+'):  '+data.error_message;
            console.log(message);
            dfd.reject(data);
        } else {
            dfd.resolve(data);
        }
    });
    return dfd.promise();
};



//-----------------------------------------------------------------------------
// Return a deferred promise that will resolve to information about the contact's status in the database
//{
//    isNew:
//    reason
//}
var isNewContact = function(contact) {
    
    var dfd = $.Deferred();
    
    // Attempt to lookup this contact by their MissionHub id to determine whether they are already in the database
    // Should these requests run in parallel?
    var MHid = contact.external_identifier;
    debug('Searching for contacts with MH id ['+MHid+']...');
    connectAPICall('Contact', 'get', {external_identifier:MHid}).done(function(existingContacts) {
        if (existingContacts.count > 0) {
            // The contact already exists in the database because at least one contact with this MH id exists
            dfd.resolve({
                isNew: false,
                reason: 'MissionHub id ['+MHid+'] matched existing contact',
                MHid: MHid
            });
        }
        else {
            // Need to make sure we aren't asking for ' ' entries ...
debug('');
debug(' this contact has no existing MissionHub ID : '); 
debug(contact);
            var phone = contact.phone_number.trim();
            var email = contact.email_address.trim();
            debug('Searching for contacts with phone ['+phone+'] or email ['+email+']...');
            
            // Attempt to lookup this contact by their email address or phone number
            // If the phone or email address is not given, resolve to an empty result set instead of executing the query
            var phoneDfd = (phone === '' ? $.Deferred().resolve({count: 0}) : connectAPICall('Phone', 'get', {phone:phone}));
            var emailDfd = (email === '' ? $.Deferred().resolve({count: 0}) : connectAPICall('Email', 'get', {email:email}));
            $.when(phoneDfd, emailDfd).done(function( resultPhone, resultEmail) {
            
debug('   - phone & email lookup complete: resultsPhone['+resultPhone.count+'] resultsEmail['+resultEmail.count+']');
                if ((resultPhone.count>0) || (resultEmail.count>0)) {
                    // A contact with this phone number or email address already exists, so this is not a new contact
                    var reasons = [];
                    var matchedFields = {};
                    if (resultPhone.count>0) {
                        reasons.push('phone number ['+phone+']');
                        matchedFields.phone = phone;
                    }
                    if (resultEmail.count>0) {
                        reasons.push('email address ['+email+']');
                        matchedFields.email = email;
                    }
                    dfd.resolve(mergeObjects({
                        isNew: false,
                        reason: reasons.join(' and ') + ' matched existing contact'
                    }, matchedFields));
                }
                else {
                    dfd.resolve({
                        isNew: true
                    });
                }
            }).fail(dfd.reject);
        }
    });
    
    return dfd.promise();
};



//-----------------------------------------------------------------------------
// Create a new CiviCRM contact and return a deferred promise that will resolve when the creation completes
// The contact is NOT added if it already exists in the database
var newContact = function(contact) {
    
    // url: /civicrm/ajax/rest?json=1&sequential=1&debug=1&&entity=Email&action=create&gender_id=male&first_name=Frodo&last_name=Baggins&contact_type=Individual&contact_sub_type=Student
    
    // Before adding the contact, determine whether this contact is already in the database.  Do not add them if they are.
    var dfd = $.Deferred();
    isNewContact(contact).done(function(contactData) {
        var contactName = contact.first_name+' '+contact.last_name;
        var maxNameLength = 30; // the width of the name column
        var status = '';
        var lineColor = '';
        if (contactData.isNew) {
            status = 'added';
            lineColor = 'green';
            connectAPICall('Contact', 'create', contact).done(dfd.resolve).fail(dfd.reject);
        }
        else {
            status = 'skipped';
            lineColor = 'white';
            dfd.resolve();

            // Log the duplicate
            logToSpreadsheet(contact, contactData.reason);
        }
        // Build the padding string
        var padding = '';
        for (var i = 0; i < maxNameLength - contactName.length; ++i) {
            padding += ' ';
        }
        console.log(color('  -> '+contactName+padding+status+(contactData.reason ? '   '+contactData.reason : ''), lineColor));
    }).fail(dfd.reject);
    return dfd.promise();
};



////---------------------------------------------------------------------
// Create a new CiviCRM email and return a deferred promise that will resolve when the creation completes
var newEmail = function(email) {
    // url: /civicrm/ajax/rest?json=1&sequential=1&debug=1&&entity=Email&action=create&email=myemail@me.com&is_primary=1&contact_id=1
    
    return connectAPICall('Email', 'create', email);
};



////---------------------------------------------------------------------
// Create a new CiviCRM phone and return a deferred promise that will resolve when the creation completes
var newPhone = function(phone) {
    return connectAPICall('Phone', 'create', phone);
};



////---------------------------------------------------------------------
// Create a new CiviCRM survey and return a deferred promise that will resolve when the creation completes
var newSurvey = function(survey) {

    var data = {
        source_contact_id:1,
        target_contact_id:survey.contact_id,
        activity_type_id:32, // petition
        activity_date_time:survey.date,
        subject:'Mission Hub Survey 2012',
        status_id:2,  // completed
        campaign_id:2 // September 2012 launch
    };
    
    
    var arryAnswers = survey.answers;
debug('');
debug('newSurvey():  answers array:');
debug(arryAnswers);

    for (var i=0; i<arryAnswers.length; i++) {
    
        // find the MissionHub ID
        var mhID = arryAnswers[i].q;
        
        // if this is a question we care about:
        if ( xlateID[mhID] !== undefined) {
        
            // add to our data that we are saving as custom_[connect_id] = answer
            data['custom_'+xlateID[mhID]] = xlateAnswers[arryAnswers[i].a];
        }
        else if(mhID == 5140){
            data['custom_83'] = arryAnswers[i].a;
        }
    }

    // make the call
debug('');

debug('newSurvey(): sending this data for survey input:');
debug(data);
    return connectAPICall('Activity', 'create', data);
};



////---------------------------------------------------------------------
var newRelationship = function(relationship) {
    // Create a new CiviCRM relationship and return a deferred promise that 
    // will resolve when the creation completes
    return connectAPICall('Relationship', 'create', relationship);
};

// name:id for quickly looking up school id's by name
var schoolIdCache = null;


////---------------------------------------------------------------------
var loadSchoolCache = function(req, res, next) {
    // Create the school cache
    
    if (schoolIdCache !== null) {
        // The school cache has already been created (or creation is in progress)
        next();
    }
    else {
        // The school id cache needs to be created
        schoolIdCache = {};
        connectAPICall('Contact', 'get', {
            contact_type:'Organization',
            contact_sub_type:'School'
        }).done(function(data) {
            var schools = data.values;
            for (var i = 0; i < schools.length; ++i) {
                var school = schools[i];
                schoolIdCache[school.display_name] = school.id;
            }
            
debug('school id cache:');
debug(schoolIdCache);
    
            next();
        });
    }
};



////---------------------------------------------------------------------
var importContact = function( currentContact, cb) {
    
    var importDfd = $.Deferred();
    
    // create new Contact info (get contact_id back)
    newContact(currentContact).done(function(data) {
    
        // data will be undefined if the contact already existed and was not actually created
        if (data && data.values) {
            var message;
        
            var connectID = data.values[0].id; // id of the new contact in the Connect database
            currentContact.connectID = connectID;
            var dateSurveyed = new Date(/^\d+\-\d+\-\d+/.exec(currentContact.date_surveyed)[0]); // extract the date from the timestamp
            
            // Convert the date to the yyyy-mm-dd format
            dateSurveyed = dateSurveyed.getUTCFullYear()+'-'+(dateSurveyed.getUTCMonth()+1)+'-'+dateSurveyed.getUTCDay();
            
            // create an email entry
            var emailDfd = newEmail({
                email:currentContact.email_address,
                is_primary:1,
                contact_id:connectID
            });
            var phoneDfd;
            var phoneNumber = currentContact.phone_number;
            if (!phoneNumber) {
                // The 'phone number' question was not answered
                message = 'No phone number specified';
                debug(message);
                phoneDfd = $.Deferred().reject({is_error:true, error_message:message});
            }
            else {
                // create a phone entry
                phoneDfd = newPhone({
                    phone:phoneNumber,
                    isPrimary:1,
                    contact_id:connectID
                });
            }
                        
            var surveyDfd = newSurvey({
                date:dateSurveyed,
                answers:currentContact.answers,
                contact_id:connectID
            });
            
            var relationshipDfd;
            var campus = currentContact.campus;
            var schoolId = schoolIdCache[campus];
            if (!campus) {
                // The 'campus' question was not answered
                message = 'No campus specified';
                debug(message);
                relationshipDfd = $.Deferred().reject({is_error:true, error_message:message});
            }
            else if (typeof schoolId === 'undefined') {
                message = 'Unrecognized campus given ['+campus+']'
                console.log(color(message+'!', 'red+bold'));
                relationshipDfd = $.Deferred().reject({is_error:true, error_message:message});
            }
            else {
                // Relate the contact to the university that they are attending
                relationshipDfd = newRelationship({
                    relationship_type_id:10, // Student Currently Attending
                    contact_id_a:connectID,
                    contact_id_b:parseInt(schoolId) // convert the string to an integer
                });
            }

            // Sorry this is so ugly.  We need to know when all deferreds are complete.  
            // $.when().done() doesn't work because done() is called when all are resolved;
            // if any are rejected, fail() is called immediately.
            // Whether resolved or rejected, we want the data.  
            // This seemed to be the best way to get it.
            emailDfd.always(function(email) {
                phoneDfd.always(function(phone) {
                    surveyDfd.always(function(survey) {
                        relationshipDfd.always(function(relationship) {
                            // All deferreds are now complete
                            
                            // Any errors?  Test for error properties, then the deferred state
                            var failure = [];
                            if (email && email.is_error) failure.push('email ['+email.error_message+']');
                            else if (emailDfd.state() == "rejected") failure.push('email');
                            if (phone && phone.is_error) failure.push('phone ['+phone.error_message+']');
                            else if (phoneDfd.state() == "rejected") failure.push('phone');
                            if (survey && survey.is_error) failure.push('survey ['+survey.error_message+']');
                            else if (surveyDfd.state() == "rejected") failure.push('survey');
                            if (relationship && relationship.is_error) failure.push('relationship ['+relationship.error_message+']');
                            else if (relationshipDfd.state() == "rejected") failure.push('relationship');

                            var message = '';
                            if (failure.length > 0) {
                                message = "Warning: "+failure.join(', ');
                                console.log(message);
                                importDfd.reject();
                            } else {
                                // All OK
                                importDfd.resolve();
                                if (cb) cb();
                            }
                            logToSpreadsheet(currentContact, message);
                        });
                    });
                });
            });
        }
        else {
            // This should represent a duplicate.  Pretend it's OK
            importDfd.resolve();
            if (cb) cb();
        }    
    }).fail(function (data) {
        var message = (data && data.error_message) ? '['+data.error_message+']' : '';
        logToSpreadsheet(currentContact, "Failed to create Contact in Connect "+message);
        importDfd.reject();
    });

    return importDfd.promise();

};

// Log a contact to the Google Spreadsheet
var logToSpreadsheet = function (contact, errorMsg) {
debug('!!! Log to spreadsheet');
    var formData = {};
    if (contact) {
        formData = {
            'mhid' :  contact.external_identifier,
            'connectid': contact.connectID,
            'first':  contact.first_name,
            'last' :  contact.last_name,
            'email':  contact.email_address,
            'campus': contact.campus
        };
    }
    
    
    if (errorMsg) {
        formData.error = errorMsg;
    }
    
    
    // There are two ways to do kick off the PHP script.
    // The first executes the script as command line.
    // The first one might be easiest.
    var useDirectPhpCall = false;
    
    if (useDirectPhpCall) {
        var php = PHP_PATH;
        var script = SPREADSHEET_LOG_PATH;
        var args = '';
        
        
        // Build the args string
        for (var key in formData) {
            if (formData[key] !== undefined) {
                args += '"'+key+'='+formData[key]+'" ';
            }
        }
    
        // Execute the PHP script
        var child = exec(php+' '+script+' '+args, function(error, stdout, stderr) {
debug('!!! contact/message logged!');            
        });
    } else {
        // The second triggers the script as an HTML GET
        // I experienced problems getting this to work on the localhost
        // due to conflicts with the locally-hosted Connect.
        var options = {
            url:'http://cravings.powertochange.com/spreadsheetLog.php',
            form: formData
        };
    
        AD.Comm.HTML.post(options).done(function(data) {
debug('!!! contact logged!');            
        });        
    }

};

////---------------------------------------------------------------------
var importToConnect = function( req, res, next) {
    // take our converted data and import them into connect
    
    // url: www.missionhub.com/api/v1/contacts/1282204.json?access_token=c11350a517db90d254a264600b2c7f4c84a7925ca160f9320b2e32f4265e46af&org_id=5380
    
    // if we have an error, then skip to the end
    if (req.aRAD.hasError) {
        next();
        return;
    }
    

    var listImportContacts = req.aRAD.connectContacts;
    
console.log('');
console.log('--------------------------------------------');
console.log('importToConnect, attempting to process ['+ listImportContacts.length + '] contacts ... ');

    if (listImportContacts.length === 0) {
        // There are no contacts to import, so advance to the next step
        next();
        return;
    }

    // foreach contact
    var contactsImported = 0;
    for(var i=0; i<listImportContacts.length; i++) {
        var currentContact = listImportContacts[i];
debug('... attempting to create a new Contacts for:');
debug(currentContact);

        importContact(currentContact).always(function() {
        
            ++contactsImported;
            debug('contact '+contactsImported+' of '+listImportContacts.length+' imported');
            if (contactsImported === listImportContacts.length) {
                // The last contact has finished importing, so advance to the next function in the service stack
                next();
            }
        });

    }
    
};




////
////  Setup our timed operation:
////  call our own URL at a given time Interval
////
(function() {
    // Enclose in a self calling function to prevent pollution of the global namespace
    var siteURL = url.parse('http://localhost:8088');
    if (siteURL.pathname === '/') {
        siteURL.pathname = '';
    }
    var serviceURL = url.format({
        protocol: siteURL.protocol,
        hostname: siteURL.host,
        pathname: siteURL.pathname+'/power2change/contact/import'
    });
    
    // Make a GET request to this service (/power2change/contact/import)
    var importContacts = function() {
        if (!pollInProgress) {
            pollInProgress = true;  // Block the next poll until complete
            AD.Comm.HTML.get({
                url: serviceURL+'?poll=true',
                headers: {
                    'Accept': 'application/json'
                }
            });
        }
    };
    setInterval(importContacts, POLL_INTERVAL); // import the contacts every poll interveral
})();


var contactStack = [
//        AD.App.Page.serviceStack,  // authenticates viewer, and prepares req.aRAD obj.
    hasPermission,      // make sure we have permission to access this
    initData,           // setup our initial data for this process
    authMH,                // authorize us with MH
    getMHContacts,         // get a list of all Contacts from MH
    getMHSurveys,        // get the survey info for all new MH contacts
    filterMHContacts,   // only work with the contacts that have filled out our desired survey
    convertToConnect,    // convert data into Connect format
    authConnect,        // authorize us with Connect
    loadSchoolCache,    // load the list of schools from the database
    importToConnect        // import converted data to Connect
];

var totalCount = 0;



////---------------------------------------------------------------------
app.all('/power2change/contact/import', contactStack, function(req, res, next) {
    // test using: http://localhost:8088/power2change/contact/import

    var endTime = Date.now();
    var elapsedTimeMS = endTime - req.aRAD.timeStart;
    var contactCount = req.aRAD.connectContacts.length;
    var timePerContact = contactCount === 0 ? 0 : Math.floor(elapsedTimeMS / contactCount);
    
    console.log('');
    console.log('--------------------------------------------');
    console.log('elapsed time: '+elapsedTimeMS+'ms for '+contactCount+' contacts; '+timePerContact+'ms per contact');
    
    
    // By the time we get here, all the processing has taken place.
    totalCount++;
    
    logDump(req, 'finished contact/import ['+totalCount+']');
    
    if (req.query.poll) {
        pollInProgress = false;
    }
    
    // send a success message
    var successStub = {
        message:'done.',
        responseData: req.aRAD.responseData 
    };
    AD.Comm.Service.sendSuccess(req, res, successStub );
    
});
