////
//// Labels
////
//// This model is the interface to the site_multilingual_label table.


(function () {
	  var onServer = false;
	  if (typeof exports !== 'undefined') {
	      // exports are defined on the server side node modules
	      onServer = true;
	  } 
	  
	  var attr = {
	      // Client Definitions
          _adModule:'site',
          _adModel:'Labels',
          id:'label_id',
          labelKey:'label_label',
          _isMultilingual:false 
      }
      
      if (onServer) {
          // Server Definitions
          attr['__serverModel'] = {
              type:'single',  // 'single' | 'multilingual'
              dbTable:'site_multilingual_label',
              model: {
		          label_id:"int(11) unsigned",
		          language_code:"varchar(10)",
		          label_key:"text",
		          label_label:"text",
		          label_lastMod:"datetime",
		          label_needs_translation:"tinyint(1) unsigned",
		          label_path:"text",

              },
              primaryKey:'label_id'
          }
      }
	  
	  
	  AD.Model.extend("site.Labels",
	  attr,
	  {
		  // define instance methods here.
	  });

	  if (onServer) {
		  module.exports = AD.Model.List["site.Labels"];
	  }

})()