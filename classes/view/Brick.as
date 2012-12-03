﻿package classes.view {

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//		Импорт пакетов
	//
	import flash.display.Sprite;
	import flash.display.Shape;
	import classes.tools.CustomRectangle;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//		Кирпич
	//
	public class Brick extends CustomRectangle {
	
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Свойства класса
		//
		private var b_id:uint;
		private var b_type:uint;
		private var b_positionX:uint;
		private var b_positionY:uint;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Конструктор класса
		//
		public function Brick	(	b_type:uint = 0,
								 	b_color:uint = 0xfafafa,
									b_width:uint = 40,
									b_height:uint = 20,
									b_alpha:Number = 1,
									b_cornerRadius:uint = 7
								):void {
			super ( b_width , b_height , b_color , b_alpha , b_cornerRadius );
		}
	}
}