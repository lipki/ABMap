package {
	
	import flash.display.MovieClip
	import flash.events.Event
	import flash.net.URLRequest
	import flash.net.URLLoader
	import flash.net.SharedObject
	import flash.utils.setInterval
	import flash.utils.clearInterval
	import flash.events.NetStatusEvent
	import flash.events.SecurityErrorEvent
	import flash.net.NetConnection
    import flash.net.ObjectEncoding
    import flash.net.Responder

	
	public class Application extends MovieClip {
		
		private var urlRacine:String
		
		private var listLoad:Array
		private var isLoad:Boolean
		
		public var fenetre:Fenetre
		public var bulle:Bulle
		public var menu:Menu
		public var zoomlock:Boolean = true
		
		public var info:XML
		public var oldresult:Object
		public var newresult:Object
		public var listeCase:Array
		public var listeCaseLoad:Array
		public var pointeur:int
		public var intervalId:uint
		
		public var infoLoc:SharedObject
		
		public static var APPLI:Application
		
		public var url:String
		public var nc = new NetConnection()
		
		public function Application() {
			
			Application.APPLI = this
			
			// paramêtre du stage
			stage.scaleMode = "noScale"
			stage.align = "TL"
			
			// url racine
			urlRacine = (loaderInfo.parameters.index)? './core/':'../'
			unique = (loaderInfo.parameters.index)? Math.random():''
			url = (loaderInfo.parameters.index)? "http://www.lepeltier.info/amfphp/gateway.php":"http://localhost/amfphp/gateway.php"
			
			// connexion a la base de donnée
			nc.objectEncoding = ObjectEncoding.AMF0
            nc.connect(url)
			
			// mass loader
			/*listLoad = new Array()
			isLoad = false
			*/
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

		}
		
		public function refresh ():void {
			
			clearInterval(intervalId)
			
			// chargement
			var pasx = Math.round(stage.stageWidth/2/fenetre.lx)
			var pasy = Math.round(stage.stageHeight/2/fenetre.ly)
			var borneG = fenetre.caseXA-pasx
			var borneD = fenetre.caseXA+pasx
			var borneH = fenetre.caseYA-pasy
			var borneB = fenetre.caseYA+pasy
			var cquery = 'SELECT '+
							'*, ABS((x-('+fenetre.caseXA+'))+(y-('+fenetre.caseYA+'))) AS dist '+
						 'FROM '+
						 	'object '+
						 'WHERE '+
						 	'x+size > '+borneG+' '+
							'AND x-size < '+borneD+' '+
							'AND y+size > '+borneH+' '+
							'AND y-size < '+borneB+' '+
						'ORDER BY size DESC , dist ASC'
			trace(cquery)
			query(cquery, onResult)
		}
      
		public function query ( $query , onResult_):void {
			nc.call("DB.query",new Responder(onResult_, onFault),$query)
		}
		
		private function onResult ( result:Object ):void {
			
			for ( var cas:Number in oldresult )
				listeCaseLoad[oldresult[cas].x][oldresult[cas].y][oldresult[cas].id].visible = false
			
			oldresult = newresult
			newresult = (result as Array)
			
			listeCase = new Array()
			
			for ( var cas:Number in result ) {
				if( listeCaseLoad == undefined ) listeCaseLoad = new Array()
				if( listeCaseLoad[result[cas].x] == undefined ) listeCaseLoad[result[cas].x] = new Array()
				if( listeCaseLoad[result[cas].x][result[cas].y] == undefined ) listeCaseLoad[result[cas].x][result[cas].y] = new Array()
				if( listeCaseLoad[result[cas].x][result[cas].y][result[cas].id] == undefined ) {
					item = new Case(result[cas])
					listeCaseLoad[result[cas].x][result[cas].y][result[cas].id] = item
					calque = fenetre.addCalque( result[cas].type )
					calque.addChild(item)
				}
				listeCaseLoad[result[cas].x][result[cas].y][result[cas].id].visible = true
			}
			
			fenetre.topGrid()
			
		}
		
		private function onFault ( erreur:Object ):void {
			trace("> fault : " + erreur)
		}
		
		/*public function massLoad ( ...args ) {
			
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
		}*/
		
	}
	
}