////
//// [module].[service]
////
//// This is an object to manage the interaction with the [module].[service] service.


(function () {
	  var onServer = false;
	  if (typeof exports !== 'undefined') {
	  // exports are defined on the server side node modules
	      onServer = true;
	  } 
	  
	
	  
	  if (!onServer) {
		  
		  var attr = {
		      // Client Definitions
				_adModule:'[module]',
				_adService:'[service]',
				_adAction:'[action]',
				_adModel: [ModelName], // each row of data is an instance of this Model [optional] if not specified, need label & id below: 
				_urlCreate: '[urlCreate]',
				labelKey:'[labelKey]', // field to use as label 
				id:'[idKey]'  		   // field to use as ID
		  };
		  
		  AD.Service.extend("[module].[service]",
			  attr,
			  {
			  // define instance methods here.
			  });
	  }
})()
