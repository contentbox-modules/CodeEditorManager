<cfoutput>
<div class="row">
    <div class="col-md-12">
        <h1 class="h1"><i class="fa fa-code fa-lg"></i> Code Editor Manager</h1>
    </div>
</div>

<div class="row">
    <div class="col-md-9">

        <div class="panel panel-default">
            <div class="panel-body">
                
                #html.startForm( name="settingsForm", action=prc.xehSaveSettings )#
                            
                    <!--- messageBox --->
                    #getModel( "MessageBox@cbMessageBox" ).renderit()#

                    <div class="tabbable tabs-left">           
                        
                        <!--- Navigation Bar --->
                        <ul class="nav nav-tabs" id="widget-sidebar">
                            <li class="active"><a href="##ace" class="current" data-toggle="tab">Ace Code Editor</a></li>
                            <li><a href="##codemirror" data-toggle="tab">Code Mirror</a></li>
                        </ul>
                        
                        <!--- ContentBars --->
                        <div class="tab-content margin10">
                            #renderView( "home/ace" )#
                            #renderView( "home/codemirror" )#
                        </div>

                        <p>&nbsp;</p>

                        <!--- Button Bar --->
                        <div class="text-center margin10">
                            #html.submitButton( value="Save Settings", class="btn btn-danger" )#
                        </div>
                    </div>

                #html.endForm()#

            </div>
        </div>
    </div>
</div>
</cfoutput>