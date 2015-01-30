package {
	
	import flash.display.DisplayObject
	import flash.display.BitmapData
	import flash.geom.Rectangle
	import flash.geom.Point
	
	public class ObjectCalque extends Calque {
		
		protected var COTE:int = 2500
		private var vide:BitmapData
		
		public function ObjectCalque (_mi:Application) {
			super(_mi)
			
			//vide = new BitmapData(COTE, COTE, true, 0xff000000)
			//addChild(vide)
		}
		
		/*public override function addChild ( child:DisplayObject ):DisplayObject {
			
			var item:BitmapData = new BitmapData(COTE, COTE, true, 0x000000ff)
			item.draw(child)
			vide.copyPixels(item, new Rectangle(0, 0, COTE, COTE), new Point(0, 0), null, null, true)
			
			return child
		}*/
		
	}
	
}