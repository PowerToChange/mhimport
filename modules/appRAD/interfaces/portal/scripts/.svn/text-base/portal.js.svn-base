
/**
 *  The setup script for the portal Interface container. 
 *
 *  The job of this code is to perform all the setup steps on the existing
 *  HTML DOM items now.  Add Events, actions, etc... 
 *
 *  This file will be generated 1x by the RAD tool and then left alone.
 *  It is safe to put all your custom code here.
 */


(function() {


////[appRad] --  setup object definitions here:
var appRADPortalSetup = function (topic, data) {


    //// Setup Your Page Data/ Operation Here
    $('#ModuleWorkAreaPanel').module_work_area_panel();
    $('#InterfaceWorkAreaPanel').interface_work_area_panel();
    $('#ModelWorkAreaPanel').model_work_area_panel();
    
    
    var listModules = appRAD.Modules.listManager({});
    $('#listModules').module_list_widget({
    	title:'[appRad.portal.titleModuleList]', // this is the multilingual label key
        dataManager:listModules,
        height:'250',
        pageSize:5,
        buttons:{
        	add:true,
//        	delete:true,
//        	edit:true,
        	refresh:true
        }
    
    });
   
 
    var listInstallFiles = appRAD.InstallFiles.listManager({});
    $('#listInstallFiles').install_files_list_widget({
        dataManager:listInstallFiles
    });

    var listModuleWidgets = appRAD.ModuleWidgets.listManager({});
    $('#listModuleWidgets').module_widget_list_widget({
        dataManager:listModuleWidgets
    });

    $('#moduleAddService').module_add_service_form({});
    
    
    var listInterfaces = appRAD.Interfaces.listManager({});
    $('#listInterfaces').interface_list_widget({
    	title:'[appRad.portal.titleInterfaceList]', // this is the multilingual label key
        dataManager:listInterfaces,
        height:'225'
    });
    
    var listModels = appRAD.Models.listManager({});
    $('#listModels').model_list_widget({
    	title:'[appRad.portal.titleModelList]', // this is the multilingual label key
        dataManager:listModels,
        height:'225'
    });
    
    var listControllers = appRAD.Controllers.listManager({});
    // WARNING: This widget is constructed with "list_widget" instead of
    // "controller_list_widget" because JavascriptMVC removes the word
    // "Controller" when creating the plugin name.  Nice...
    $('#listControllers').list_widget({
    	title:'[appRad.portal.titleControllerList]', // this is the multilingual label key
        dataManager:listControllers
    });
    
    var listViews = appRAD.Views.listManager({});
    $('#listViews').view_list_widget({
    	title:'[appRad.portal.titleViewList]', // this is the multilingual label key
        dataManager:listViews
    });
    
    // WARNING: This widget is constructed with "editor_widget" instead of
    // "controller_editor_widget" because JavascriptMVC removes the word
    // "Controller" when creating the plugin name.  Nice...
    $('#controllerEditorPanel').editor_widget({});
    $('#viewEditorPanel').view_editor_widget({});

    $('#modelAddSelectTable').model_add_sql_form({});
    

} // end appRADPortalSetup()
OpenAjax.hub.subscribe('ad.appRAD.portal.setup',appRADPortalSetup);




$(document).ready(function () {

    //// Do you need to do something on document.ready() before the above
    //// appRADPortalSetup() script is called?


}); // end ready()

}) ();