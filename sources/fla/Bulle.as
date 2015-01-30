package {
	
	import flash.display.Sprite
	import flash.display.MovieClip
	import flash.text.TextField
	import flash.text.TextFormat
	import flash.text.TextFieldAutoSize
	import flash.events.Event
	
	public class Bulle extends Sprite {
		
		private var APPLI:Application
		
		public var bulle:Sprite
		public var txt_coor:TextField
		
		private var cx:int
		private var cy:int
		
		private var icones:Array
		
		public function Bulle () {
			
			addEventListener(Event.ADDED_TO_STAGE, onAddStage)
			
			bulle = new Sprite()
			icones = new Array()
			addChild(bulle)
			
			txt_coor = new TextField()
			txt_coor.autoSize = TextFieldAutoSize.LEFT
			txt_coor.selectable = false
			txt_coor.textColor = 0xffffff
			txt_coor.defaultTextFormat = new TextFormat('Courier New'/*, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = null*/) 
			addChild(txt_coor)
			
		}
		
		private function onAddStage ( event:Event ) { APPLI = parent }
		
		public function update(x, y) {
			
			if( cx != x || cy != y ) updateBis(x, y)
			
			cx = x; cy = y
			
			bulle.x = parent.mouseX
			bulle.y = parent.mouseY
			
			txt_coor.y = bulle.y+3
			txt_coor.x = bulle.x+30
			
		}
		
		private function updateBis(x, y) {
			
			for(var vu in icones ) bulle.removeChild( icones[vu] )
			icones = new Array()
			
			var texte:String = ''
			if(APPLI.info) {
				var node:XMLList = APPLI.info..cas.( @x == x && @y == y )
				
				txt_coor.htmlText = '\r'
				for( var va in node ) {
					var tex:String = node[va].remarque.children()
					var nam:String = node[va].@type +' '+ node[va].@frame +' '
					
					if( tex != '' ) {
						tex = tex.replace(/\n/gm, '')
						tex = ': \r\r'+tex.replace(/<br\/>/gm, '\r')
					}
					tex = '       -> <b>'+nam+'<b/>'+tex
					
					texte += '\n\n' + tex + '\n '
					
					var cas:Case = new Case(node[va], true)
					
					cas.x = 30 + ((node[va].@type == 'Planet')? 20:0)
					cas.y = txt_coor.height + ((node[va].@type == 'Planet')? 25:0)
					icones.push(cas)
					bulle.addChild(cas)
					
					txt_coor.htmlText += texte
				}
			}
			
			txt_coor.htmlText = '['+x+']['+y+']'+texte+'\r '
			
			bulle.graphics.clear()
			bulle.graphics.beginFill(0x000000, 1)
			bulle.graphics.moveTo(11, 0)
			bulle.graphics.lineTo(30, 2)
			bulle.graphics.lineTo(33 + txt_coor.width, 0)
			bulle.graphics.lineTo(35 + txt_coor.width, 5)
			bulle.graphics.lineTo(35 + txt_coor.width, 2 + txt_coor.height)
			bulle.graphics.lineTo(31 + txt_coor.width, 8 + txt_coor.height)
			bulle.graphics.lineTo(19 + txt_coor.width, 7 + txt_coor.height)
			bulle.graphics.lineTo(31, 7 + txt_coor.height)
			bulle.graphics.lineTo(27, 8 + txt_coor.height)
			bulle.graphics.lineTo(26, 7 + txt_coor.height)
			bulle.graphics.lineTo(23, 14)
			bulle.graphics.lineTo(7, 5)
			
			bulle.graphics.beginFill(0xFFD500, 1)
			bulle.graphics.moveTo(11, 2)
			bulle.graphics.lineTo(30, 4)
			bulle.graphics.lineTo(31 + txt_coor.width, 3)
			bulle.graphics.lineTo(33 + txt_coor.width, 6)
			bulle.graphics.lineTo(33 + txt_coor.width, 2 + txt_coor.height)
			bulle.graphics.lineTo(31 + txt_coor.width, 7 + txt_coor.height)
			bulle.graphics.lineTo(20 + txt_coor.width, 5 + txt_coor.height)
			bulle.graphics.lineTo(31, 5 + txt_coor.height)
			bulle.graphics.lineTo(29, 6 + txt_coor.height)
			bulle.graphics.lineTo(28, 5 + txt_coor.height)
			bulle.graphics.lineTo(25, 11)
			bulle.graphics.lineTo(9, 5)
			
			bulle.graphics.beginFill(0x89416F, 1)
			bulle.graphics.moveTo(11, 3)
			bulle.graphics.lineTo(30, 5)
			bulle.graphics.lineTo(30 + txt_coor.width, 4)
			bulle.graphics.lineTo(32 + txt_coor.width, 6)
			bulle.graphics.lineTo(32 + txt_coor.width, 0 + txt_coor.height)
			bulle.graphics.lineTo(30 + txt_coor.width, 6 + txt_coor.height)
			bulle.graphics.lineTo(20 + txt_coor.width, 4 + txt_coor.height)
			bulle.graphics.lineTo(32, 4 + txt_coor.height)
			bulle.graphics.lineTo(30, 5 + txt_coor.height)
			bulle.graphics.lineTo(29, 4 + txt_coor.height)
			bulle.graphics.lineTo(26, 10)
			bulle.graphics.lineTo(10, 5)
		}
		
	}
	
}