package com.kiko.utils
{
    import flash.utils.Timer;
    import flash.utils.getTimer;

    /**
     * DurationTimer
     * Description:
     * Extending Timer class to help show elapsed time
     **/
    public class DurationTimer extends Timer
    {
        private var _startTime:int;
        private var _endTime:int;

        public function DurationTimer( delay:Number, repeatCount:int = 0 )
        {
            super( delay, repeatCount );
        }

        public function get time():int
        { 
            return ( running ) ? getTimer() - _startTime : _endTime - _startTime;
        }

        override public function start():void
        {
            _startTime = getTimer();
            super.start();
        }

        override public function stop():void
        {
            _endTime = getTimer();
            super.stop();
        }
    }
}