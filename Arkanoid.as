﻿package {

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	ИМПОРТ ПАКЕТОВ
	//
	import flash.display.MovieClip;
	import classes.mvc.Controller;
	import classes.mvc.Model;
	import classes.mvc.View;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	ГЛАВНЫЙ КЛАСС
	//
	public class Arkanoid extends MovieClip {

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		СВОЙСТВА КЛАССА
		//
				
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		КОНСТРУКТОР КЛАССА
		//
		public function Arkanoid() {
			var model:Model = new Model();
			var controller:Controller = new Controller(model);
			var view:View = new View(model,controller,this.stage);
		}
	}
}