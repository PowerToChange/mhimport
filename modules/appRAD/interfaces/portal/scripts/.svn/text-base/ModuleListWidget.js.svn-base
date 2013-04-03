/**
 *  Setup the Module List Widget
 */

steal('//appDev/widgets/appdev_list_searchable_new/appdev_list_searchable_new.js').then(function() {

    // Keep all variables and functions inside an encapsulated scope
    (function() {
    
    
        //// Setup Widget:
        AppdevListSearchableNew.extend('ModuleListWidget', {
    
            
            init: function (el, data) {
            	
            	data.template = '<span class="list-label">[%= this.getLabel() %]</span>';
          //  	data.templateEdit = '<input type="text" class="input" placeholder="Module">';
                this._super(el, data);
            },
            onSelection:function(item) {
                
            	if (item != null) {
	                AD.Comm.Notification.publish('apprad.module.selected', item);
	                AD.Comm.Notification.publish('apprad.panel.show', {name:'module'});
            	}
            }
            
        });
        
    }) ();

});
