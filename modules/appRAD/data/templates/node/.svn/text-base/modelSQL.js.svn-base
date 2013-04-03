////
//// [ModelName]
////
//// This model is the interface to the [tableName] table.


(function () {
	  var onServer = false;
	  if (typeof exports !== 'undefined') {
	      // exports are defined on the server side node modules
	      onServer = true;
	  } 
	  
	  var attr = {
	      // Client Definitions
          _adModule:'[module]',
          _adModel:'[ModelName]',
          id:'[primaryKey]',
          labelKey:'[labelKey]',
          _isMultilingual:false 
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'single',  // 'single' | 'multilingual'
              dbName:'[dbName]',
              dbTable:'[tableName]',
              model: {
[propertyList]
              },
              primaryKey:'[primaryKey]'
          }
      }
	  
	  
	  AD.Model.extend("[module].[ModelName]",
	  attr,
	  {
		  // define instance methods here.
	  });

	  if (onServer) {
		  module.exports = AD.Model.List["[module].[ModelName]"];
	  }

})()