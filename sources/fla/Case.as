package {
	
	import flash.display.MovieClip
	import flash.events.MouseEvent
	import flash.events.Event
	
	public class Case extends MovieClip {
		
		private var cas:Object
		private var APPLI:Application
		
		public var clip:MovieClip
		
		public function Case ( _cas:Object, isIcone:Boolean = false ) {
			
			cas = _cas
			
			if( isIcone ) addEventListener(Event.ADDED_TO_STAGE, onAddStageIcone)
			else addEventListener(Event.ADDED_TO_STAGE, onAddStage)
			
		}
		
		private function onAddStage ( event:Event ) {
			
			APPLI = parent.parent.parent.parent.parent
			
			gotoAndStop((cas.view == undefined)? cas.type:cas.view)
			var pos:Object = APPLI.fenetre.getPos(cas.x, cas.y)
			x = pos.x - APPLI.fenetre.lx/2 +1
			y = pos.y - APPLI.fenetre.ly/2 +1
			scaleX = (1/(100/APPLI.fenetre.lx))*((cas.size == undefined)? 1:cas.size)
			scaleY = (1/(100/APPLI.fenetre.ly))*((cas.size == undefined)? 1:cas.size)
			
			if(cas.type == 'asteroide') {
				var size:Number = Math.random()
				clip.scaleX = clip.scaleY = size+1
				clip.gotoAndStop(Math.floor(size*69)+1)
				clip.smc.gotoAndStop(Math.floor(Math.random()*28)+1)
				clip.rotation = Math.random()*360
				clip.x = clip.y = 50 -(Math.random()*((100-clip.width))) +((100-clip.width)/2)
			}
			
		}
		
		private function onAddStageIcone ( event:Event ) {
			
			APPLI = parent.parent.parent.parent.parent
			
			gotoAndStop((cas.view == undefined)? cas.type.toLowerCase():cas.view)
			scaleX = 0.4
			scaleY = 0.4
			
			if(cas.type == 'asteroide') {
				clip.gotoAndStop(69)
				clip.smc.gotoAndStop(1)
			}
			
		}
		
	}
	
}