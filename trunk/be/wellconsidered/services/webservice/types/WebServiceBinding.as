/**
* @author Pieter Michels
*/

package be.wellconsidered.services.webservice.types
{
	public class WebServiceBinding
	{
		public var _name:String;
		
		private var _input_nms:Namespace = null;
		private var _output_nms:Namespace = null;
		
		private var _input_use:String;
		private var _output_use:String;
		
		public function WebServiceBinding(param_name:String)
		{
			_name = param_name;
		}
			
		/**
		* Add input Namespace URI
		* 
		* @param	URI as String
		*/		
		public function addInputNamespace(param_uri:String):void
		{
			if(param_uri.length > 0)
			{
				_input_nms = new Namespace(param_uri);
			}
		}
		
		/**
		* Add output Namespace URI
		* 
		* @param	URI as String
		*/		
		public function addOutputNamespace(param_uri:String):void
		{
			if(param_uri.length > 0)
			{
				_output_nms = new Namespace(param_uri);
			}
		}	
		
		/**
		* Add input use
		* 
		* @param	use
		*/		
		public function addInputUse(param_use:String):void
		{
			_input_use = param_use;
		}
		
		/**
		* Add output use
		* 
		* @param	use
		*/		
		public function addOutputUse(param_use:String):void
		{
			_output_use = param_use;
		}
		
		/**
		* Get input Namespace URI
		*/		
		public function getInputNamespace():Namespace
		{
			return _input_nms;
		}
		
		/**
		* Get output Namespace URI
		*/		
		public function getOutputNamespace():Namespace
		{
			return _output_nms;
		}	
		
		/**
		* Get input use
		*/		
		public function getInputUse():String
		{
			return _input_use;
		}
		
		/**
		* Get output use
		*/		
		public function getOutputUse():String
		{
			return _output_use;
		}		
	}
}
