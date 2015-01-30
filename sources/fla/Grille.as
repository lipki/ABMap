package {
	
	import flash.display.MovieClip
	import flash.display.Shape
	import flash.display.BitmapData
	import flash.display.BlendMode
	
	public class Grille extends Puzzle {
		
		private var lx:Number
		private var ly:Number
		private var nbCase:int
		
		public function Grille (_mi:Application, _lx:Number, _ly:Number, _nbCase:int) {
			
			themax = 7
			
			lx = _lx
			ly = _ly
			nbCase = _nbCase
			super(_mi)

		}
		
		public override function makeBit():BitmapData {
			
			var largeur:Number = ((nbCase*2+1)*lx)/themax
			var hauteur:Number = ((nbCase*2+1)*ly)/themax
			
			var bit:BitmapData = new BitmapData(largeur, hauteur, true, 0x000000ff)
			
			ligne = new Shape()
			ligne.graphics.lineStyle(0, 0xffffff, 0.06)
			for(var max:int = 0; max <= largeur; max += lx) {
				ligne.graphics.moveTo(max, 0)
				ligne.graphics.lineTo(max, hauteur)
			}
			for(max = 0; max <= hauteur; max += ly) {
				ligne.graphics.moveTo(0, max)
				ligne.graphics.lineTo(largeur, max)
			}
			bit.draw(ligne)
			
			return bit
			
		}
		
	}
	
}