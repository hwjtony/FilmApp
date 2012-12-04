<?php

/**
 * This is the MongoDB Document model class based on table "equips".
 */
class Equips extends EMongoDocument
{
	public $_id;
	public $eid;
	public $player_id;
	public $name;
	public $level;
	public $equip_id;
	public $status;
	public $ninja_id;
	public $property;
	public $type;
	public $star;
	public $del_flag;
	public $color;
	public $update_time;
	public $record_time;

	/**
	 * Returns the static model of the specified AR class.
	 * @return Equips the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * returns the primary key field for this model
	 */
	public function primaryKey()
	{
		return '_id';
	}

	/**
	 * @return string the associated collection name
	 */
	public function getCollectionName()
	{
		return 'equip';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('_id, eid,player_id, level, equip_id, status, ninja_id, type, star, del_flag, color, update_time, record_time', 'numerical', 'integerOnly'=>true),
			array('name', 'length', 'max'=>100),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('_id, eid,player_id, name, level, equip_id, status, ninja_id, property, type, star, del_flag, color, update_time, record_time', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'_id' => 'ID',
			'eid' => 'Eid',
			'player_id' => 'Player',
			'name' => 'Name',
			'level' => 'Level',
			'equip_id' => 'Equip',
			'status' => 'Status',
			'ninja_id' => 'Ninja',
			'property' => 'Property',
			'type' => 'Type',
			'star' => 'Star',
			'del_flag' => 'Del Flag',
			'color' => 'Color',
			'update_time' => 'Update Time',
			'record_time' => 'Record Time',
		);
	}
}