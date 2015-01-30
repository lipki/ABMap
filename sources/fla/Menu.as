package {
	
	import flash.display.Sprite
	import flash.events.Event
	import flash.events.MouseEvent
	import flash.display.MovieClip
	import flash.text.TextField
	import fl.events.SliderEvent
	import flash.events.FocusEvent
	import flash.events.KeyboardEvent
	import flash.utils.setTimeout
	import flash.utils.clearTimeout
	
	public class Menu extends Sprite {
		
		private var APPLI:Application
		
		public var mc_pourcent:MovieClip
		public var intervalId:uint
		
		public function Menu () {
			
			addEventListener(Event.ADDED_TO_STAGE, onAddStage)
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver)
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut)
			slid_zoom.addEventListener(SliderEvent.THUMB_DRAG, sliderChanged)
			btn_go.addEventListener(MouseEvent.CLICK, go)
			
			txt_x.tabIndex = 1
			txt_y.tabIndex = 2
			btn_go.tabEnabled = true
			btn_go.tabIndex = 3
			
			txt_x.addEventListener(MouseEvent.CLICK, function():void{txt_x.setSelection (0, txt_x.length);})
			txt_x.addEventListener(MouseEvent.CLICK, function():void{txt_y.setSelection (0, txt_y.length);})
			txt_y.addEventListener(FocusEvent.FOCUS_IN, function():void{txt_y.setSelection (0, txt_y.length);})
			addEventListener(KeyboardEvent.KEY_DOWN, 
				function(event:KeyboardEvent):void{
					if(event.keyCode == 13) go(null)
				})
			
			pourcent(0)
			
			btn_grille.gotoAndStop(15)
			btn_carte_marchand.gotoAndStop(1)
			btn_carte_smarchand.gotoAndStop(3)
			btn_carte_missile.gotoAndStop(5)
			btn_carte_trounoir.gotoAndStop(7)
			btn_carte_bonus.gotoAndStop(9)
			btn_carte_antiradar.gotoAndStop(11)
			btn_carte_mission.gotoAndStop(13)
			
			btn_grille.addEventListener(MouseEvent.CLICK, viewGrille)
			btn_carte_marchand.addEventListener(MouseEvent.CLICK, viewMarchand)
			btn_carte_smarchand.addEventListener(MouseEvent.CLICK, viewMarchandsol)
			btn_carte_missile.addEventListener(MouseEvent.CLICK, viewMissile)
			btn_carte_trounoir.addEventListener(MouseEvent.CLICK, viewTrounoir)
			btn_carte_bonus.addEventListener(MouseEvent.CLICK, viewBonus)
			btn_carte_antiradar.addEventListener(MouseEvent.CLICK, viewAntiradar)
			btn_carte_mission.addEventListener(MouseEvent.CLICK, viewMission)
			
		}
		
		private function onAddStage ( event:Event ) {
			
			APPLI = parent
			stage.addEventListener(Event.RESIZE, onResize)
			onPos ( null )
			
		}
		
		private function onResize ( event:Event ) {
			
			onPos ( null )
			clearTimeout(intervalId)
			intervalId  = setTimeout(APPLI.refresh, 1000)
			
		}
		
		public function onMouseOver(event:MouseEvent) { APPLI.bulle.visible = false }
		public function onMouseOut(event:MouseEvent) { APPLI.bulle.visible = true }
		
		private function onPos ( event:Event ) {
			
			y = stage.stageHeight-34
			mc_fond.width = stage.stageWidth
			mc_pourcent.x = stage.stageWidth - 20
			
		}
		
		public function pourcent( val:Number, lab:String = '' ) {
			
			var frame:int = 160-Math.floor(val*1.6)
			mc_pourcent.gotoAndStop(frame)
			//if( frame < 158 ) mc_pourcent.te.text = Math.floor(val)+'%'
			//mc_pourcent.texte.text = lab
			
		}
		
		private function sliderChanged(event:SliderEvent):void {
			
			APPLI.fenetre.zoom(event.target.value/100)
			
		}
		
		private function go(event:MouseEvent):void {
			
			APPLI.fenetre.bouge(Number(txt_x.text), Number(txt_y.text))
			
		}
		
		public function viewGrille(event:MouseEvent):void {
			var visi:Boolean = APPLI.fenetre.toogleCalque('grille')
			btn_grille.gotoAndStop( (visi)?15:16 )
			APPLI.infoLoc.data.viewGrille = visi
			APPLI.infoLoc.flush()
		}
		public function viewMarchand(event:MouseEvent):void {
			var visi:Boolean = APPLI.fenetre.toogleCalque('marchand')
			btn_carte_marchand.gotoAndStop( (visi)?1:2 )
			APPLI.infoLoc.data.viewMarchand = visi
			APPLI.infoLoc.flush()
		}
		public function viewMarchandsol(event:MouseEvent):void {
			var visi:Boolean = APPLI.fenetre.toogleCalque('marchandsol')
			btn_carte_smarchand.gotoAndStop( (visi)?3:4 )
			APPLI.infoLoc.data.viewMarchandsol = visi
			APPLI.infoLoc.flush()
		}
		public function viewMissile(event:MouseEvent):void {
			var visi:Boolean = APPLI.fenetre.toogleCalque('missile')
			btn_carte_missile.gotoAndStop( (visi)?5:6 )
			APPLI.infoLoc.data.viewMissile = visi
			APPLI.infoLoc.flush()
		}
		public function viewTrounoir(event:MouseEvent):void {
			var visi:Boolean = APPLI.fenetre.toogleCalque('trounoir')
			btn_carte_trounoir.gotoAndStop( (visi)?7:8 )
			APPLI.infoLoc.data.viewTrounoir = visi
			APPLI.infoLoc.flush()
		}
		public function viewBonus(event:MouseEvent):void {
			var visi:Boolean = APPLI.fenetre.toogleCalque('bonus')
			btn_carte_bonus.gotoAndStop( (visi)?9:10 )
			APPLI.infoLoc.data.viewBonus = visi
			APPLI.infoLoc.flush()
		}
		public function viewAntiradar(event:MouseEvent):void {
			var visi:Boolean = APPLI.fenetre.toogleCalque('antiradar')
			btn_carte_antiradar.gotoAndStop( (visi)?11:12 )
			APPLI.infoLoc.data.viewAntiradar = visi
			APPLI.infoLoc.flush()
		}
		public function viewMission(event:MouseEvent):void {
			var visi:Boolean = APPLI.fenetre.toogleCalque('mission')
			btn_carte_mission.gotoAndStop( (visi)?13:14 )
			APPLI.infoLoc.data.viewMission = visi
			APPLI.infoLoc.flush()
		}
		
	}
	
}