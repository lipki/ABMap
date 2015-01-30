package {
	
	import flash.display.Shape
	import flash.display.BitmapData
	import flash.display.BitmapDataChannel
	import flash.geom.ColorTransform
    import flash.filters.BitmapFilterQuality
	import flash.geom.Rectangle
	import flash.geom.Point
	import flash.filters.GlowFilter
	
	public class VideSid extends Puzzle {
		
		protected var COTE:int = 2500
		
		public function VideSid (_mi:Application) {
			themax = 6
			super(_mi)
		}
		
		public override function makeBit():BitmapData {
			
			var seed:Number = Math.floor(Math.random() * 100)
			var channels:uint = BitmapDataChannel.RED | BitmapDataChannel.BLUE | BitmapDataChannel.GREEN
			
			var vide:BitmapData = new BitmapData(COTE, COTE, true)
				vide.perlinNoise(COTE/5, COTE/5, 1, seed, true, true, channels, false, null)
			
			var resultColorTransform:ColorTransform = new ColorTransform()
				resultColorTransform.redOffset = 6
				resultColorTransform.greenOffset = 6
				resultColorTransform.blueOffset = 42
				resultColorTransform.redMultiplier = 0.17
				resultColorTransform.greenMultiplier = 0.17
				resultColorTransform.blueMultiplier = 0.17
				
				vide.colorTransform(new Rectangle(0, 0, COTE, COTE), resultColorTransform)
				
				var etoiles:BitmapData = new BitmapData(COTE, COTE, true, 0x000000ff)
				var etoilenet:BitmapData = new BitmapData(COTE, COTE, true, 0x000000ff)
			
			var themax = 20000
				for(var max:int = 0; max < themax; max++) {
					var ex:Number = Math.random()*COTE
					var ey:Number = Math.random()*COTE
					var er:Number = Math.random()*1.1
					
					etoile = new Shape()
					etoile.graphics.beginFill(0xffffff, 1)
					etoile.graphics.drawCircle(ex, ey, er)
					
					resultColorTransform = new ColorTransform()
					resultColorTransform.alphaMultiplier = Math.random()/2
					
					etoiles.draw(etoile, null, resultColorTransform)
				}
				
				etoilenet.copyPixels(etoiles, new Rectangle(0, 0, COTE, COTE), new Point(0, 0))
				etoiles.applyFilter(etoiles, new Rectangle(0, 0, COTE, COTE), new Point(0, 0), new GlowFilter(0xffffff, 1, 7, 7, 10, BitmapFilterQuality.HIGH))
				etoiles.copyPixels(etoilenet, new Rectangle(0, 0, COTE, COTE), new Point(0, 0), null, null, true)
			
				vide.copyPixels(etoiles, new Rectangle(0, 0, COTE, COTE), new Point(0, 0), null, null, true)
				
				return vide
			
		}
		
	}
	
}