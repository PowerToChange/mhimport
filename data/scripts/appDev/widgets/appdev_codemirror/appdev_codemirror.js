/*
 * @class appdev_codemirror
 * @parent widgets
 * 
 * ###Code Editor widget
 * 
 * A Code Editor widget
 *
 */
 

steal('CodeMirror/mode/javascript/javascript.js',
        '//appDev/widgets/appdev_codemirror/appdev_codemirror.ejs').then(function() {
        	


    $.Controller.extend("AppdevCodemirror", 
        {
            // This object will transform the data in a menu 
            
            
            
            init: function (el, options) {
            
                
                var defaults = {
                      gid:'appdev_codemirror_uuid_notGiven',
                      title: null,      // the MultilingualLabel Key for the title
                      buttons:{
                        },
                      path:'',
                      readUrl:'',
                      writeUrl:'',
                };
                var options = $.extend(defaults, options); 
                
                
                
                // Init our default values:
                this.initUrls(options);
                
                // insert our DOM elements
                this.insertDOM();
                
                // setup any internal panels (delete confirmation, etc..)
                
                
                // setup our title (multilingual)
                // configure our buttons
                this.initButtons(options);
                
                
            }, 
            
            initUrls: function(options) {
                this.readUrl = options.readUrl;
                this.writeUrl = options.writeUrl;

            },
            
            initButtons: function(options) {
                var $buttonSave = this.element.find('#btnSave');
                if (this.writeUrl) {
                    var _self = this;
                    $buttonSave.click(function() {
                        _self.saveCode();
                    });
                    $buttonSave.show();
                } else {
                    $buttonSave.hide();
                }

                var $buttonReload = this.element.find('#btnReload');
                var _self = this;
                $buttonReload.click(function() {
                    _self.loadCode();
                });
                $buttonReload.show();
                
                
            },
            
            insertDOM: function() {
                var _self = this;
                this.element.html(this.view('//appDev/widgets/appdev_codemirror/appdev_codemirror.ejs', {}));
                var $codeMirrorDiv = this.element.find('#codeMirror');
                this._codeMirror = CodeMirror(function(el) {
                        $codeMirrorDiv.html(el);
                    }, 
                    {
                        lineNumbers:true,
                        matchBrackets:true,
                        indentUnit:4,
                        onChange:function(from, to, text, next) {
                            _self.onChange(from, to, text, next);
                        }
                    
                });
                this._$busyDiv = this.element.find('#busy');

            },
            
            //-----------------------------------------------
            busyOff: function () {
                // show the busy indicator on this widget
            
                this._$busyDiv.removeClass('appdev-codemirror-busy');
            
            },
            
            
            
            //-----------------------------------------------
            busyOn: function () {
                // show the busy indicator on this widget
            
                this._$busyDiv.addClass('appdev-codemirror-busy');
            
            },
            
            onChange: function(from, to, text, next) {
                this.modified = true;
            },
            
            isModified: function() {
                return this.modified;
            },
            
            selectFile: function(data) {
                // Strip off any class-based properties, because 
                // we are going to use data for generating URL parameters
//                this.data = data.getProperties();
                this.data = AD.Util.Object.getAttrs(data);
                this.element.find('.title').html(data.name);
                this._codeMirror.setValue("");
                this.loadCode();
            },
            
            loadCode: function() {
                var _self = this;
                
                // Clear modified flag; we want to ignore any previous changes
                _self.modified = false;
                _self.busyOn();
                var onSuccess = function(response) {

                    var data = response.data;
                    
                    // Load up the code mirror
                    _self._codeMirror.setValue(data.fileContent);
                    _self.path = data.path;
                    
                    // Clear modified flag again, now that the current contents are loaded
                    _self.modified = false;

                    _self.busyOff();
                    
                };
                
                var onError = function() {
                    AppDev.alert('loadCode error ['+_self.readUrl+']['+_self.data+']');
                    _self.busyOff();
                
                };
                AppDev.ServiceJSON.post({
                    url:this.readUrl,
                    params:this.data,
                    success:onSuccess,
                    failure: onError
                });
            },

            saveCode: function() {
                if (this.modified) {
                    var _self = this;
                
                    var data = $.extend({}, this.data);
                    data.content = _self._codeMirror.getValue();
    
                    _self.busyOn();
                    var onSuccess = function(response) {
                        // Success
                        _self.busyOff();
                        _self.modified = false;
                    };
                    
                    var onError = function() {
                        AppDev.alert('saveCode error ['+this.writeUrl+']['+this.data+']');
                        _self.busyOff();
                    
                    };
                    AppDev.ServiceJSON.post({
                        url:this.writeUrl,
                        params:data,
                        success:onSuccess,
                        failure: onError
                    });
                }
            }
        });
    
    
});
    
