/**
 *  Setup the Install Files List Widget
 */

steal('//appDev/widgets/appdev_list_searchable_new/appdev_list_searchable_new.js').then(function() {

    // Keep all variables and functions inside an encapsulated scope
    (function() {
    
    
        //// Setup Widget:
        AppdevListSearchableNew.extend('InstallFilesListWidget', {
    
            
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
            'apprad.module.install.updated subscribe': function(message, data) {
                // data should be { name:'[moduleName]' }
                this.module = data.name;
                this.findAll({module: data.name});
            }

            
        });
        
    }) ();

});
