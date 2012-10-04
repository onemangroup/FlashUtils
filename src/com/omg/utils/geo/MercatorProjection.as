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
    }
}
