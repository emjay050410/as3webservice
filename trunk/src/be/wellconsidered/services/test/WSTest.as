/**
 * @author Pieter Michels / wellconsidered
 *
 * Open source under the GNU Lesser General Public License (http://www.opensource.org/licenses/lgpl-license.php)
 * Copyright © 2008 Pieter Michels / wellconsidered
 * 
 * This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License 
 * as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 * You should have received a copy of the GNU Lesser General Public License along with this library; 
 * if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
 */
 
package be.wellconsidered.services.test
{
	import be.wellconsidered.services.Operation;
	import be.wellconsidered.services.WebService;
	import be.wellconsidered.services.events.OperationEvent;
	
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class WSTest
	{
		private var output:TextField;
		
		public function WSTest(){ trace("Start Test"); }

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
			
			var tmp_6_tmr:Timer = new Timer(2500, 1);
			tmp_6_tmr.addEventListener(TimerEvent.TIMER_COMPLETE,  function(evt:TimerEvent):void { testPinueutEcard(); });
			tmp_6_tmr.start();			
			
			var tmp_7_tmr:Timer = new Timer(3000, 1);
			tmp_7_tmr.addEventListener(TimerEvent.TIMER_COMPLETE,  function(evt:TimerEvent):void { testPinueutEcardOld(); });
			tmp_7_tmr.start();			
			
			var tmp_8_tmr:Timer = new Timer(3500, 1);
			tmp_8_tmr.addEventListener(TimerEvent.TIMER_COMPLETE,  function(evt:TimerEvent):void { testWalibiVertigoTrack(); });
			tmp_8_tmr.start();			
		}
		
		public function testPinueutEcardOld():void
		{
			var w:WebService = new WebService("http://campaigns.ing.be/pineut/ws_old/ws.asmx?wsdl");
			var o:Operation = new Operation(w);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault); 
			
			o.SaveEcard({PARENTGUID: "6581df8b-1c1b-495b-8a5e-814e46ae66ae", ECARDID: "2", R_FIRSTNAME: "F", R_GENDER: "M", R_SOUND: "S", R_EMAIL: "E", VIDEO_ID: "3", ECARDSOUNDS: [{type: "0", value: "00"}, {type: "1", value: "11"}, {type: "2", value: "22"}, {type: "3", value: "33"}], LANG: "NL"});
		}
		
		public function testPinueutEcard():void
		{
			var w:WebService = new WebService("http://campaigns.ing.be/pineut/ws/ws.asmx?wsdl");
			var o:Operation = new Operation(w);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault); 
			
			o.SaveEcard({PARENTGUID: "", ECARDID: "", R_FIRSTNAME: "", R_GENDER: "", R_SOUND: "", R_EMAIL: "", VIDEO_ID: "", ECARDCOUDS: ["", "", "", "", ""], LANG: "NL"});
		}
		
		public function testWalibiVertigoTrack():void
		{
			var w:WebService = new WebService("http://www.walibivertigo.be/ws/ws.asmx?wsdl");
			var o:Operation = new Operation(w);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault);
			
			o.track({PAGECODE:"pagecode", USERGUID:"", SOURCECODE:"sourcecode", SESSIONGUID:"61438b78-bcc4-4120-94a9-b3b8c00fefb9", COOKIEGUID:"", LANG:"nl"});   
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
			
			o.getAllJobs_lite("nl");
		}	
		
		public function testMXR():void
		{
			var w:WebService = new WebService("http://musicmixer.rmxr.com/zine-eu/Mixer/Portal?wsdl");
			var o:Operation = new Operation(w);
			
			o.addEventListener(OperationEvent.COMPLETE, onResult);
			o.addEventListener(OperationEvent.FAILED, onFault);
			
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