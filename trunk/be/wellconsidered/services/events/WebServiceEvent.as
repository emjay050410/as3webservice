/**
* @author Pieter Michels
*/

package be.wellconsidered.services.events
{
	import flash.events.Event;
	
	public class WebServiceEvent extends Event
	{	
		public static var INITFAILED:String = "initfailed";
		public static var INITED:String = "inited";
		
		private var _data:Object;
		
		function WebServiceEvent(param_event:String, param_data:Object = null)
		{
			super(param_event);
			
			_data = param_data;
		}
		
		/**
		* Get data of WebServiceEvent
		* 
		* @return	Object with data
		*/			
		public function get data():Object
		{
			return _data;
		}
	}
}
