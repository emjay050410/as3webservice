/**
* @author Pieter Michels
*/

package be.wellconsidered.services.webservice.types
{
	public class WebServiceComplexType
	{
		public var _name:String;
		public var _args:Array;
		
		public function WebServiceComplexType(param_name:String)
		{
			_name = param_name;
						
			_args = new Array();
		}
			
		/**
		* Add WebServiceArgument property
		* 
		* @param	WebServiceArgument
		*/		
		public function addProp(param_arg:WebServiceArgument):void
		{
			_args.push(param_arg);
		}
	}
}
