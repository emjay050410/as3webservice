/**
* @author Pieter Michels
* 
* 	new WebServiceTest();
*/

package be.wellconsidered.services.test 
{
	import be.wellconsidered.services.events.OperationEvent;
	import be.wellconsidered.services.Operation;
	import be.wellconsidered.services.WebService;
	
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class WebServiceTest
	{	
		private var output:TextField;
		
		public function WebServiceTest()
		{
			tracing("INIT WEBSERVICE TEST");
		}
		
		//*****************************************************************************************//
		
		public function testAll():void
		{
			var tmp_1_tmr:Timer = new Timer(0, 1);
			tmp_1_tmr.addEventListener(TimerEvent.TIMER_COMPLETE,  function(evt:TimerEvent):void { testConcentra(); });
			tmp_1_tmr.start();	
			
			var tmp_2_tmr:Timer = new Timer(500, 1);
			tmp_2_tmr.addEventListener(TimerEvent.TIMER_COMPLETE,  function(evt:TimerEvent):void { testKBCHTTPS(); });
			tmp_2_tmr.start();
			
			var tmp_3_tmr:Timer = new Timer(1000, 1);
			tmp_3_tmr.addEventListener(TimerEvent.TIMER_COMPLETE,  function(evt:TimerEvent):void { testMora(); });
			tmp_3_tmr.start();
			
			var tmp_4_tmr:Timer = new Timer(1500, 1);
			tmp_4_tmr.addEventListener(TimerEvent.TIMER_COMPLETE,  function(evt:TimerEvent):void { testMXR(); });
			tmp_4_tmr.start();
			
			var tmp_5_tmr:Timer = new Timer(2000, 1);
			tmp_5_tmr.addEventListener(TimerEvent.TIMER_COMPLETE,  function(evt:TimerEvent):void { testWeather(); });
			tmp_5_tmr.start();					
		}
		
		public function testConcentra():void
		{
			var w:WebService = new WebService("http://webservices.microsite.be/concentra/ws/service.asmx?wsdl");
			var o:Operation = new Operation(w);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault);
			
			o.getNaw("6581df8b-1c1b-495b-8a5e-814e46ae66ae");
		}	
		
		public function testKBCHTTPS():void
		{
			var w:WebService = new WebService("https://www.kbcworld.be/ws/service.asmx?wsdl");
			var o:Operation = new Operation(w);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault);
			
			o.HelloWorld();
		}	
		
		public function testMXR():void
		{
			var w:WebService = new WebService("http://musicmixer.rmxr.com/zine-eu/Mixer/Portal?wsdl");
			var o:Operation = new Operation(w);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault);
			
			// o.getMostRecentRemixesCount();
			o.getTopRatedRemixes(0, 10);
		}		

		public function testMora():void
		{
			var ws:WebService = new WebService("http://webservices.microsite.be/mora/ws_mora.asmx?wsdl");
			var o:Operation = new Operation(ws);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault);
			
			o.getWinners();
		}
		
		public function testWeather():void
		{
			var ws:WebService = new WebService("http://www.webservicex.net/WeatherForecast.asmx?wsdl");
			var o:Operation = new Operation(ws);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault);
			
			o.GetWeatherByPlaceName("new york");
			
			var o2:Operation = new Operation(ws);
			
			o2.addEventListener(OperationEvent.COMPLETE, onResult);
			o2.addEventListener(OperationEvent.FAILED, onFault);
			
			o2.GetWeatherByPlaceName("las vegas");
		}
		
		public function testKULEcard():void
		{
			var ws:WebService = new WebService("http://www.kuleuvenecards.be/ws/service.asmx?wsdl");
			var o:Operation = new Operation(ws);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault);
			
			o.SaveEcard({Language: "NL", Ecard: "test", Message: "Test message", rEmail: "pieter.michels@proximity.bbdo.be", sEmail: "pieter.michels@proximity.bbdo.be", rName: "Pieter Receiver", sName: "Pieter Sender"});
		}			
		
		//*****************************************************************************************//
		
		protected function onFault(e:OperationEvent):void
		{
			trace("-------- ONFAULT --------");
			 
			tracing("DATA : " + e.data);
		}		
		
		protected function onResult(e:OperationEvent):void
		{
			trace("-------- ONRESULT --------");
			
			tracing("DATA : " + e.data);
			
			traceObject(e.data);
		}
		
		//*****************************************************************************************//
		
		protected function traceObject(data:*, tabs:String = ""):void
		{
			for(var el:String in data)
			{
				tracing(tabs + "" + el + "  -  " + data[el] + " (" + (typeof data[el]) + ")"); 
				
				traceObject(data[el], tabs + "\t");
			}
		}	
		
		public function addTracer(param_txt:TextField):void { output = param_txt; }
		
		protected function tracing(... args):void
		{
			trace(args);
			
			if(output != null)
			{
				output.appendText(args.toString() + "\n");
			}
		}
	}
}
