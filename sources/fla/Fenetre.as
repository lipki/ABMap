package {
	
	import flash.display.Sprite
	import flash.display.Shape
	import flash.display.DisplayObject
	import flash.events.Event
	import flash.events.MouseEvent
	import fl.transitions.Tween
	import fl.transitions.easing.*
	import flash.net.URLRequest
	import flash.net.navigateToURL;

	
	public class Fenetre extends Sprite {
		
		private var APPLI:Application
		
		private var posObj:Object
		
		private var posX:Number
		private var posY:Number
		public var lx:Number
		public var ly:Number
		private var nbCase:int
		private var caseX:int
		private var caseY:int
		public var caseXA:int
		public var caseYA:int
		
		private var tweenX:Tween
		private var tweenY:Tween
		
		private var fond:Shape
		private var bt:Sprite
		private var carte:Sprite
		private var calque:Object
		private var calques:Sprite
		private var grille:Grille
		private var vide:VideSid
		public var explo:Exploration
		private var centre:Mir
		
		public function Fenetre (_posObj:Object, tcase:Object) {
			
			posObj = _posObj
			lx = tcase.lx
			ly = tcase.ly
			nbCase = tcase.nbCase
			calque = new Object()
			//doubleClickEnabled = true
			
			addEventListener(Event.ADDED_TO_STAGE, onAddStage)
			
			//fond noir 95%
			fond = new Shape()
			fond.graphics.beginFill(0x1B1B38, 0.95)
			fond.graphics.drawRect(0, 0, 10, 10)
			addChild(fond)
			
			//carte
			carte = new Sprite()
			addChild(carte)
			
			//calques
			calques = new Sprite()
			carte.addChild(calques)
			calque = new Array()
			
			// espace
			vide = new VideSid(APPLI)
			calque.vide = vide
			calques.addChild(vide)
			
			// explo
			explo = new Exploration(APPLI)			
			calque.explo = explo
			calques.addChild(explo)
			
			// grille
			grille = new Grille(APPLI, lx, ly, nbCase)
			calque.grille = grille
			calques.addChild(grille)
			
			//centre
			centre = new Mir()
			addChild(centre)
			
			// double click
			bt = new Sprite()
			bt.doubleClickEnabled = true
			bt.graphics.beginFill(0x000000, 0)
			bt.graphics.drawRect(0, 0, 10, 10)
			addChild(bt)
			
		}
		
		private function onAddStage ( event:Event ) {
			
			APPLI = parent
			
			stage.addEventListener(Event.RESIZE, onAddStage)
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove)
			addEventListener(MouseEvent.CLICK, onMouseDown)
			addEventListener(MouseEvent.MOUSE_WHEEL,mouse_Wheel)
			onPos ( null )
			
		}
		
		public function topGrid() {
			
			var topPosition:uint = calques.numChildren - 1
    		calques.setChildIndex(grille, topPosition)
			
		}
		
		private function onPos ( event:Event ) {
			
			var rTop:Number = posObj.top
			var rLeft:Number = posObj.left
			var rHeight:Number = stage.stageHeight - posObj.top - posObj.bottom
			var rWidth:Number = stage.stageWidth - posObj.left - posObj.right
			var rHcenter:Number = rHeight/2 + posObj.top
			var rWcenter:Number = rWidth/2 + posObj.left
			
			x = rWcenter
			y = rHcenter
			
			bt.y 		= fond.y 		= -rHcenter + posObj.top
			bt.x 		= fond.x 		= -rWcenter + posObj.left
			bt.height 	= fond.height 	= rHcenter*2
			bt.width 	= fond.width 	= rWcenter*2
			
		}
		
		public function addCalque(id:String):DisplayObject {
			
			if(calque[id])
				return calque[id]
			else {
				var calk:Calque = new ObjectCalque(APPLI)			
				calque[id] = calk
				
				var varName = 'view'+id.charAt(0).toUpperCase()+id.substring(1)
				if( APPLI.infoLoc.data[varName] != undefined && !APPLI.infoLoc.data[varName] ) APPLI.menu[varName](null)
				
				if(id == 'planet') calques.addChildAt(calk, 1)
				else calques.addChild(calk)
				return calk
			}
			
		}
		
		public function toogleCalque(id:String):Boolean {
			
			if( calque[id] )  {
				calque[id].visible = !calque[id].visible
				return calque[id].visible
			}
			
		}
		
		public function onMouseMove(event:MouseEvent) {
			
			posX = carte.mouseX
			posY = carte.mouseY
			
			caseX = Math.floor((posX+(lx/2))/lx)
			caseY = Math.floor((posY+(ly/2))/ly)
			
			try {
			APPLI.bulle.update(caseX, caseY)
			} catch (e:Error) {}
			
		}
		
		public function onMouseDown(event:MouseEvent) {
			
			if(!event.ctrlKey) bouge(caseX, caseY)
			else onDoubleClick(event)
			
		}

		public function mouse_Wheel(e:MouseEvent) {
			
			zoom( carte.scaleX+(e.delta/100) )
			APPLI.menu.slid_zoom.value = (carte.scaleX+(e.delta/100))*100
			
		}
		
		public function zoom(_zoom:Number) {
			
			if( !APPLI.zoomlock ) {
				_zoom = (_zoom > 1)? 1:( (_zoom < 0)? 0:_zoom)
				carte.scaleX = carte.scaleY = _zoom
				var pos:Object = getPos(caseXA, caseYA)
				carte.x = -pos.x
				carte.y = -pos.y
				
				calque.vide.alpha = carte.scaleX*2
				calque.grille.alpha = carte.scaleX*2
				
				// share
				APPLI.infoLoc.data.zoom = _zoom
				APPLI.infoLoc.flush()
				
			}
			
		}
		
		public function bouge(x:int, y:int, imm:Boolean = false ) {
			
			caseXA = x
			caseYA = y
			
			APPLI.refresh()
			
			if(tweenX && tweenY && tweenX.isPlaying) {
				tweenX.stop()
				tweenY.stop()
				carte.x = Math.round(carte.x/lx)*lx
				carte.y = Math.round(carte.y/ly)*ly
			}
			
			var pos:Object = getPos(caseXA, caseYA)
			
			if( imm ) {
				carte.x = -pos.x
				carte.y = -pos.y
			} else {
				tweenX = new Tween(carte, "x", None.easeOut, carte.x, -pos.x, 24)
				tweenY = new Tween(carte, "y", None.easeOut, carte.y, -pos.y, 24)
			}
			
			//navigateToURL(new URLRequest('javascript:window.location.replace("./#'+caseXA+','+caseYA+'");'))
			
			// share
			APPLI.infoLoc.data.posx = x
			APPLI.infoLoc.data.posy = y
			APPLI.infoLoc.flush()
			
		}
		
		public function getPos(x:int, y:int):Object {
			
			return {x:(x*lx)*carte.scaleX, y:(y*ly)*carte.scaleY}
			
		}
		
	}
	
}