/**
 * Created by IntelliJ IDEA.
 * User: onemangroup
 * Date: 04.10.12
 * Time: 20:37
 * To change this template use File | Settings | File Templates.
 */
package com.omg.utils.geo
{
    import com.omg.utils.math.MathUtils;

    import flash.geom.Point;

    public class MercatorProjection
    {
        public function MercatorProjection()
        {
        }

        public static function coordToPoint(lat:Number, lng:Number, mapWidth:Number,  mapHeight:Number):Point
        {
            // longitude: just scale
            var newX:Number = (mapWidth * (180 + lng) / 360) % mapWidth;

            // latitude: using the Mercator projection
            var radlat:Number = lat * Math.PI / 180;  // convert from degrees to radians
            var newY:Number = Math.log(Math.tan((radlat / 2) + (Math.PI / 4)));  // do the Mercator projection (w/ equator of 2pi units)
            newY = (mapHeight / 2) - (mapWidth * newY / (2 * Math.PI));   // fit it to my geo

            return new Point(newX, newY);
        }


        public static function pointToCoord(x:Number, y:Number, mapWidth:Number, mapHeight:Number):Point
        {
            var latReTransformed:Number = ((mapHeight * Math.PI) - ((2 * Math.PI) * y)) / mapWidth; // retransform from map
            var lat:Number = (2 * Math.atan(Math.exp(latReTransformed))) - (Math.PI / 2); // use inverse Gudermann function

            var lng:Number = (x / (mapWidth / 360)) - 180;
            return new Point(MathUtils.rad2deg(lat), lng);
        }

        public static function decToDMS(lat:Number, lng:Number):Point
    	{

			// change the decimal degrees to degrees minutes seconds
			var tempf:Number = new Number();
			var latd:Number = new Number();
			var lond:Number = new Number();
			// first do the latitude
			tempf = Math.abs(lat);
			latd = int(tempf);
			tempf = (tempf - latd) * 60.0;
			if(lat < 0) {		// put the sign back on the degrees
				latd = -latd;
			}
			
			// now do the longitude
			tempf = Math.abs(lng);
			lond = int(tempf);
			tempf = (tempf - lond) * 60.0;
			if(lng < 0){
				lond = -lond;
			}
			
			return new Point(latd,lond);
		}
    }
}
