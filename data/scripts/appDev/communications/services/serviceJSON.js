    // v1.0
    // 
    // serviceJSON.js
    //
    // our Service JSON objects provide a mechanism for determinining if a 
    // viewer's login authentication has expired and then requiring them to 
    // re-authenticate before continuing on with the request.
    // 
    //
    
    AppDev.ServiceJSON = {

        /**
         * @class AD.serviceJSON
         * @parent services
         * Post an Ajax request synchronously.
         */
        postSync: function(options) {
            options['sync'] = true;
            AppDev.ServiceJSON(options);
        },

    
        /**
         * @class AppDev.ServiceJSON.post()
         * @parent AD.serviceJSON
         * Post an Ajax request asynchronously.
         * 
         * @param string options['url']
         *    The URL to post the request to.
         * @param object options['params']
         *    An associative array of field names and values to post.
         * @param function options['complete']
         *    The callback function to execute after the request is completed,
         *    before checking whether or not it succeeded or failed.
         * @param function options['success']
         *    The callback function to execute if the request is successful.
         * @param function options['failure']
         *    The callback function to execute if the request failed.
         * @param jQuery options['messageBox']
         *    jQuery selection of the message box to display any error messages
         *    in. If not specified, then a dialog box will be used.
         * @param string options['showErrors']
         *    "ON", "OFF", or "AUTO". Default is AUTO.
         *    Auto means errors will be shown unless a failure callback is
         *    provided.
         */
        post: function(options) {
            // Default is async, but you can specify 'sync: true' in the options
            // to change to sync mode instead.
            var asyncMode = true;
            if (options.sync) {
                asyncMode = false;
            }
            
            // Automatically fail if the login window is visible
            if ((typeof AD.winLogin.isVisible != 'undefined') 
                && (AppDev.winLogin.isVisible())) {
                
                if ($.isFunction(options['complete'])) {
                    options.complete();
                }
                if ($.isFunction(options['failure'])) {
                    options.failure();
                }
                return;
            }

            return $.ajax({
                async: asyncMode,
                url: options['url'],
                type: 'POST',
                dataType: 'json',
                data: options['params'],
                cache: false,
                error: function(req) {
                    // Serious error where we did not even get a JSON response
                    AppDev.displayMessage(
                        "Error:<br/>"+req.responseText,
                        options['messageBox']
                    );
                    // Execute failure callback
                    if ($.isFunction(options['failure'])) {
                        options.failure(req.responseText);
                    }
                },
                success: function(data) {
                    if ($.isFunction(options['complete'])) {
                        options.complete();
                    }
                
                    // Got a JSON response but was the service action a success?
                    if (data.success && (data.success != 'false')) {
                        // SUCCESS!
                        if ($.isFunction(options['success'])) {
                            // Execute the optional success callback
                            options.success(data);
                        }
                        return;
                    }
                    // FAILED
                    else {
                        var errorID = data.errorID;
                        // Authentication failure (i.e. session timeout)
                        if (errorID == 55) {
                            // Reauthenticate
                            AppDev.winLogin.show(
                                // Re-post the service request
                                function() {
                                    AppDev.ServiceJSON.post(options);
                                }
                            );
                            return;
                        }
                        // Some other error
                        else {
                            var showErrors = options['showErrors'];
                            
                            // Execute the optional failure callback
                            if ($.isFunction(options['failure'])) {
                                options.failure(data);
                                // Turn off showErrors if it wasn't enabled
                                // explicitly.
                                if (!showErrors || showErrors == 'AUTO') {
                                    showErrors = 'OFF';
                                }
                            } 
                            // No failure callback given
                            else if (!showErrors || showErrors == 'AUTO') {
                              // Turn on showErrors if it wasn't disabled
                              // explicitly.
                              showErrors = 'ON';
                            }
                            
                            // Display error message if needed
                            if (showErrors == 'ON') {
                                var errorMSG = data.error;
                                if (!errorMSG) { errorMSG = "Error"; }
                                AppDev.displayMessage(
                                    errorMSG,
                                    options['messageBox']
                                );
                            }
                            return;
                        }
                    } // failed
                }
                
            }); // ajax()
        
        } // post
        
    } // AppDev.ServiceJSON