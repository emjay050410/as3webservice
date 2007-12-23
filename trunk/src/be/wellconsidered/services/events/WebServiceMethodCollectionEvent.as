/**
* @author Pieter Michels
*/

package be.wellconsidered.services.events
{
	import flash.events.Event;
	
	public class WebServiceMethodCollectionEvent extends Event
	{	
		public static var COMPLETE:String = "complete";
		
		function WebServiceMethodCollectionEvent(param_event:String)
		{
			super(param_event);
		}
	}
}
