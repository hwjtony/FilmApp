<?php
class Util {
	public static function loadconfig($k){
		static $cfg;
		if(!$cfg){
			$cfg = array();
		}
		if(!isset($cfg[$k])){
			if(file_exists(dirname(__FILE__).'/../config/mars/'.$k.'.cfg.php')){
 			   	$cfg[$k] = require(dirname(__FILE__).'/../config/mars/'.$k.'.cfg.php');
 			}
		}
		if(isset($cfg[$k])){
			return $cfg[$k];
		}else{
			return null;
		}
	}
	
	static function utf_cutstr($str,$start,$len){
         $length = strlen($str);
         $new_str = array();
         for($i=0;$i<$length;++$i){
             $temp_str=substr($str,$i,1);
             if(ord($temp_str) >= 224){
                 array_push($new_str,substr($str,$i,3));
                 $i += 2;
             }elseif(ord($temp_str) >= 192){
                 array_push($new_str,substr($str,$i,2));
                 $i += 1;
             }else{
                 array_push($new_str,$temp_str);
             }
         }
         $rtn_str = join(array_slice($new_str,$start,$len));
         $filter_array = array('<','>','/','b','r','p');
         while(in_array(substr($rtn_str,-1,1),$filter_array)&&count($new_str)>$len){
         	$len++;
         	$rtn_str = join(array_slice($new_str,$start,$len));
         }
         if(count($new_str) > $len){
             $rtn_str .= "...";
         }
         return $rtn_str;
     }
}
?>