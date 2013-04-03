////
//// Switcheroo
////
//// This model is the interface to the site_viewer_switcheroo table.


(function () {
	  var onServer = false;
	  if (typeof exports !== 'undefined') {
	      // exports are defined on the server side node modules
	      onServer = true;
	  } 
	  
	  var attr = {
	      // Client Definitions
          _adModule:'site',
          _adModel:'Switcheroo',
          id:'switcheroo_id',
          labelKey:'switcheroo_realID',
          _isMultilingual:false 
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'single',  // 'single' | 'multilingual'
              dbTable:'site_viewer_switcheroo',
              model: {
		              switcheroo_id:"int(11) unsigned",
		              switcheroo_realID:"text",
		              switcheroo_fakeID:"text",

              },
              primaryKey:'switcheroo_id'
          }
      }
	  
	  
	  AD.Model.extend("site.Switcheroo",
	  attr,
	  {
		  // define instance methods here.
	  });

	  if (onServer) {
		  module.exports = AD.Model.List["site.Switcheroo"];
	  }

})()