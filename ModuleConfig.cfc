/**
* ContentBox - A Modular Content Platform
* Copyright since 2012 by Ortus Solutions, Corp
* www.ortussolutions.com/products/contentbox
* ---
* This module enhances ContentBox with many other editors
**/
component hint="Module Configuration for Code Editor Manager" {

    // Module Properties
    this.title              = "Code Editor Manager";
    this.author             = "Ortus Solutions";
    this.webURL             = "https://www.ortussolutions.com";
    this.description        = "A simple module to enable use of multiple custom code editors for pages and entries";
    this.version            = "2.0.0";
    // If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
    this.viewParentLookup   = true;
    // If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
    this.layoutParentLookup = true;
    // Module Entry Point
    this.entryPoint         = "CodeEditorManager";

    function configure(){
        // parent settings
        parentSettings = {

        };
        // module settings - stored in modules.name.settings
        settings = {
            configuredEditors = {
                "ace"           = { "instancePath" = "AceEditor@CodeEditorManager" },
                "codemirror"    = { "instancePath" = "CodeMirrorEditor@CodeEditorManager" }
            }
        };
        // Layout Settings
        layoutSettings = {
            defaultLayout = ""
        };
        // SES Routes
        routes = [
            // Module Entry Point
            {pattern="/", handler="home",action="index"},
            // Convention Route
            {pattern="/:handler/:action?"}
        ];
        // Custom Declared Points
        interceptorSettings = {
            customInterceptionPoints = ""
        };
        // Custom Declared Interceptors
        interceptors = [];
        // Binder Mappings        
    }

    /**
     * Fired when the module is registered and activated.
     */
    function onLoad(){
        var editorService = wirebox.getInstance( "EditorService@cb" );
        for( var name in settings.configuredEditors ) {
            var path    = settings.configuredEditors[ name ].instancePath;
            var editor =  wirebox.getInstance( path );
            if( editor.getSetting( "active" ) ) {
                editorService.registerEditor( editor );
            }
        }
        // Let's add ourselves to the main menu in the Modules section
        var menuService = wirebox.getInstance( "AdminMenuService@cb" );
        // Add Menu Contribution
        menuService.addSubMenu( 
            topMenu     = menuService.MODULES, 
            name        = "CodeEditorManager", 
            label       = "Code Editor Manager", 
            href        = "#menuService.buildModuleLink( 'CodeEditorManager', 'home' )#" 
        );
    }
    /**
     * Fired when the module is activated by ContentBox
     */
    function onActivate(){

    }
    /**
     * Fired when the module is unregistered and unloaded
     */
    function onUnload(){
        var editorService = wirebox.getInstance( "EditorService@cb" );
        // unregister all custom editors
        for( var name in settings.configuredEditors ) {
            editorService.unregisterEditor( name );
        }
        // Let's remove ourselves to the main menu in the Modules section
        var menuService = wirebox.getInstance( "AdminMenuService@cb" );
        // Remove Menu Contribution
        menuService.removeSubMenu( topMenu=menuService.MODULES, name="CodeEditorManager" );
    }
    /**
     * Fired when the module is deactivated by ContentBox
     */
    function onDeactivate(){
        var settingService = wirebox.getInstance( "SettingService@cb" );
        for( var name in settings.configuredEditors ) {
            var args    = { name="codeeditormanager-#name#" };
            var setting = settingService.findWhere( criteria=args );
            if( !isNull( setting ) ){
                settingService.delete( setting );
            }
        }
    }

}