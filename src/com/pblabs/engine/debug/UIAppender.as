package com.pblabs.engine.debug
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.InputKey;
	import com.pblabs.engine.core.InputManager;
	
	import flash.events.KeyboardEvent;

	/**
	 * LogAppender for displaying log messages in a LogViewer flex ui component. The LogViewer will be
     * attached and detached from the main view when the defined hot key is pressed. The tilde (~) key 
	 * is the default hot key.
	 */	
	public class UIAppender implements ILogAppender
	{
		protected static var _hotKey:uint;

		protected var _logViewer:LogViewer;
	   
		public function UIAppender()
		{
			InputManager.instance.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			_hotKey = InputKey.TILDE.keyCode;
			_logViewer = new LogViewer();
		}
  
		private function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode != _hotKey)
				return;
			 
			if(_logViewer)
			{
				if (_logViewer.parent)
				{
					_logViewer.parent.removeChild(_logViewer);
					_logViewer.deactivate();
				}
				else
				{
					PBE.mainStage.addChild(_logViewer);
					_logViewer.activate();
				}
			}
		}
  
		public function addLogMessage(level:String, loggerName:String, message:String):void
		{
			if(_logViewer)
			_logViewer.addLogMessage(level, loggerName, message);
		}
		
		/**
		 * The keycode to toggle the UIAppender interface.
		 */		
		public static function set hotKey(value:uint):void
		{
			Logger.print(UIAppender, "Setting hotKey to: "+value);
			_hotKey = value;
		}
	}
}