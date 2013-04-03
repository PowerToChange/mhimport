/**
 *  Setup the Install Files List Widget
 */

steal('//appDev/widgets/appdev_list_searchable_new/appdev_list_searchable_new.js').then(function() {

    // Keep all variables and functions inside an encapsulated scope
    (function() {
    
    
        //// Setup Widget:
        AppdevListSearchableNew.extend('ModuleWidgetListWidget', {
    
            
            init: function (el, data) {
                data.showSearchBar = false;
                
                this._super(el, data);
                this.module = null;
            },
            'apprad.module.selected subscribe': function(message, data) {
                // data should be { name:'[moduleName]' }
                this.module = data.name;
                this.findAll({module: data.name});
            },
            'apprad.module.widget.created subscribe': function(message, data) {
                // data should be { module:'[moduleName]' }
                this.module = data.module;
                this.findAll({module: data.name});
            }

            
        });
        
    }) ();

});
