package com
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.filters.*;
    import flash.geom.*;

    public class BoundarySelectMarker extends Shape
    {
        private var timer:Timer;

        public function BoundarySelectMarker()
        {
            super();
            this.timer = null;
        }

        public function setTimeOut():void
        {
            if(this.timer == null)
            {
                this.timer = new Timer(5000);
                this.timer.addEventListener(TimerEvent.TIMER, this.timeOut);
            }

            this.timer.stop();
            this.timer.start();
        }

        //It should be called only after ElementMarker is placed in the display list
        public function drawBorder(boundary:Object, scaleFactor:Number):void
        {
            this.graphics.clear();
            this.graphics.lineStyle(2, 0xFF0000);

            if(boundary.angle == 0)
            {
                this.graphics.moveTo(scaleFactor*boundary.v1.x, -scaleFactor*boundary.v1.y);
                this.graphics.lineTo(scaleFactor*boundary.v2.x, -scaleFactor*boundary.v2.y);
            }
            else
            {
                var arcInfo:Object = Geometry.getArcInfo(boundary);
                DrawingShapes.drawArc1(this.graphics, arcInfo, scaleFactor);
            }
        }

        public function timeOut(evt:TimerEvent):void
        {
            if(this.parent != null)
            {
                this.timer.stop();
                this.parent.removeChild(this);
            }
        }
    }
}
