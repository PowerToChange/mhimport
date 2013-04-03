////
//// appRAD.Interfaces
////
//// This is an object to manage the interaction with the appRAD.Interfaces service.


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
				_adService:'module',
				_adAction:'list',
//				_adModel: [ModelName]  // <-- the data returned is not associated with any Model obj
				_adUrl:'/appRAD/module/widgets/list',
				labelKey:'name',
				id:'name'  // the field that is the id of the data
		  };
		  
		  AD.Service.extend("appRAD.ModuleWidgets",
			  attr,
			  {
			  // define instance methods here.
			  });
	  }
})()
