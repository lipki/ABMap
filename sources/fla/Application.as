package {
	
	import flash.display.MovieClip
	import flash.events.Event
	import flash.net.URLRequest
	import flash.net.URLLoader
	import flash.net.SharedObject
	import flash.utils.setInterval
	import flash.utils.clearInterval
	
	[ExcludeClass]
	public class Application extends MovieClip {
		
		private var urlRacine:String
		
		private var listLoad:Array
		private var isLoad:Boolean
		
		public var fenetre:Fenetre
		public var bulle:Bulle
		public var menu:Menu
		public var zoomlock:Boolean = true
		
		public var info:XML
		public var listeCase:XMLList
		public var pointeur:int
		public var intervalId:uint
		
		public var infoLoc:SharedObject
		
		public static var APPLI:Application
		
		public function Application() {
			
			Application.APPLI = this
			
			// paramêtre du stage
			stage.scaleMode = "noScale"
			stage.align = "TL"
			
			// url racine
			urlRacine = (loaderInfo.parameters.index)? './core/':'../'
			unique = (loaderInfo.parameters.index)? Math.random():''
			
			// mass loader
			listLoad = new Array()
			isLoad = false
			
			// ShareObjet
			infoLoc = SharedObject.getLocal("infoLoc");
			if( infoLoc.data.zoom == undefined ) infoLoc.data.zoom = 1
			if( infoLoc.data.viewGrille == undefined ) infoLoc.data.viewGrille = true
			if( infoLoc.data.viewMarchand == undefined ) infoLoc.data.viewMarchand = true
			if( infoLoc.data.viewMarchandsol == undefined ) infoLoc.data.viewMarchandsol = true
			if( infoLoc.data.viewMissile == undefined ) infoLoc.data.viewMissile = true
			if( infoLoc.data.viewTrounoir == undefined ) infoLoc.data.viewTrounoir = true
			if( infoLoc.data.viewBonus == undefined ) infoLoc.data.viewBonus = true
			if( infoLoc.data.viewAntiradar == undefined ) infoLoc.data.viewAntiradar = true
			if( infoLoc.data.viewMission == undefined ) infoLoc.data.viewMission = true
			
			// position initiale
			ppx = (loaderInfo.parameters.x)? loaderInfo.parameters.x:infoLoc.data.posx
			ppy = (loaderInfo.parameters.y)? loaderInfo.parameters.y:infoLoc.data.posy
			
			// construction de la scéne
			makeScene( ppx, ppy )
			
			fenetre.bouge(ppx, ppy, true)
		}
		
		private function makeScene( ppx:int, ppy:int ) {
			
			// fenetre
			fenetre = new Fenetre({top:0, right:0, bottom:0, left:0}, {lx:20, ly:20, nbCase:500})
			this.addChild(fenetre)
			
			// menu
			menu = new Menu()
			this.addChild(menu)
				
			if( !infoLoc.data.viewGrille ) menu.viewGrille(null)
			if( !infoLoc.data.viewMarchand ) menu.viewMarchand(null)
			if( !infoLoc.data.viewMarchandsol ) menu.viewMarchandsol(null)
			if( !infoLoc.data.viewMissile ) menu.viewMissile(null)
			if( !infoLoc.data.viewTrounoir ) menu.viewTrounoir(null)
			if( !infoLoc.data.viewBonus ) menu.viewBonus(null)
			if( !infoLoc.data.viewAntiradar ) menu.viewAntiradar(null)
			if( !infoLoc.data.viewMission ) menu.viewMission(null)
			
			// bulle
			bulle = new Bulle()
			this.addChild(bulle)
			
			// chargement du xml
			var loader:URLLoader = new URLLoader()
				loader.addEventListener(Event.COMPLETE, completeHandler)
				loader.load(new URLRequest(urlRacine+"xml/info.php?x="+ppx+'&y='+ppy+'&uni='+unique))
			
		}
		
		public function completeHandler( event:Event ) {
			
			info = new XML(URLLoader(event.target).data)
			info.prettyIndent = 0
			
			listeCase = info..cas
			pointeur = 0
			
			intervalId = setInterval(affiche, 0.01)
			
		}
		
		private function affiche():void {
			
			var calque:Calque = fenetre.addCalque( 'planet' )
			if(pointeur < listeCase.length()) {
				var cas:XML = listeCase[pointeur]
				
					calque = fenetre.addCalque( cas.@type.toLowerCase() )
					calque.addChild(new Case(cas))
				
				menu.pourcent((pointeur*100)/listeCase.length(), cas.@type )
				
			} else {
				clearInterval(intervalId)
				fenetre.topGrid()
				menu.pourcent(100)
				
				zoomlock = false
				fenetre.zoom(infoLoc.data.zoom)
			}
			
			this.pointeur ++
			
		}
		
		public function massLoad ( ...args ) {
			
			if( args.length > 0 ) this.listLoad.push(args)
			
			if(!this.isLoad && this.listLoad.length > 0) {
				this.isLoad = true
				var args = this.listLoad.shift()
				var pictLdr = new Loader()
				pictLdr.contentLoaderInfo.addEventListener( Event.COMPLETE, args[1] )
				pictLdr.contentLoaderInfo.addEventListener( Event.COMPLETE, this.massLoadComplet )
				pictLdr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.massLoadComplet)
				pictLdr.load( new URLRequest( args[0] ) )
			}
			
		}
		private function massLoadComplet ( event:* ) {
			this.isLoad = false
			this.massLoad ()
		}
		
	}
	
}