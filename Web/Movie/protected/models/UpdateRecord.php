<?php

/**
 * This is the MongoDB Document model class based on table "UpdateRecord".
 */
class UpdateRecord extends EMongoDocument
{
	public $_id;
	public $updateEid;
 	public $updateItems;
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
		return 'updateRecord';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('_id,updateEid', 'numerical', 'integerOnly'=>true),
 			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('_id,updateEid, updateItems', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'_id' => 'ID',
			'updateEid'	=> 'UpdateEid',
  			'updateItems'	=> 'UpdateItems',
 		);
	}
}