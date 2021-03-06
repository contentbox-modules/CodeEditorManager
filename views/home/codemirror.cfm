<cfoutput>
<div class="full tab-pane" id="codemirror">
    <fieldset>
        <legend><strong>CodeMirror Editor</strong></legend>
       
        <div class="form-group">
            <div class="controls">
                <cfset color = prc.CodeMirror.active ? "success" : "danger">
                <label class="btn btn-#color# btn-toggle" for="CodeMirrorActive">
                    <input type="checkbox" id="CodeMirrorActive" name="CodeMirrorActive" <cfif prc.CodeMirror.active>checked=checked</cfif> />  Active?
                </label>
            </div>
        </div>
       
        <div class="form-group">
            <label class="control-label" for="CodeMirrorDefaultTheme">Default Theme:</label>
            <div class="controls">
                <select name="CodeMirrorDefaultTheme" id="CodeMirrorDefaultTheme">
                    <cfloop array="#prc.CodeMirror.themes#" index="theme" >
                        <option value="#theme.theme#" <cfif prc.CodeMirror.defaultTheme eq theme.theme>selected="selected"</cfif>>#theme.name#</option>
                    </cfloop>
                </select>
            </div>
        </div>  
       
        <div class="form-group">
            <label class="control-label" for="CodeMirrorThemes">Allowed Themes:</label>
            <label class="btn btn-info btn-toggle btn-sm" for="CodeMirrorThemeCheckAll">
                <input type="checkbox" id="CodeMirrorThemeCheckAll" name="CodeMirrorThemeCheckAll" /> Check/Uncheck All
            </label>
            <div class="controls">
                <table border="0" width="100%">
                    <tr>
                    <cfset counter = 1>
                    <cfloop array="#prc.CodeMirror.themes#" index="theme">
                        <td>
                            <input type="checkbox" name="CodeMirrorThemes" value="#theme.theme#" <cfif arrayFindNoCase( prc.CodeMirror.allowedThemes, theme.theme )>checked="checked"</cfif> /> #theme.name#
                        </td>
                        <cfif counter MOD 6 eq 0>
                            </tr>
                            <tr>
                        </cfif>
                        <cfset counter++>
                    </cfloop>
                    <cfif counter MOD 6 gt 0>
                        <td colspan="#6-(counter MOD 6)+1#">&nbsp;</td>
                    </cfif>
                    </tr>
                </table>
            </div>
        </div>  
       
        <div class="form-group">
            <label class="control-label" for="CodeMirrorDefaultMode">Default Mode:</label>
            <div class="controls">
                <select name="CodeMirrorDefaultMode" id="CodeMirrorDefaultMode">
                    <cfloop array="#prc.CodeMirror.modes#" index="mode" >
                        <option value="#mode.mode#" <cfif prc.CodeMirror.defaultMode eq mode.mode>selected="selected"</cfif>>#mode.name#</option>
                    </cfloop>
                </select>
            </div>
        </div>  
       
        <div class="form-group">
            <label class="control-label" for="defaultMode">Allowed Modes:</label>
            <label class="btn btn-info btn-toggle btn-sm" for="CodeMirrorModeCheckAll">
                <input type="checkbox" id="CodeMirrorModeCheckAll" name="CodeMirrorModeCheckAll" /> Check/Uncheck All
            </label>
            <div class="controls">
                <table border="0" width="100%">
                    <tr>
                    <cfset counter = 1>
                    <cfloop array="#prc.CodeMirror.modes#" index="mode">
                        <td>
                            <input type="checkbox" name="CodeMirrorModes" value="#mode.mode#" <cfif arrayFindNoCase( prc.CodeMirror.allowedModes, mode.mode )>checked="checked"</cfif> /> #mode.name#
                        </td>
                        <cfif counter MOD 6 eq 0>
                            </tr>
                            <tr>
                        </cfif>
                        <cfset counter++>
                    </cfloop>
                    <cfif counter MOD 6 gt 0>
                        <td colspan="#6-(counter MOD 6)+1#">&nbsp;</td>
                    </cfif>
                    </tr>
                </table>
            </div>
        </div>  
    </fieldset>
</div>
</cfoutput>