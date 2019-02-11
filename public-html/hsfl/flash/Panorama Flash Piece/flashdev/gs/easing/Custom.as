package gs.easing {
	public class Custom {
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			
			return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
		}
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			var ts:Number=(t/=d)*t;
			var tc:Number=ts*t;
			return b+c*(4.64499999999999*tc*ts + -16.9325*ts*ts + 24.48*tc + -17.69*ts + 6.4975*t);
		}
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
			return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
		}
	}
}