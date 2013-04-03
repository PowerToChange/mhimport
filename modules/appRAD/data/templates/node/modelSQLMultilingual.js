////
//// [ModelName]
////
//// This model is the interface to the [tableNameData] table.


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
          _isMultilingual:true
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'multilingual',  // 'single' | 'multilingual'
              dbName:'[dbName]',
              tables:{
                  data:'[tableNameData]',
                  trans:'[tableNameTrans]'
              },
              fields: {
                  data: {
  [propertyListData]
                  },
                  trans: {
  [propertyListTrans]
                  
                  }
              },
              primaryKey:'[primaryKey]',
              multilingualFields: [[listMultilingualFields]]
          };
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