/**
 * Created by IntelliJ IDEA.
 * User: onemangroup
 * Date: 04.10.12
 * Time: 20:44
 * To change this template use File | Settings | File Templates.
 */
package com.omg.utils.math
{
    public class MathUtils
    {
        public function MathUtils()
        {
        }

        public static function sinh(x:Number):Number
        {
            return (( Math.E ^ x ) - ( Math.E ^ - x )) / 2;
        }

        public static function rad2deg(rad:Number):Number
        {
            return (rad * 180 / Math.PI);
        }

        public static function deg2rad(deg:Number):Number
        {
            return (deg * Math.PI / 180);
        }
    }
}
