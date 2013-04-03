/**
 *  Setup the View List Widget
 */

steal('//appDev/widgets/appdev_list_searchable_new/appdev_list_searchable_new.js').then(function() {

    // Keep all variables and functions inside an encapsulated scope
    (function() {
    
    
        //// Setup Widget:
        AppdevListSearchableNew.extend('ViewListWidget', {
    
            
            init: function (el, data) {
                
                this._super(el, data);
                this.module = null;
                this.interface = null;
            },
            onSelection:function(item) {
                item.module = this.module;
                item.interface = this.interface;
                item.view = item.name;
                AD.Comm.Notification.publish('apprad.interface.view.selected', item);
            },
            'apprad.interface.selected subscribe': function(message, data) {
                // data should be { name:'[interfaceName]' }
                this.module = data.module;
                this.interface = data.name;
                this.findAll({
                    module: this.module, 
                    interface: this.interface
                });
            },
            'apprad.interface.controller.selected subscribe': function(message, data) {
                this.clearSelection();
            },
        });
        
    }) ();

});
