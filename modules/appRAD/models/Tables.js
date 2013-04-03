////
//// appRAD.Tables
////
//// This is an object to manage the interaction with the appRAD.Tables service.


(function () {
	  var onServer = false;
	  if (typeof exports !== 'undefined') {
	  // exports are defined on the server side node modules
	      onServer = true;
	  } 
	  
	
	  
	  if (!onServer) {

		  var attr = {
		      // Client Definitions
				_adModule:'appRAD',
				_adService:'database',
				_adAction:'list',
//				_adModel: [ModelName]  // <-- the data returned is not associated with any Model obj
				_adUrl:'/appRAD/model/tables/list',
				labelKey:'name',
				id:'name'  // the field that is the id of the data
		  };
		  
		  AD.Service.extend("appRAD.Tables",
			  attr,
			  {
			  // define instance methods here.
			  });
	  }
})()
