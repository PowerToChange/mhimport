/**
 *  Setup the Add Module Service Form
 */

    // Keep all variables and functions inside an encapsulated scope
    (function() {
    
    
        //// Setup Widget:
        $.Controller.extend('ModuleAddServiceForm', {

            
            init: function (el, data) {
                this.data = {};
                this.data.moduleName = null;
                this.data.serviceName = '';
                this.data.ServiceName = '';
                this.data.actionName = '';
                this.data.url = '';
                
                // Initialize the form elements
            },
            'apprad.module.selected subscribe': function(message, data) {
                this.data.moduleName = data && data.name;
            },
            'input change': function(el) {
                var serviceName = this.element.find('#moduleServiceName').val();
                var actionName = this.element.find('#moduleActionName').val();
                
                this.element.find('#moduleDefaultUrl').html('/'+this.data.moduleName+'/'+serviceName+'/'+actionName);
            },
            '#moduleAddServiceButton click': function(el) {
                
                // Collect the necessary information
                var data = {};
                var serviceName = this.element.find('#moduleServiceName').val();
                var actionName = this.element.find('#moduleActionName').val();
                var serviceUrl = this.element.find('#moduleCustomUrl').val();
                
                // Create a regular expression to ensure only numbers, letters, and underscores
                var parseName = /^([A-Za-z][0-9A-Za-z_]+)$/;
                // Another RegEx for simple URLs
                var parseUrl = /^(((\/)?[A-Za-z][0-9A-Za-z]+)+)$/;
                if ((serviceName !== '') && (actionName !== '') 
                    && parseName.test(serviceName) && parseName.test(actionName)
                    && ((serviceUrl === '') || parseUrl.test(serviceUrl)) ){
                    
                    // We have all the necessary information
                    
                    // Format the service name correctly; 
                    // we need first character uppercase & lowercase
                    this.data.serviceName = serviceName[0].toLowerCase()+serviceName.slice(1);
                    this.data.ServiceName = serviceName[0].toUpperCase()+serviceName.slice(1);
                    
                    // Action name should be lowercase, too
                    this.data.actionName = actionName[0].toLowerCase()+actionName.slice(1);
                    
                    // Remove an initial '/'
                    if (serviceUrl[0] == '/') {
                        serviceUrl = serviceUrl.slice(1);
                    }
                    this.data.url = serviceUrl;
                    
                    var _self = this;

                    // Make the request from the server
                    var onSuccess = function(response) {
                        AppDev.alert('Model created!');
                        var item = {
                                module:_self.data.moduleName, 
                                name:_self.data.serviceName, 
                                action:_self.data.actionName
                        };
                        AD.Comm.Notification.publish('apprad.module.service.created', item);
                    };
                    
                    var onError = function() {
                        AppDev.alert('Error creating model');
                    
                    };
                    AppDev.ServiceJSON.post({
                        url:'/appRad/module/service/create',
                        params:this.data,
                        success:onSuccess,
                        failure: onError
                    });
                } else {
                    // Missing some information
                    AppDev.alert('Missing or Invalid Information');
                }
            }
        });
        
    }) ();

