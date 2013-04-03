
////
//// Send Mail
////
//// Send an email with the SMTP server securemail.zteam.biz port 25
    // test using: usage:

	// send an email with; 	Email Subject: 'hi'
	//						Email Body: 'hello'
	//						From: 'appdev@zteam.biz'
	//						To: 'ineo@zteam.biz'

	// 		url?from=appdev@zteam.biz&to=ineo@zteam.biz&subject=hi&body=hello



////---------------------------------------------------------------------
var hasPermission = function (req, res, next) {
    // Verify the current viewer has permission to perform this action.


    // if viewer has 'appRAD.Developer' action
        next();
    // else
        // var errorData = { message:'No Permission' }
        // ResponseService.sendError(req, res, errorData );
    // end if

}


var trim = function (str) {
    return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
};


// Supposed to be like the PHP isset()
var isset = function(thing) {
    if (typeof thing == 'undefined') {
        return false;
    }
    return true;
}


/**
 * Go through an Express req object and return a PHP $_REQUEST style
 * assosiative array.
 *
 * Priority:
 *  1. req.params -- from the path
 *  2. req.body   -- from POST
 *  3. req.query  -- from GET
 *
 * @param object req
 * @return object
 *      Associative array like $_REQUEST
 */
var parseReqParams = function(req) {
    
    var $_REQUEST = {};
    var sets = [ 'params', 'body', 'query' ];
    for (var i=0; i<sets.length; i++) {
        for (var paramName in req[ sets[i] ]) {
            if (!isset($_REQUEST[ paramName ])) {
                $_REQUEST[ paramName ] = req[ sets[i] ][ paramName ];
            }
        }
    }
    
    return $_REQUEST;
}


////---------------------------------------------------------------------
var initData = function (req, res, next) {
    // Gather the required Data for this operation.

    var $_REQUEST = parseReqParams(req);
    var sender = $_REQUEST['from'];
    var recipient = $_REQUEST['to'];
    var subject = $_REQUEST['subject'];
    var body = $_REQUEST['body'];
    var smtpuser = $_REQUEST['user'];
    var smtppass = $_REQUEST['pass'];

    
    if (!recipient || !body) {
        Log(req, '  - error: some data not provided body['+body+'] to['+recipient+']');
        LogDump(req, '');

        ResponseService.sendError(req, res, {errorMSG:'some data not provided body['+body+'] to['+recipient+']'} );
        return;
    }

    else {
                
        req.aRAD.sender = sender;
        req.aRAD.recipient = recipient;
        req.aRAD.subject = subject;
        req.aRAD.body = body;
        req.aRAD.smtpuser = smtpuser;
        req.aRAD.smtppass = smtppass;
        
        console.log(req.aRAD);
        next();
    }
    
}


//send email
var sendMail = function(req, res, next) {
 
// To Do
	var sender = req.aRAD.sender;
	var recipient = req.aRAD.recipient;
	var subject = req.aRAD.subject;
	var body = req.aRAD.body;
	var smtpuser = req.aRAD.smtpuser;
	var smtppass = req.aRAD.smtppass;

	AD.Comm.Email.sendMail(req, res, {
		 to: recipient,
		 from: sender,
		 subject: subject,
		 body: body,
		 //smtpuser: smtpuser,
		 //smtppass: smtppass
	});
      
	AD.Comm.Service.sendSuccess(req, res, { 
        message:            
         'Mail sent.'
 } );
	
}



//// perform these actions in sequence:
var moduleStack = [
        hasPermission,  // make sure we have permission to access this
        initData,
        sendMail // send email
        ];
        
        
////---------------------------------------------------------------------
app.all('/site/email/send', moduleStack, function(req, res, next) {
    
    // by the time we enter this, we should have done all our steps
    // for this operation.
    LogDump(req,'  - finished');
    
    // send a success message
    ResponseService.sendSuccess(req, res, {message:'Mail sent!' } );
    
});
