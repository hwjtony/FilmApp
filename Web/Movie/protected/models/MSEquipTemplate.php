<?php
class MSEquipTemplate{
	private $equip_id;
	private $color;
	private $config;
	private $level;  
	private $etype;  
	private $sub_etype; 
	
	private $e_info;
	private $i_index;//装备类型+等级   5位
	private $campaign_id; //活动ID  3位
	 
	public function __construct($equip_id,$color=WHITE){
		$equip_cfg 	= Util::loadconfig('NEquip');	
		$mod_id 	= substr($equip_id,0,5)."001";
		if(array_key_exists($mod_id, $equip_cfg)){
			$this->equip_id 		= $equip_id;
			$this->color 			= $color;
			$this->config 			= $equip_cfg[$mod_id];
			$this->level 			= $equip_cfg[$mod_id]['level'];
			$this->etype 			= $equip_cfg[$mod_id]['etype'];
			$this->sub_etype 		= $equip_cfg[$mod_id]['sub_etype'];
			
			$e_Info 		= Util::loadconfig('NEquip_info');
			$type 			= $this->etype.$this->sub_etype;
			$interval 		= floor(($this->level -1)/10)*10+1;
			$this->i_index 	= $type.sprintf("%03d", $interval);
			$this->campaign_id 		= intval(substr($equip_id,-3,3));			
			if(array_key_exists($this->i_index, $e_Info)){
				if(array_key_exists($this->campaign_id, $e_Info[$this->i_index])){
					$this->e_info = $e_Info[$this->i_index][$this->campaign_id];
				}
			}
			return true;
		}else{
			$this->equip_id 	= null;
			return false;
		}
	}
	
	//是否有效
	public function valid(){
		if($this->equip_id){
			return true;
		}
		return false;
	}
 	/*
	 * 得到属性
	 */
	public function getAttr($key){
		return $this->$key;
	}
	
	//获取图片地址
	public function getImgSrc(){
		if($this->valid()){
 			$e_Info = $this->e_info;
			$cstr 		= 'white_';
			switch ($this->color) {
				case WHITE:	$cstr = 'white_';break;
				case BLUE:	$cstr = 'blue_';break;
				case YELLOW:$cstr = 'yellow_';break;
				case PURPLE:$cstr = 'purple_';break;
			}
			$level = $this->level;
			$e_level =  floor(($level-1) / 10)*10 +1;
			return	"http://192.168.1.136/images/ninja_equip/".$e_level.'/'.$cstr.$e_Info['img'];
		}
		return "";
	}
	
	/*
	 * 得到基本属性的名字 及值
	 */
	public function getBasicAttrName($type,$val){
		switch ($type) {
			case ATTACK:
				$str = "攻击: ".$val;
			break;
			case DEFENCE:
				$str = "防御: ".$val;
			break;
			case LEADSHIP:
				$str = "统御: ".$val;
			break;
			case CONCEAL:
				$str = "生命: ".$val;
			break;
			case BJ:
				$str = "暴击: ".$val."%";
			break;
			case GD:
				$str = "格挡: ".$val."%";
			break;
			case REACTION:
				$str = "反应: ".$val;
			break;
			default:
				$str = "";
		}
		return $str;
	}
	
	/*
	 * 得到装备等级
	 */
	public function getLevel(){
		if ($this->valid()){
			return $this->config['level'];
		}
		return 999;
	}
	
 
	/*
	 * 得到装备小类
	 */
	public function getSubType(){
		if($this->valid()){
			return $this->config['sub_etype'];
		}
		return 0;
	}
	
	/*
	 * 得到装备属性
	 */
	public function getEffect(){
		if($this->valid()){
			return $this->config['effect'];
		}
		return 0;
	}
	
	//装备名字
	public function getEquipName(){
		if($this->valid()){
			$e_Info = $this->e_info;
			return $e_Info['name'];
		}
		return "";
	}
	
	//装备描述
	public function getEquipDesc(){
		if($this->valid()){
			$e_Info = $this->e_info;
			return $e_Info['desc'];
		}
		return "";
	}
	
}