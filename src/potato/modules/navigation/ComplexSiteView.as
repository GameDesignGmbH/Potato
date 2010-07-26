package potato.modules.navigation
{
	import potato.core.config.JSONConfig;
	import potato.modules.parameters.Parameters;
	import potato.modules.dependencies.Dependencies;
    import potato.modules.tracking.Tracker;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import potato.modules.i18n.I18n;
	import flash.events.Event;
	import potato.core.config.ObjectConfig;

	/**
	 * Description
	 * 
	 * @langversion ActionScript 3
	 * @playerversion Flash 9.0.0
	 * 
	 * @author Lucas Dupin
	 * @since  16.06.2010
	 */
	public class ComplexSiteView extends View
	{
	
		public function ComplexSiteView()
		{
			//Making sure these modules are included
			Parameters;
			Dependencies;
			I18n;
			
			/*
			Stage config
			*/
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
            //Setting default parameters
			parameters.defaults.basePath   = "."
			parameters.defaults.configFile = "%(basePath)s/data/main.json";
			parameters.defaults.tagsFile   = "%(basePath)s/data/tags.json";
			parameters.defaults.locale     = "pt_BR";
			parameters.defaults.localePath = "%(basePath)s/data/locales/%(locale)s";
			
            //Getting data from loaderInfo
			for (var p:String in loaderInfo.parameters)
            {
                var val:* = loaderInfo.parameters[p];
                if(val == "true" || val == "false")
				    parameters[p] = Boolean(loaderInfo.parameters[p]);
                else if(!isNaN(val))
				    parameters[p] = Number(loaderInfo.parameters[p]);
                else
				    parameters[p] = loaderInfo.parameters[p];
            }

            //Initialize tracking
            Tracker.instance.config = new JSONConfig(parameters.tagsFile);
			
			//Boot
			startup(new JSONConfig(parameters.configFile));
		}
	
	}

}
