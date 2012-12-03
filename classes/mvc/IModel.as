package classes.components{

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//		Импорт пакетов
	//
	import flash.events.IEventDispatcher;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	//		Интерфейс модели
	//
	public interface IModel extends IEventDispatcher {
		function set set_m_stageWidth(m_value:Number):void;
		function set set_m_stageHeight(m_value:Number):void;
		function set set_m_platformPositionX (m_value:Number):void;
		function set set_m_platformPositionY (m_value:Number):void;
		function set set_m_platformWidth (m_value:Number):void;
		function set set_m_platformHeight (m_value:Number):void;
		function get get_m_stageWidth():uint;
		function get get_m_stageHeight():uint;
		function get get_m_platformPositionX ():uint;
		function get get_m_platformPositionY ():uint;
		function get get_m_platformWidth ():uint;
		function get get_m_platformHeight ():uint;
	}
}