package classes.mvc{

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	Импорт пакетов
	//
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Shape;
	import flash.events.Event;
	import classes.view.Platform;
	import classes.view.Ball;
	import classes.view.LifeBar;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import classes.view.Brick;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	Представление
	//
	public class View {
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Свойства класса
		//
		private const v_platformWidth:uint = 150;
		private const v_platformHeight:uint = 10;
		private const v_platformColor:uint = 0xACACAC;
		private const v_platformAlpha:Number = 1;
		private const v_platformCornerRadius:uint = 7;
		private const v_ballRadius:uint = 5;
		private const v_ballColor:uint = 0xFFFFFF;
		
		private var v_controller:Controller;
		private var v_model:Model;
		private var v_platform:Platform;
		private var v_ball:Ball;
		private var v_lifeBar:LifeBar;
		private var v_stage:Stage;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Конструктор
		//
		public function View(v_model:Model, v_controller:Controller, v_stage:Stage):void {
			this.v_model = v_model;
			this.v_controller = v_controller;
			this.v_stage = v_stage;

			this.v_stage.addEventListener(Event.ACTIVATE,_eventStageActivated);
			this.v_stage.addEventListener(MouseEvent.MOUSE_MOVE,event_MouseMove);
			this.v_stage.addEventListener(MouseEvent.CLICK,event_MouseClick);

			this.v_model.addEventListener(	this.v_model.event_PlatformMoved.type		,	event_PlatformMoved);
			this.v_model.addEventListener(	this.v_model.event_BallMoved.type			,	event_BallMoved);
			this.v_model.addEventListener(	this.v_model.event_LifesLeftChanged.type	,	event_LifesLeftChanged);
			this.v_model.addEventListener(	this.v_model.event_GameOver.type			,	event_GameOver);
			this.v_model.addEventListener(	this.v_model.event_BrickAdded.type			,	event_BrickAdded);

			this.v_platform = new Platform(this.v_platformWidth,this.v_platformHeight,this.v_platformColor,this.v_platformAlpha,this.v_platformCornerRadius);
			this.v_stage.addChild(this.v_platform);

			this.v_ball = new Ball(this.v_ballRadius,this.v_ballColor);
			this.v_stage.addChild(this.v_ball);
			
			this.v_lifeBar = new LifeBar();
			this.v_stage.addChild(this.v_lifeBar);

			this.event_LifesLeftChanged(new Event(''));
			
			var brick1:Brick = new Brick();
			this.v_model.BrickAdd(brick1);
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Сцена создана
		//
		public function _eventStageActivated ( v_event:Event):void {
			this.v_controller.event_PlatformAddedToStage(this.v_stage, this.v_platform , this.v_ball);
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Подвинута мышь
		//
		public function event_MouseMove ( v_event:MouseEvent):void {
			this.v_controller.event_MouseMove(v_event);
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Нажата кнопка мыши
		//
		public function event_MouseClick ( v_event:MouseEvent):void {
			this.v_controller.event_MouseClick(v_event);
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Платформа изменила свою координату
		//
		public function event_PlatformMoved ( v_event:Event):void {
			this.v_platform.x = this.v_model.get_m_platformPositionX;
			this.v_platform.y = this.v_model.get_m_platformPositionY;
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Шар изменил свою координату
		//
		public function event_BallMoved ( v_event:Event):void {
			this.v_ball.x = this.v_model.get_m_ballPositionX;
			this.v_ball.y = this.v_model.get_m_ballPositionY;
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Изменилось кол-во жизней
		//
		public function event_LifesLeftChanged ( v_event:Event):void {
			this.v_lifeBar.LifesLeftUpdate(this.v_model.get_m_lifesLeft);
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Игра окончена
		//
		public function event_GameOver ( v_event:Event):void {
			trace("GAME OVER");
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Добавлен кирпич
		//
		public function event_BrickAdded ( v_event:Event):void {
			trace("Brick Added");
		}
	}
}