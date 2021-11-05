package harish
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class Rotation
	{
		public function rotateAroundInternalPoint(m:Matrix, x:Number, y:Number, angleDegrees:Number):void
		{		
			var p:Point = m.transformPoint(new Point(x, y));
			rotateAroundExternalPoint(m, p.x, p.y, angleDegrees);
		}
		
		public function rotateAroundExternalPoint(m:Matrix, x:Number, y:Number, angleDegrees:Number):void
		{
			//trace('x='+x+' y='+y);
			m.translate(-x, -y);
			m.rotate(angleDegrees*(Math.PI/180));
			m.translate(x, y);
		}
	}
}