package {
	
	import flash.display.Bitmap
	import flash.display.BitmapData
	
	public class Puzzle extends Calque {
		
		private var bit:BitmapData
		protected var themax:int
		
		public function Puzzle (_mi:Application) {
			super(_mi)
			
			bit = makeBit()
			
			var list:Array = new Array();
			var etape:int = 1;
			for(var pas:int = 0; pas < themax; pas++)
			for(var x:int = -pas; x <= pas; x++)
			for(var y:int = -pas; y <= pas; y++) {
				if(!list[x+themax]) list[x+themax] = new Array()
				if(!list[x+themax][y+themax]) {
					list[x+themax][y+themax] = etape ++
					place(x, y)
				}
			}
			
			cacheAsBitmap = true
		}
		
		public function makeBit():BitmapData {
			
			return new BitmapData(0, 0, true, 0x000000ff)
			
		}
		
		public function place(_x, _y):BitmapData {
			
			var bi:Bitmap = new Bitmap(bit)
			bi.x = -bi.width/2 +bi.width*_x
			bi.y = -bi.height/2 +bi.height*_y
			addChild(bi)
			
		}
		
		
		
	}
	
}