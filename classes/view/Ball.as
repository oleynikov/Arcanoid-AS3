﻿package classes.view {
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	ИМПОРТ ПАКЕТОВ
	//
	import flash.display.Sprite;
	import flash.display.Shape;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	Ядро
	//
	public class Ball extends Sprite { 
	
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		СВОЙСТВА КЛАССА
		//
			
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		КОНСТРУКТОР КЛАССА
		//
		public function Ball	(	b_size:uint = 5,
									b_color:uint = 0xFCFCFC,
									b_alpha:Number = 1
								):void {
			var b_shape:Shape = new Shape();
				b_shape.graphics.beginFill (b_color,b_alpha);
				b_shape.graphics.drawCircle (b_size,b_size,b_size);
				b_shape.graphics.endFill ();
			this.addChild (b_shape);
			
		}
	}
}