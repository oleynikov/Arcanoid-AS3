package classes.mvc {

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//		Импорт пакетов
	//
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import fl.motion.MotionEvent;
	import fl.transitions.Tween;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Timer;
	import classes.view.Platform;
	import classes.view.Ball;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//		Контроллер
	//
	public class Controller {

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Свойства класса
		//
		private const c_platformGapHorisontal:uint = 5;				// Горизонтальный зазор между платформой и краем экрана
		private const c_platformGapVertical:uint = 5;				// Вертикальный зазор между платформой и краем экрана
		private const c_platformBallGap:uint = 2;					// Зазор между платформой и шаром
		private const c_platformSpeedDelay:uint = 30;				// Задержка горизонтальной скорости платформы
		private const c_lifesLeftPool:uint = 5;						// Начальное количество жизней

		private var c_model:Model;									// Модель приложения
		private var c_ballSpeedHor:Number;
		private var c_ballSpeedVert:Number;
		private var c_ballMoveTimer:Timer;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Конструктор
		//
		public function Controller (c_model:Model) {
			this.c_model = c_model;
			this.c_model.set_m_ballAttached = true;
			this.c_model.set_m_lifesLeft = this.c_lifesLeftPool;
			
			this.c_ballSpeedHor = 2;
			this.c_ballSpeedVert = -2;
			
			this.c_ballMoveTimer = new Timer(1);
			this.c_ballMoveTimer.addEventListener(TimerEvent.TIMER,event_BallMoveTimer);
			
			this.c_model.addEventListener('PLATFORM_MOVED',event_PlatformMoved);
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Платформа добавлена на сцену
		//
		public function event_PlatformAddedToStage(c_stage:Stage,c_platform:Platform,c_ball:Ball):void {			
			this.c_model.set_m_stageWidth = c_stage.stageWidth;
			this.c_model.set_m_stageHeight = c_stage.stageHeight;
			this.c_model.set_m_ballRadius = c_ball.width;
			this.c_model.set_m_platformWidth = c_platform.width;
			this.c_model.set_m_platformHeight = c_platform.height;
			this.c_model.set_m_platformPositionX = this.c_model.get_m_stageWidth / 2 - this.c_model.get_m_platformWidth / 2;
			this.c_model.set_m_platformPositionY = this.c_model.get_m_stageHeight - this.c_model.get_m_platformHeight - this.c_platformGapVertical;
		} 
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Подвинута мышь
		//
		public function event_MouseMove (c_event:MouseEvent):void {
			var c_mousePositionX:uint = c_event.stageX;
			var c_mousePositionY:uint = c_event.stageY;
			var c_stageWidth:uint = this.c_model.get_m_stageWidth;
			var c_platformWidth:uint = this.c_model.get_m_platformWidth;
			var c_mousePositionMin:uint = c_platformWidth / 2 + this.c_platformGapHorisontal;
			var c_mousePositionMax:uint = c_stageWidth - c_platformWidth / 2 - this.c_platformGapHorisontal;
			var c_platformPositionHorisontalNew:uint;
			var c_platformPositionHorisontalTemp:uint;
			


			if ( c_mousePositionX >= c_mousePositionMin && c_mousePositionX <= c_mousePositionMax ) {
				c_platformPositionHorisontalNew = c_event.stageX - this.c_model.get_m_platformWidth / 2;
			}
			else if ( c_mousePositionX < c_mousePositionMin ) {
				c_platformPositionHorisontalNew = this.c_platformGapHorisontal;
			}
			else if ( c_mousePositionX > c_mousePositionMax ) {
				c_platformPositionHorisontalNew = c_stageWidth - c_platformWidth - this.c_platformGapHorisontal;
			}
			
			this.c_model.PlatformGlide(c_platformPositionHorisontalNew,this.c_platformSpeedDelay);
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Нажата мышь
		//
		public function event_MouseClick (c_event:MouseEvent):void {
			if ( this.c_model.get_m_ballAttached ) {
				this.c_model.set_m_ballAttached = false;
				this.c_ballMoveTimer.start();
			}
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Платформу подвинули
		//
		public function event_PlatformMoved (c_event:Event):void {
			if ( this.c_model.get_m_ballAttached ) {
				this.c_model.set_m_ballPositionX = this.c_model.get_m_platformPositionX + this.c_model.get_m_platformWidth / 2 - this.c_model.get_m_ballRadius / 2;
				this.c_model.set_m_ballPositionY = this.c_model.get_m_platformPositionY - this.c_model.get_m_ballRadius - this.c_platformBallGap;
			}
		}		

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Мяч выстрелил
		//		
		public function event_BallMoveTimer (c_event:TimerEvent):void {
			// Проверка на выход за вертикальные границы
			if (this.c_model.get_m_ballPositionX + this.c_ballSpeedHor < 0) {
				this.c_model.set_m_ballPositionX = 0;
				this.c_ballSpeedHor *=  -1;
			}
			else if (this.c_model.get_m_ballPositionX + this.c_ballSpeedHor + this.c_model.get_m_ballRadius > this.c_model.get_m_stageWidth ) {
				this.c_model.set_m_ballPositionX = this.c_model.get_m_stageWidth - this.c_model.get_m_ballRadius;
				this.c_ballSpeedHor *=  -1;
			}
			
			// Проверка на выход за горизонтальные границы
			if (this.c_model.get_m_ballPositionY + this.c_ballSpeedVert < 0) {
				this.c_model.set_m_ballPositionY = 0;
				this.c_ballSpeedVert *=  -1;
			}
			else if (this.c_model.get_m_ballPositionY > this.c_model.get_m_stageHeight ) {
				this.c_ballMoveTimer.stop();
				this.c_model.LifesLeftChange(-1);
				if ( this.c_model.get_m_lifesLeft > 0 ) {
					var c_pauseTimer:Timer = new Timer(1500,1);
						c_pauseTimer.start();
						c_pauseTimer.addEventListener(TimerEvent.TIMER_COMPLETE,BallReset);
				}
			}
			if ( ! this.c_model.get_m_ballAttached ) {
				this.c_model.set_m_ballPositionX = this.c_model.get_m_ballPositionX + this.c_ballSpeedHor;
				this.c_model.set_m_ballPositionY = this.c_model.get_m_ballPositionY + this.c_ballSpeedVert;
			}
			
			// Проверка удара о платформу
			if (	this.c_model.get_m_ballPositionY + this.c_model.get_m_ballRadius >= this.c_model.get_m_platformPositionY
						&&
					this.c_model.get_m_ballPositionX + this.c_model.get_m_ballRadius >= this.c_model.get_m_platformPositionX
						&&
					this.c_model.get_m_ballPositionX <= this.c_model.get_m_platformPositionX + this.c_model.get_m_platformWidth
				) {
					this.c_ballSpeedVert *= -1;
				}
		}
		
				
		public function BallReset (c_event:TimerEvent):void {
			this.c_model.set_m_ballAttached = true;
			
			this.c_model.set_m_ballPositionX = this.c_model.get_m_platformPositionX + this.c_model.get_m_platformWidth / 2 - this.c_model.get_m_ballRadius / 2;;
			this.c_model.set_m_ballPositionY = this.c_model.get_m_platformPositionY - this.c_model.get_m_ballRadius - this.c_platformBallGap;
		}
	}
}