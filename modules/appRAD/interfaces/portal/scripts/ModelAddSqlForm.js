/**
 *  Setup the Add SQL Model Form
 */

steal('//appDev/widgets/appdev_list_select/appdev_list_select.js',
      '//modules/appRAD/models/Databases.js',
      '//modules/appRAD/models/Tables.js',
      '//modules/appRAD/models/Fields.js'
).then(function() {

    // Keep all variables and functions inside an encapsulated scope
    (function() {
    
    
        //// Setup Widget:
        $.Controller.extend('ModelAddSqlForm', {

            
            init: function (el, data) {
                this.data = {};
                this.data.module = null;
                this.data.dbName = null;
                this.data.tableName = null;
                this.data.primaryKey = null;
                this.data.labelKey = null;
                
                var _self = this;
                
                // Initialize the form elements
                var listDatabases = appRAD.Databases.listManager({});
                $('#modelAddDbName').appdev_list_select({
                    title:'[appRad.portal.titleDatabaseList]', // this is the multilingual label key
                    hasBlank:true,
                    blankIsNull:true,
                    blankText:'[appRad.portal.blankDatabaseList]', // this is the multilingual label key
                    dataManager:listDatabases,
                    onSelection:function(item) {
                        _self.data.dbName = (item == null) ? null : item.id;
                        if (_self.data.dbName !== null) {
                            //Refresh the table list
                            _self.$tableList.findAll({dbName: _self.data.dbName});
                        } else {
                            //Clear out the table list
                            _self.$tableList.resetData();
                        }
                    }

                });
                this.$dbList = $('#modelAddDbName').controller();
                
                var listTables = appRAD.Tables.listManager({});
                $('#modelAddDbTable').appdev_list_select({
                    title:'[appRad.portal.titleTableList]', // this is the multilingual label key
                    hasBlank:true,
                    blankIsNull:true,
                    blankText:'[appRad.portal.blankTableList]', // this is the multilingual label key
                    dataManager:listTables,
                    onSelection:function(item) {
                        _self.data.tableName = (item == null) ? null : item.id;
                        if (_self.data.tableName !== null) {
                            //Refresh one of the field lists; the other will get updated, too
                            _self.$primaryKeyList.findAll({
                                dbName: _self.data.dbName, 
                                dbTable: _self.data.tableName
                            });
                        } else {
                            //Clear out the field lists
                            _self.$primaryKeyList.resetData();
                            _self.$labelKeyList.resetData();
                        }
                    }

                });
                this.$tableList = $('#modelAddDbTable').controller();
                
                var listFields = appRAD.Fields.listManager({});
                $('#modelAddPrimaryKey').appdev_list_select({
                    title:'[appRad.portal.titlePrimaryKey]', // this is the multilingual label key
                    hasBlank:true,
                    blankIsNull:true,
                    blankText:'[appRad.portal.blankPrimaryKey]', // this is the multilingual label key
                    dataManager:listFields,
                    onSelection:function(item) {
                        _self.data.primaryKey = (item == null) ? null : item.id;
                    }

                });
                this.$primaryKeyList = $('#modelAddPrimaryKey').controller();

                $('#modelAddLabelKey').appdev_list_select({
                    title:'[appRad.portal.titleLabelKey]', // this is the multilingual label key
                    hasBlank:true,
                    blankIsNull:true,
                    blankText:'[appRad.portal.blankLabelKey]', // this is the multilingual label key
                    dataManager:listFields,
                    onSelection:function(item) {
                        _self.data.labelKey = (item == null) ? null : item.id;
                    }

                });
                this.$labelKeyList = $('#modelAddLabelKey').controller();
                
            },
            'apprad.module.selected subscribe': function(message, data) {
                this.data.module = data && data.name;
            },
            '#modelAddSqlButton click': function(el) {
                var $form = this.element.parent();
                
                // Collect the necessary information
                var data = {};
                this.data.ModelName = $form.find('#modelAddModelName').val();
                if (   (this.data.ModelName !== '')
                    && (this.data.dbName !== null)
                    && (this.data.tableName !== null)
                    && (this.data.primaryKey !== null)
                    && (this.data.labelKey !== null) ) {
                    
                    // We have all the necessary information

                    // Make the request from the server
                    var onSuccess = function(response) {
                        AppDev.alert('Model created!');
                        var item = {
                                module:_self.data.module,
                                name:_self.data.ModelName
                        };
                        AD.Comm.Notification.publish('apprad.model.created', item);
                    };
                    
                    var onError = function() {
                        AppDev.alert('Error creating model');
                    
                    };
                    AppDev.ServiceJSON.post({
                        url:'/appRad/model/create',
                        params:this.data,
                        success:onSuccess,
                        failure: onError
                    });
                } else {
                    // Missing some information
                    AppDev.alert('Missing Information');
                }
            }
        });
        
    }) ();

});