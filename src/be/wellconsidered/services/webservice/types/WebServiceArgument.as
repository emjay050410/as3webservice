/**
* @author Pieter Michels
*/

package be.wellconsidered.services.webservice.types
{
	public class WebServiceArgument
	{	
		private var _name:String;
		private var _type:String;
		
		public function WebServiceArgument(param_name:String, param_type:String = "")
		{
			_name = param_name
			_type = param_type
		}	
		
		/**
		* Get name of WebServiceArgument
		* 
		* @return	Name of WebServiceArgument
		*/		
		public function get name():String
		{
			return _name;
		}
		
		/**
		* Get type of WebServiceArgument
		* 
		* @return	Type of WebServiceArgument
		*/
		public function get type():String
		{
			return _type.split(":")[1];
		}
		
		/**
		* Is WebServiceArgument a reference type
		* 
		* @return	True if reference
		*/			
		public function isReference():Boolean
		{
			return _type.split(":")[0] == "tns";
		}
		
		/**
		* Is WebServiceArgument an Array type
		* 
		* @return	True if Array
		*/		
		public function isArray():Boolean
		{
			return isReference() && _type.split(":")[1].indexOf("Array") == 0;
		}		
	}
}
