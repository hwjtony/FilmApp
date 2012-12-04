<?php

/**
 * This is the MongoDB Document model class based on table "UpdateRecord".
 */
class Admin extends EMongoDocument
{
	public $_id;
	public $name;
 	public $pwd;
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
		return 'admin';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('_id', 'numerical', 'integerOnly'=>true),
 			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('_id,name, pwd', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'_id' => 'ID',
			'name'	=> 'Name',
  			'pwd'	=> 'Pwd',
 		);
	}
}