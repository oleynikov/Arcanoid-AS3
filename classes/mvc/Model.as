package classes.mvc  {

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	Импорт пакетов
	//
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import classes.view.Brick;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//		Модель
	//
	public class Model extends EventDispatcher {
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Свойства класса
		//
		public const event_BallMoved:Event = new Event('BALL_MOVED');
		public const event_PlatformMoved:Event = new Event('PLATFORM_MOVED');
		public const event_LifesLeftChanged:Event = new Event('LIFES_LEFT_CHANGED');
		public const event_BrickAdded:Event = new Event('BRICK_ADDED');
		public const event_GameOver:Event = new Event('GAME_OVER');
		
		public var m_platformPositionTempX:uint;

		private var m_stageWidth:uint;
		private var m_stageHeight:uint;
		private var m_platformPositionX:uint;
		private var m_platformPositionY:uint;
		private var m_platformWidth:uint;
		private var m_platformHeight:uint;
		private var m_ballPositionX:uint;
		private var m_ballPositionY:uint;
		private var m_ballRadius:uint;
		private var m_platformSpeedX:Number;
		private var m_platformSpeedY:Number;
		private var m_ballAttached:Boolean;
		private var m_lifesLeft:uint;
		private var m_platformPositionOldX:uint;
		private var m_platformPositionOldY:uint;
		private var m_wall:Array;
				
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Конструктор
		//
		public function Model():void {
			this.m_wall = new Array();
			this.BrickAdd(new Brick());
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Setters
		//
		public function set set_m_stageWidth(m_value:Number):void {						// SET STAGE WIDTH
			this.m_stageWidth = m_value;
		}

		public function set set_m_stageHeight(m_value:Number):void {					// SET STAGE HEIGHT
			this.m_stageHeight = m_value;
		}

		public function set set_m_ballRadius(m_value:Number):void {						// SET BALL RADIUS
			this.m_ballRadius = m_value;
		}

		public function set set_m_ballPositionX(m_value:Number):void {					// SET BALL POSITION X
			this.m_ballPositionX = m_value;
			this.dispatchEvent(this.event_BallMoved);
		}

		public function set set_m_ballPositionY(m_value:Number):void {					// SET BALL POSITION Y
			this.m_ballPositionY = m_value;
			this.dispatchEvent(this.event_BallMoved);
		}

		public function set set_m_platformWidth (m_value:Number):void {					// SET PLATFORM WIDTH
			this.m_platformWidth = m_value;
		}

		public function set set_m_platformHeight (m_value:Number):void {				// SET PLATFORM HEIGHT
			this.m_platformHeight = m_value;
		}
		
		public function set set_m_platformPositionX(m_value:Number):void {				// SET PLATFORM POSITION X
			this.m_platformPositionX = m_value;
			this.dispatchEvent(this.event_PlatformMoved);
		}

		public function set set_m_platformPositionY(m_value:Number):void {				// SET PLATFORM POSITION Y
			this.m_platformPositionY = m_value;
			this.dispatchEvent(this.event_PlatformMoved);
		}
		
		public function set set_m_platformSpeedX (m_value:Number):void {				// SET PLATFORM SPEED X
			this.m_platformSpeedX = m_value;
		}
		
		public function set set_m_platformSpeedY (m_value:Number):void {				// SET PLATFORM SPEED Y
			this.m_platformSpeedY = m_value;
		}
		
		public function set set_m_lifesLeft (m_value:Number):void {						// SET LIFES LEFT
			this.m_lifesLeft = m_value;
			this.dispatchEvent(this.event_LifesLeftChanged);
		}
		
		public function set set_m_ballAttached (m_value:Boolean):void {					// SET BALL ATTACHED
			this.m_ballAttached = m_value;
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Getters
		//
		public function get get_m_stageWidth():uint {									// GET STAGE WIDTH
			return this.m_stageWidth;
		}

		public function get get_m_stageHeight():uint {									// GET STAGE HEIGHT
			return this.m_stageHeight;
		}

		public function get get_m_ballRadius():uint {									// GET BALL RADIUS
			return this.m_ballRadius;
		}

		public function get get_m_ballPositionX():uint {								// GET PLATFORM POSITION X
			return this.m_ballPositionX;
		}

		public function get get_m_ballPositionY():uint {								// GET PLATFORM POSITION Y
			return this.m_ballPositionY;
		}

		public function get get_m_platformWidth ():uint {								// GET PLATFORM WIDTH
			return this.m_platformWidth;
		}		

		public function get get_m_platformHeight ():uint {								// GET PLATFORM HEIGHT
			return this.m_platformHeight;
		}

		public function get get_m_platformPositionX():uint {							// GET PLATFORM POSITION X
			return this.m_platformPositionX;
		}

		public function get get_m_platformPositionY():uint {							// GET PLATFORM POSITION Y
			return this.m_platformPositionY;
		}
		
		public function get get_m_platformSpeedX ():Number {							// GET PLATFORM SPEED X
			return this.m_platformSpeedX;
		}
		
		public function get get_m_platformSpeedY ():Number {							// GET PLATFORM SPEED Y
			return this.m_platformSpeedY;
		}
		
		public function get get_m_lifesLeft ():Number {									// GET LIFES LEFT
			return this.m_lifesLeft;
		}
		
		public function get get_m_ballAttached ():Boolean {								// GET BALL ATTACHED
			return this.m_ballAttached;
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Изменить  количество оставлшихся жизней
		//
		public function LifesLeftChange (m_delta:Number):void {
			this.set_m_lifesLeft = this.m_lifesLeft + m_delta;
			if ( this.get_m_lifesLeft <= 0 ) {
				this.dispatchEvent(this.event_GameOver);
			}
		}
				
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Толкнуть платформу к месту назначения
		//
		public function PlatformGlide ( m_destination:uint , m_delay:uint):void {
			var c_platformGlideTween:Tween = new Tween(this , "m_platformPositionTempX" , Regular.easeOut, this.get_m_platformPositionX, m_destination , m_delay , false);
				c_platformGlideTween.addEventListener(TweenEvent.MOTION_CHANGE,eventPlatformPositionChange);
		}
		public function eventPlatformPositionChange (m_event:TweenEvent):void {
			this.set_m_platformSpeedX = this.m_platformPositionOldX - m_event.position;
			this.m_platformPositionOldX = this.get_m_platformPositionX;
			this.set_m_platformPositionX = m_event.position;
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//		Добавить кирпич
		//
		public function BrickAdd ( m_brick:Brick ):void {
			var m_brickId = this.m_wall.length;
			this.m_wall[m_brickId] = m_brick;
			this.dispatchEvent(this.event_BrickAdded);
		}
	}
}