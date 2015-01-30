package {
	
	import flash.display.MovieClip
	import flash.events.MouseEvent
	import flash.events.Event
	
	public class Case extends MovieClip {
		
		private var cas:XML
		private var APPLI:Application
		
		
		public function Case ( _cas:XML, isIcone:Boolean = false ) {
			
			cas = _cas
			
			if( isIcone ) addEventListener(Event.ADDED_TO_STAGE, onAddStageIcone)
			else addEventListener(Event.ADDED_TO_STAGE, onAddStage)
			
		}
		
		private function onAddStage ( event:Event ) {
			
			APPLI = parent.parent.parent.parent.parent
			
			gotoAndStop((cas.@frame == undefined)? cas.@type.toLowerCase():cas.@frame)
			var pos:Object = APPLI.fenetre.getPos(cas.@x, cas.@y)
			x = pos.x - APPLI.fenetre.lx/2 +1
			y = pos.y - APPLI.fenetre.ly/2 +1
			scaleX = (1/(100/APPLI.fenetre.lx))*((cas.@taille == undefined)? 1:cas.@taille)
			scaleY = (1/(100/APPLI.fenetre.ly))*((cas.@taille == undefined)? 1:cas.@taille)
			
			if(cas.@type == 'Asteroide') {
				var taille:Number = Math.random()
				clip.scaleX = clip.scaleY = taille+1
				clip.gotoAndStop(Math.floor(taille*69)+1)
				clip.smc.gotoAndStop(Math.floor(Math.random()*28)+1)
				clip.rotation = Math.random()*360
				clip.x = clip.y = 50 -(Math.random()*((100-clip.width))) +((100-clip.width)/2)
			}
			
		}
		
		private function onAddStageIcone ( event:Event ) {
			
			APPLI = parent.parent.parent.parent.parent
			
			gotoAndStop((cas.@frame == undefined)? cas.@type.toLowerCase():cas.@frame)
			scaleX = 0.4
			scaleY = 0.4
			
			if(cas.@type == 'Asteroide') {
				clip.gotoAndStop(69)
				clip.smc.gotoAndStop(1)
			}
			
		}
		
	}
	
}