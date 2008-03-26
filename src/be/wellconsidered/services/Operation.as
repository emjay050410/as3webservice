/**
* @author Pieter Michels
*/

package be.wellconsidered.services
{
	import be.wellconsidered.services.events.OperationEvent;
	import be.wellconsidered.services.webservice.*;

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.EventDispatcher;

	import flash.net.*;

	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	dynamic public class Operation extends Proxy
	{
		private var ws:WebService;
		private var eventDispatcher:EventDispatcher;

		private var method_name:String;
		private var method_args:Array;

		private var url_loader:URLLoader;
		private var url_request:URLRequest;

		public function Operation(param_ws:WebService)
		{
			ws = param_ws;

			eventDispatcher = new EventDispatcher();

			// PREPARE METHOD CALLING
			url_request = new URLRequest(ws.url);
			url_request.contentType = "text/xml; charset=utf-8";
			url_request.method = URLRequestMethod.POST;

			url_loader = new URLLoader();
			url_loader.dataFormat = URLLoaderDataFormat.TEXT;
			url_loader.addEventListener(Event.COMPLETE, onServiceLoaded);
			url_loader.addEventListener(IOErrorEvent.IO_ERROR, onServiceFailed);
		}

		public function loadMethod():void
		{
			var new_call:WebServiceCall = new WebServiceCall(method_name, ws.getMethodCollection(), ws.getMethodCollection().targetNameSpace, method_args);

			var soap_action:String = ws.getMethodCollection().targetNameSpace;
			var trailing_slash:Number = soap_action.lastIndexOf("/");
			var b_slash:Boolean = (trailing_slash == -1 || trailing_slash < soap_action.length - 2);

			soap_action += b_slash ? "/" + method_name : method_name;

			// url_request.requestHeaders.push(new URLRequestHeader("Content-Type", "application/soap+xml"));
			url_request.requestHeaders.push(new URLRequestHeader("Content-Type", "text/xml; charset=utf-8"));
			url_request.requestHeaders.push(new URLRequestHeader("SOAPAction", soap_action));

			url_request.data = new_call.call;

			url_loader.load(url_request);
		}

		private function onServiceLoaded(e:Event):void
		{
			try
			{
				var response:WebServiceResponse = new WebServiceResponse(new XML(url_loader.data), ws.getMethodCollection());

				dispatchEvent(new OperationEvent(OperationEvent.COMPLETE, response.data));
			}
			catch (e:Error)
			{
				trace("ERROR: Webservice returned faulty XML");

				dispatchEvent(new OperationEvent(OperationEvent.FAILED, e));
			}

			url_loader.data = null;
		}

		private function onServiceFailed(e:IOErrorEvent):void
		{
			dispatchEvent(new OperationEvent(OperationEvent.FAILED, e));
		}

		flash_proxy override function getProperty(param_method:*):* { }

		flash_proxy override function callProperty(param_method:* , ... args):*
		{
			method_name = param_method;
			method_args = args;

			if(ws.loaded)
			{
				if(ws.getMethodCollection().methodExists(method_name))
				{
					loadMethod();
				}
			}
			else
			{
				ws.addOperationToQeue(this);
			}
		}

		/**
		* Get method name
		*
		* @return	Name of the method
		*/
		public function get method():String
		{
			return method_name;
		}

		/**
		* Get arguments of method
		*
		* @return	Array of arguments
		*/
		public function get args():Array
		{
			return method_args;
		}

		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0):void { eventDispatcher.addEventListener(type, listener, useCapture, priority); }
		public function dispatchEvent(event:Event):Boolean { return eventDispatcher.dispatchEvent(event); }
		public function hasEventListener(type:String):Boolean { return eventDispatcher.hasEventListener(type); }
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void { eventDispatcher.removeEventListener(type, listener, useCapture); }
		public function willTrigger(type:String):Boolean { return eventDispatcher.willTrigger(type); }
	}
}
