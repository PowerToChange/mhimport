/**
 * @class AD_Client
 * @parent index 5
 * 
 * ###Client side global AD namespace.
 *
 * This file defines standard functions and calls for appDev
 * objects on the client side.
 */

// Create our Namespace
AD = AppDev =  {};
//AD = AppDev; //// short version AppDev for lazy programmers like me.

/**
 * Repository for javascript based labels.
 */
AppDev.labels = {};
/**
 * Repository for javascript based labels.
 */
AppDev.listLabels = {};

//// TODO: refactor how we do labels/listLabels ...


steal(
    // Disable socket.io because it conflicts with the Faye websocket implementation
    /*'//../../../socket.io/socket.io.js',*/
	'//jquery-ui.min.js',
    '//appDev/communications/services/serviceJSON.js',
    '//appDev/communications/notificationCenter/notificationCenter.js',
    '//appDev/communications/siteDispatch/siteDispatch.js',
    '//appDev/model/model.js',
    '//appDev/model/service.js',
    '//appDev/lang/multilingual.js',
    '//appDev/lang/xlation.js',
    '//appDev/model/serviceModel.js',
    '//appDev/model/listManager.js').then(function($) {


    //------------------------------------------------------------
    /**
     * @function setListLabel
     *
     * Sets the value for a listLabel
     * @codestart
     * [keyList][id]=[label]
     * @codeend
     *
     * @param {String} keyList
     *      the unique key for which list of labels we are dealing with
     *      usually the primary key of the table (like persontype_id )
     * @param {String} id
     *      the primary key value of an entry
     * @param {String} label
     *      the label to display for that value
     * @return void
     */
    AppDev.setListLabel = function (keyList, id, label) 
    {
        
        if (typeof(AppDev.listLabels[keyList]) == 'undefined') {
            AppDev.listLabels[keyList] = { id:label };
            return;
        }
        
        AppDev.listLabels[keyList][id] = label;

    }



    //------------------------------------------------------------
    /**
     * @function listLabel
     *
     * Returns the value for a listLabel
     * @codestart
     * [keyList][id]
     * @codeend
     *
     * @param {String} keyList
     *    the unique key for which list of labels we are dealing with
     *    usually the primary key of the table (like persontype_id )
     * @param (String} id
     *    the primary key value of an entry
     * @param {String} defaultValue
     *    the label to display for that value
     * @return {String}
     */
    AppDev.listLabel = function (keyList, id, defaultValue) 
    {

        if (typeof(AppDev.listLabels[keyList]) == 'undefined') {
            return defaultValue;
        }
        
        if (typeof(AppDev.listLabels[keyList]) == 'undefined') {
            return defaultValue;
        }
        
        return AppDev.listLabels[keyList][id];

    }



    // 
    // An extend function for creating subclasses of other objects
    //
    // extend( nameOfChildObject, nameOfParentObject)
    //
    AppDev.extend = function(subClass, baseClass) {
                           function inheritance() {}
                           inheritance.prototype = baseClass.prototype;

                           subClass.prototype = new inheritance();
                           subClass.prototype.constructor = subClass;
                           subClass.baseConstructor = baseClass;
                           subClass.superClass = baseClass.prototype;
                        }
                        


    //
    // More user friendly substitute for the Javascript alert() box.
    //
    AppDev.alert = {};
    $(document).ready(function() {

        // Find the alert box provided by the site template
        var $alertBox = $('#appDev-alert');
        // Or build the alert box from scratch if the template didn't provide one
        if ($alertBox.length == 0) {
            var alertBoxHTML = '\
    <div id="appDev-alert" button_label="OK">\
      <div class="alert-message"></div>\
    </div>';
            $alertBox = $(alertBoxHTML);
        }
        
        // Init the OK button
        var alertButtons = {};
        alertButtons[$alertBox.attr('button_label')] = function() {
            $alertBox.dialog('close');
        };
        
        // Init the alert box with jquery-ui
        var alertBoxTimeout = null;
        $alertBox.dialog({
            autoOpen: false,
            modal: true,
            buttons: alertButtons,
            close: function() {
              if (alertBoxTimeout) {
                  clearTimeout(alertBoxTimeout);
                  alertBoxTimeout = null;
              }
            }
        });
        
        /**
         * @function alert
         *
         * Display an alert dialog box.
         * @param string message
         * @param string/object options
         *    This can be a string, to set the title of the dialog box.
         *    Or it can be an object of options to pass directly to the jquery
         *    dialog function.
         */
        AppDev.alert = function(message, options) {

            if (alertBoxTimeout) {
                // Cancel any previously set timeout
                clearTimeout(alertBoxTimeout);
                alertBoxTimeout = null;
            }

            if ($.isPlainObject(options)) {

                // Can set a timeout that closes the dialog automatically
                if (options['timeout']) {
                    options.open = function() {
                        alertBoxTimeout = setTimeout(AppDev.hideAlert, options['timeout']);
                    }
                } else {
                    options.open = null;
                }
            
                $alertBox.dialog('option', options);
            } 
            
            else {
                $alertBox.dialog('option', { 'title' : options });
            }

            // Set the message
            $alertBox.find('.alert-message').html(message);
            $alertBox.dialog('open');
        }


        /**
         * Close the alert dialog box.
         */
        AppDev.hideAlert = function() {
            $alertBox.dialog('close');
        }

    });


    /**
     * @function displayMessage
     *
     * Display a message inside a DIV
     * @param string message
     *    The message HTML to display.
     * @param string/jQuery target
     *    The string ID of the DIV, or a jQuery selection of the DIV.
     */
    AppDev.displayMessage = function(message, target) {

        // If no target specified, then fallback to using a dialog box
        if (!target) {
            AppDev.alert(message);
            return;
        }
      
        var $target;
      
        // Check if target is a string
        if (target.toLowerCase) {
            $target = $('#'+target);
        } 
        // Otherwise assume target is a jQuery object
        else {
            $target = target;
        }
      
        $target
          .html(message)
          .slideDown();
    }


    /**
     * @function hideMessage
     *
     * Hide a message that was displayed
     * @param string/jQuery target
     *    The string ID of the DIV, or a jQuery selection of the DIV.
     */
    AppDev.hideMessage = function(target) {

        if (!target) {
            // If no target given, then hide the alert box assuming it is
            // currently visible.
            AppDev.hideAlert();
        }
        
        else if (target.toLowerCase) {
            // target is an ID string
            $('#'+target).hide();
        }
        
        else {
            // target is a jQuery object
            target.hide();
        }

    }



    AppDev.timeoutFixDialogUI = null;
    /**
     * @function fixDialogUI
     *
     * jQueryUI dialogs don't let you use HTML inside their buttons and will
     * convert all HTML tags into plaintext. This converts them back into
     * proper HTML.
     *
     * This function will keep on repeating every 5 seconds to check for any new
     * dialogs added dynamically.
     */
    AppDev.fixDialogUI = function() {
      // Cancel any other pending calls to this function
      if (AppDev.timeoutFixDialogUI) {
        clearTimeout(AppDev.timeoutFixDialogUI);
        AppDev.timeoutFixDialogUI = null;
      }

      // Process all dialog titles that have not been fixed yet.
      $('.ui-dialog[pdOK!=1]').each(function() {
        var $dialog = $(this);
        // Dialog titles are completely stripped of HTML tags, but we can
        // work around that by embedding the label_id in the dialog's DIV
        // in the PHP template.
        //
        // *** ACTION POINT FOR THE PROGRAMMER: ***
        // When you create the HTML code for a dialog box, add a "label_id"
        // attribute to the overall DIV for the dialog. This label_id will be
        // used here to make the dialog title translatable.

        // Check to see if this dialog has the label_id embedded.
        var labelID = $dialog.find('.ui-dialog-content').attr('label_id');
        if (labelID) {
          var $title = $dialog.find('.ui-widget-header .ui-dialog-title').eq(0);
          var titleText = $title.text();
          $title.html('<span><span class="puxLabel pdLabel" label_id="'+labelID+'">'+titleText+'</span></span>');
        }
        
        // Process the button panes in this dialog.
        $dialog.find('.ui-dialog-buttonpane').each(function() {
          var $buttonPane = $(this);
          // Process all the buttons in this pane.
          $buttonPane.find('button .ui-button-text').each(function() {
            var $button = $(this);
            var buttonText = $button.text();
            // Button text seems to have HTML tags
            if (buttonText.match(/<\/\w+>/)) {
              // Make the button reinterpret the text as HTML.
              $button.html(buttonText);
            }
          });
        });


        // Never process this dialog again.
        $dialog.attr('pdOK', 1);
      });
      
      // Repeat in 5 seconds
      AppDev.timeoutFixDialogUI = setTimeout(AppDev.fixDialogUI, 5000);
      
    }
    $(document).ready(function() {
      // Begin the cycle
      AppDev.timeoutFixDialogUI = setTimeout(AppDev.fixDialogUI, 2000);
    });



    /**
     * @function switchLanguage
     *
     * Switch the language labels on the current page.
     * @param string  destLangCode
     *    The language code of the language to switch the page to:
     * @param string  urlAction
     *    The urls of the services that will handle the language switch
     */
    AppDev.switchLanguage = function (destLangCode, urlAction, idBusyDiv) {

        var $busyDiv = $('#'+idBusyDiv);
        $busyDiv.showCount = 0;
        $busyDiv.layeredShow = function () {
                if (this.showCount == 0) {this.show()}
                this.showCount = this.showCount + 1;
            }
        $busyDiv.layeredHide = function() {
                this.showCount = this.showCount -1;
                if (this.showCount <= 0) { this.hide() }
            }
            
        $busyDiv.layeredShow();
        
        
        var idString = '';
        var delme='';
        // for each on page label (marked as a 'pdLabel')
        $('.pdLabel').each(function () {
            
                if (idString != '') {idString = idString+','}
                
                idString = idString + $(this).attr('label_id');

            });
            
            
        var onSuccess = function(response) {
            
            // Note:  a little performance data on using vs not using 
            //        these lists:
            //          no optimaztions: 2491ms
            //          listActivator optimazation only: 2331ms
            //          listActivator & listLabel optimizations: 1352ms
            
    //        var startTime = new Date().getTime();
            
            var $listActivators = $('.puxActivator');
            var $listLabels = $('.pdLabel');
            
            // foreach data item
            for( id in response.data) {
            
                // find the matching '.pdLabel' label_id=id
                var $label = $listLabels.filter('[label_id='+id+']');
                if ($label) {
                    // update html with lable
                    $label.html( response.data[id].label );
                    
                    // update label_id=newID
                    $label.attr('label_id', response.data[id].id);
                    
                    // now update any puxTool activators
                    if ($listActivators.length > 0) {
                        var activator = $listActivators.filter('[label_id='+id+']');
                        if (activator.length) {
                            activator.attr('label_id', response.data[id].id);
                        }
                    }
                }
                
                // update any labels stored in the AppDev context
                if (typeof(AppDev.labels[response.data[id].key]) != 'undefined') {
                    AppDev.labels[response.data[id].key] = response.data[id].label;
                }
            }        
            
    //        var endTime = new Date().getTime();
    //        var time = endTime - startTime;

            
            $busyDiv.layeredHide();
            
        }
        
        var onError = function() {
            AppDev.alert('onError ['+destLangCode+']['+idString+']');
            $busyDiv.layeredHide();
        
        }
        var values = {};
        values['listIDs'] = idString;
        values['langCode'] = destLangCode;
        var service = AppDev.ServiceJSON.post({
                        url:urlAction.labelUpdate,
                        params:values,
                        success:onSuccess,
                        failure: onError
                    });
                    
                    
                    
                    
        ////
        //// OK, now spawn updates for each of the multilingual drop lists
        ////
        var $listMultilingualSelects = $('select[pdMLSelect="Y"]');
        $listMultilingualSelects.each( function () {
        
            $busyDiv.layeredShow();
            
            var thisSelect = $(this);
            
            var onSelectSuccess = function(response) {
            
                for(id in response.data.labels) {
                    
                    var label = response.data.labels[id];
                    
                    var option = thisSelect.find('option[value=\''+id+'\']');
                    if (option) {
                        option.html(label);
                    }
                    
                    // now we store this list data in AppDev.labels.lists
                    AppDev.setListLabel(thisSelect.attr('fieldname'), id, label);

                }
           
                $busyDiv.layeredHide();
            }
            
            
            var onSelectError = function (response) {
            
                $busyDiv.layeredHide();
            }
            
            
            var selectValues = {};
            selectValues['t'] = thisSelect.attr('pdMLTable');
            selectValues['langCode'] = destLangCode;
            var service = AppDev.ServiceJSON.post({
                            url:urlAction.selectUpdate,
                            params:selectValues,
                            success:onSelectSuccess,
                            failure: onSelectError
                        });
        });
        
    }



    ///////////////////////////////////////////////////////////////////////
    /**
     * @class winLogin
     * @parent AD_Client
     *
     * This object managed the Re-Login authentication form, which appears
     * when the user initiates an Ajax request after the session has timed
     * out.
     *
     * Its behaviour is different depending on the authentication method.
     * Currently `local` and `CAS` methods are supported. This setting
     * must be stored in a global variable `appDev_authMethod` early on in
     * the page loading sequence.
     */
    AppDev.winLogin = {};
    $(document).ready(function() {
      
      // CAS re-authentication popup
      if (appDev_authMethod == 'CAS') {
        var isVisible = false;
        var $loginForm;
        var loginCallback;
        var interval;
        
        /**
         * @function isVisible
         * 
         * Returns whether or not the Re-Login form is currently visible on
         * the screen.
         *
         * @return {Boolean}
         */
        AppDev.winLogin.isVisible = function() {
            return isVisible;
        };
        
        /**
         * @function done
         *
         * Used in CAS authentication, for the child iframe containing the
         * CAS login page to report back when it has finished.
         */
        AppDev.winLogin.done = function() 
        {
            clearInterval(interval);
            var frameWindow = $loginForm.get(0).contentWindow;
            if (frameWindow && !frameWindow.closed) {
                // Try to stop MSIE from complaining about us closing
                // this iframe that we ourselves opened.
                frameWindow.open('about:blank', '_self', '');
                frameWindow.close();
            }
            $loginForm.dialog('close');
            $loginForm.remove();
            isVisible = false;
            if ($.isFunction(loginCallback)) {
                loginCallback();
            }
        };
        
        /**
         * @function show
         * 
         * Display the Re-Login form on the screen.
         * 
         * @param {Function} callback
         *    (optional) The function to execute one the session has been
         *    successfully reauthenticated.
         */
        AppDev.winLogin.show = function(callback) 
        {
            isLoginFormVisisble = true;
            loginCallback = callback;
            
            // This is a page that will force CAS authentication and then
            // close itself.
            var url = '/page/cas/frame-auth';
            $loginForm = $("<iframe src='" + url + "' width='100%' height='100%'>");
            $loginForm.dialog({
                'title': 'Re-login Required',
                'modal': true,
                'width': 800,
                'height': 600,
                'autoOpen': true,
                'open': function() {
                    $loginForm.css({ width: '750px', height: '550px' });
                }
            });
            
            // Keep polling the CAS login frame to see if it closed.
            interval = setInterval(function() {
                var frameWindow = $loginForm.get(0).contentWindow;
                if (frameWindow && frameWindow.closed) {
                    AppDev.winLogin.done();
                }
            }, 20);
        };
      }
      
      // Local re-authentication popup
      else {

        // See if the site template already has a custom form provided
        var $loginForm = $('#appDev-formLogin');
        // If not, build one now
        if ($loginForm.length == 0) {
            var formHTML = '\
    <div id="appDev-formLogin" button_text="Submit" form_title="Re-login">\
      <form>\
        <table width="100%">\
          <tr>\
            <th>User ID</th>\
            <td><input name="userID" /></td>\
            <td class="error" field_error_msg="userID"></td>\
          </tr>\
          <tr>\
            <th>Password</th>\
            <td><input type="password" name="pWord" /></td>\
            <td class="error" field_error_msg="pWord"></td>\
        </table>\
      </form>\
      <div class="message ui-state-error ui-corner-all"></div>\
    </div>\
    ';
            $loginForm = $(formHTML);
        }

        // This is the message box for errors and such
        $messageBox = $loginForm.find('.message');
        // Title and button label
        var submitButton = $loginForm.attr('button_text');
        var formTitle = $loginForm.attr('form_title');
        // The callback function to execute after reauthenticating
        var loginCallback = null;
        
        // Login form submission handler
        var loginFormSubmit = function() {
            // Clear messages
            $messageBox.hide();
            $loginForm.find('[field_error_msg]').empty();
            // Access the server
            $.ajax({
                // @see modules/site/interfaces/siteLogin/node_siteLogin.js
                url: '/service/site/login/authenticate',
                type: 'POST',
                dataType: 'json',
                data: $loginForm.find('form').serialize(),
                error: function(req) {
                    // Did not receive a valid JSON response
                    $messageBox
                      .html("Error:<br/>"+req.responseText)
                      .slideDown();
                },
                success: function(data) {
                    // Received a valid JSON response
                    if (data.success) {
                        // Authentication successful
                        $messageBox
                          .html('Success!')
                          .slideDown();
                        setTimeout(
                          function() { 
                            $loginForm.dialog('close'); 
                            if ($.isFunction(loginCallback)) loginCallback();
                          }, 
                          1000
                        );
                    } else {
                        // Authentication failed
                        for (field in data.errors) {
                            $loginForm.find('[field_error_msg='+field+']')
                              .html(data.errors[field]);
                        }
                    }
                }
            });
        }

        var dialogButtons = {};
        dialogButtons[submitButton] = loginFormSubmit;

        // jQueryUI dialog
        $loginForm.dialog({
            title: formTitle,
            buttons: dialogButtons,
            open: function() {
                // Clear fields and messages
                $loginForm.find('[name=userID], [name=pWord]').val('');
                $loginForm.find('[field_error_msg]').empty();
                $messageBox.hide();
                // Set focus on the user ID field
                $loginForm.find('[name=userID]').focus();
            },
            autoOpen: false,
            modal: true,
            width: 400
        });
        
        // Pressing Enter in the password field should submit the form
        $loginForm.find('[name=pWord]').keypress(function(e) {
            if (e.keyCode == 13 || e.keyCode == 10 || e.keyCode == 3) {
                loginFormSubmit();
            }
        });

        // Populate the winLogin object
        AppDev.winLogin = {
            isVisible: function() { return $loginForm.dialog('isOpen'); },
            show: function(callback) {
                loginCallback = callback;
                $loginForm.dialog('open');
            }
        }
        
      } // end local re-authentication

    }); // ready()
    
    AD.Util = {};
    AD.Util.String = {};
    AD.Util.String.replaceAll = function (origString, replaceThis, withThis) {
        var re = new RegExp(RegExpQuote(replaceThis),"g"); 
        return origString.replace(re, withThis);
    };
    


    RegExpQuote = function(str) {
         return str.replace(/([.?*+^$[\]\\(){}-])/g, "\\$1");
    };

    AD.Util.Object = {};

    /**
     * @function AD.Util.Object.getAttrs
     *
     * Provide a copy of the attributes of an object.  No functions allowed.
     * Differs from JavascriptMVC Model::attrs() because this function will return
     * attributes which belong to the model as well as properties that got tacked on later
     * @param object source object
     * @return object
     */
    AD.Util.Object.getAttrs = function (data) {
        var attrs = {};
        $.each(data, function(index, value){
            if (!$.isFunction(value)) {
                attrs[index] = value;
            }
        });
        return attrs;
    };

});

