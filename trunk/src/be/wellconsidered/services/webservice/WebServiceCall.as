/**
* @author Pieter Michels
*/

package be.wellconsidered.services.webservice 
{
	import be.wellconsidered.services.webservice.types.*;
	
	public class WebServiceCall
	{
		private var _call:XML;
		
		private var _method:String;
		private var _args:Array;
		private var _wsmethod:WebServiceMethod;
		private var _method_col:WebServiceMethodCollection;
		private var _tgtnms:String;
		
		public function WebServiceCall(param_method:String, param_wsmethodcol:WebServiceMethodCollection, param_tgtnms:String = "http://tempuri.org/", param_arr:Array = null)
		{
			_method_col = param_wsmethodcol;
			_method = param_method;
			_args = param_arr;
			_wsmethod = _method_col.getMethodObject(_method);
			_tgtnms = param_tgtnms;
			
			createSoapCall();
		}
	
		private function createSoapCall():void
		{
			var add_node:XML;
			
			// NAMESPACE OF NIET?
			if(_method_col.getBindingObject(_method).getInputNamespace() != null)
			{
				add_node = <{"wc:" + _method} xmlns:wc={_method_col.getBindingObject(_method).getInputNamespace()} />
			}
			else
			{
				add_node = <{_method} xmlns={_tgtnms} />
			}
			
			// LIST
			if(_args.length > 1 || typeof(_args[0]) != "object")
			{
				for(var j:int = 0; j < _wsmethod._args.length; j++)
				{
					var ws_arg:WebServiceArgument = _wsmethod._args[j];
					
					if(ws_arg.isReference())
					{
						var cplx_oref:WebServiceComplexType =  _method_col.getComplexObject(ws_arg.type);
						var oref_node:XML = <{ws_arg.name} />;
						
						for(var l:int = 0; l < cplx_oref._args.length; l++)
						{
							ws_arg = cplx_oref._args[l];
							
							oref_node.appendChild(
								<{ws_arg.name}>
									{_args[j][ws_arg.name]}
								</{ws_arg.name}>
								);							
						}
						
						add_node.appendChild(oref_node);
					}
					else
					{
						add_node.appendChild(
							<{ws_arg.name}>
								{_args[j]}
							</{ws_arg.name}>
							);
					}
				}
			}
			// SINGLE OBJECT
			else
			{		
				/**
				 * CLEAN THIS SHIT! 
				 * IT NEEDS A TRANSPARENT CHECK (REF. WebServiceReponse CLASS)
				 */
 	
				for(var i:int = 0; i < _wsmethod._args.length; i++)
				{
					var wsa_arg:WebServiceArgument = _wsmethod._args[i];
					
					// EMPTY
					if(wsa_arg.isReference())
					{
						// complex object
						
						var cplx_o:WebServiceComplexType =  _method_col.getComplexObject(wsa_arg.type);
						var o_node:XML = <{wsa_arg.name} />;
						
						for(var k:int = 0; k < cplx_o._args.length; k++)
						{
							wsa_arg = cplx_o._args[k];
							
							o_node.appendChild(
								<{wsa_arg.name}>
									{_args[0][wsa_arg.name]}
								</{wsa_arg.name}>
								);							
						}
						
						add_node.appendChild(o_node);
					}
					else if(!_args[0][wsa_arg.name])
					{
						add_node.appendChild(
							<{wsa_arg.name} />
							);								
					}
					else
					{
						// object
						
						add_node.appendChild(
							<{wsa_arg.name}>
								{_args[0][wsa_arg.name]}
							</{wsa_arg.name}>
							);
					}
				}	
			}
			
			_call = 
				<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://schemas.xmlsoap.org/soap/envelope/">
					<soap12:Body>
						{add_node}
					</soap12:Body>
				</soap12:Envelope>
				;
			
			// _call.prependChild("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			// trace(_call);
		}
		
		/**
		* Get call
		* 
		* @return	XML object of created call.
		*/
		public function get call():XML
		{
			return _call;
		}
	}
}
