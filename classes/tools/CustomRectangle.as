﻿package classes.tools {

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	ИМПОРТ ПАКЕТОВ
	//
	import flash.display.Sprite;
	import flash.display.Shape;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	Прямоугольник
	//
	public class CustomRectangle extends Sprite {
	
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		СВОЙСТВА КЛАССА
		//
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		КОНСТРУКТОР КЛАССА
		//
		public function CustomRectangle	(	cr_width:uint = 100,
											cr_height:uint = 10,
											cr_color:uint = 0xACACAC,
											cr_alpha:Number = 1,
											cr_cornerRadius:uint = 7
										):void {
			var cr_shape:Shape = new Shape()
				cr_shape.graphics.lineStyle(0,0x000000,0);
				cr_shape.graphics.beginFill(cr_color,cr_alpha);
				cr_shape.graphics.drawRoundRect(0,0,cr_width,cr_height,cr_cornerRadius,cr_cornerRadius);
				cr_shape.graphics.endFill();
			this.addChild(cr_shape);
		}
	}
}