/**
* @author Pieter Michels
*/

package be.wellconsidered.services.webservice.types
{
	public class WebServiceMethodResponse
	{
		public var _name:String;
		public var _args:Array;
		
		public function WebServiceMethodResponse(param_name:String)
		{
			_name = param_name;
			
			_args = new Array();
		}
		
		/**
		* Add WebServiceArgument parameter
		* 
		* @param	WebServiceArgument
		*/
		public function addPar(param_arg:WebServiceArgument):void
		{	
			_args.push(param_arg);
		}
	}
}
