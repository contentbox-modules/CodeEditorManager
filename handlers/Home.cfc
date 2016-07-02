component{

	// DI
	property name="settings"           	inject="coldbox:moduleSettings:CodeEditorManager";
	property name="settingService"		inject="settingService@cb";
	property name="cb"             		inject="cbHelper@cb";
	property name="EditorService"		inject="EditorService@cb";

	function index( event, rc, prc ) {
		var editors = getConfiguredEditors();
		// loop over editors and build prc
		for( var config in editors ) {
			var name 	= config.name;
			var editor 	= config.editor;
			
			prc[ name ] = {
				modes 			= editor.getModeDefs(),
				themes 			= editor.getThemeDefs(),
				allowedModes 	= editor.getSetting( "modes" ),
				allowedThemes 	= editor.getSetting( "themes" ),
				defaultMode 	= editor.getSetting( "defaultMode" ),
				defaultTheme 	= editor.getSetting( "defaultTheme" ),
				active 			= editor.getSetting( "active" )
			};
		}

		prc.tabModules_CodeEditor = true;
		prc.xehSaveSettings = cb.buildModuleLink( "CodeEditorManager", "home.saveSettings" );

		event.setView( "home/index" );
	}

	function saveSettings( event, rc, prc ) {
		var editors = getConfiguredEditors();
		// loop over editors and build prc
		for( var config in editors ) {
			var name 	= config.name;
			var editor 	= config.editor;
			var args 	= {
				"defaultMode"	= editor.getSetting( "defaultMode" ),
				"defaultTheme" 	= editor.getSetting( "defaultTheme" ),
				"modes" 		= [],
				"themes" 		= [],
				"active" 		= false
			};
			if( structKeyExists( rc, "#name#Modes" ) ) {
				args[ "modes" ] = listToArray( rc[ "#name#Modes" ] );
			}
			// handle themes
			if( structKeyExists( rc, "#name#Themes" ) ) {
				args[ "themes" ] = listToArray( rc[ "#name#Themes" ] );
			}
			// handle defaults
			if( structKeyExists( rc, "#name#DefaultMode" ) ) {
				args[ "defaultMode" ] = rc[ "#name#DefaultMode" ];
			}
			if( structKeyExists( rc, "#name#DefaultTheme" ) ) {
				args[ "defaultTheme" ] = rc[ "#name#DefaultTheme" ];
			}
			if( structKeyExists( rc, "#name#Active" ) ) {
				args[ "active" ] = true;
				editorService.registerEditor( editor );
			} else {
				editorService.unregisterEditor( name );
			}
			
			// save settings
			var saveArgs = { name="codeeditormanager-#name#" };
			var setting = settingService.findWhere( criteria=saveArgs );
			saveArgs.value = serializeJSON( args );
			if( isNull( setting ) ) {
				var newsetting = settingService.new( properties=saveArgs );
				settingService.save( newsetting );
			} else {
				setting.setValue( saveArgs.value );
				settingService.save( setting );
			}
		}
		// Messagebox
		getModel( "MessageBox@cbMessageBox" ).info( "Settings Saved & Updated!" );

		cb.setNextModuleEvent( "CodeEditorManager", "home.index" );
	}

	/**
	 * Gets collection of all configured editors for this module
	 * return Array
	 */
	private array function getConfiguredEditors() {
		var editors = [];
		for( var key in settings.configuredEditors ) {
			var editor = settings.configuredEditors[ key ];
			arrayAppend( editors, {
				name  	= key,
				editor 	= getInstance( editor.instancePath )
			});
		}
		return editors;
	}
}