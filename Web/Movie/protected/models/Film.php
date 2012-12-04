<?php

/**
 * This is the MongoDB Document model class based on table "equips".
 */
class Film extends EMongoDocument
{
	public $_id;
	public $fid;
	public $small_img;
	public $name;
	public $score;
	public $score_count;
	public $big_img;
	public $stage_img;
	public $big_stage_img;
	public $director;
	public $performer;
	public $type;
	public $datetime;
	public $area;
	public $long;
	public $language;
	public $company;
	public $other_name;
	public $introduce;
	public $links;

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
		return 'film';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('_id,fid,score,score_count,datetime','integerOnly'=>true),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('_id,fid,small_img, name, score,score_count, big_img, stage_img, big_stage_img, director, performer, type, datetime, area, long, language,company,other_name,introduce,links', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'_id' => 'ID',
			'fid' => 'Eid',
			'small_img' => 'Small img',
			'name' => 'Name',
			'score' => 'Score',
			'score_count' => 'Score_count',
			'big_img' => 'Big img',
			'stage_img' => 'Stage img',
			'big_stage_img' => 'Big stage img',
			'director' => 'Director',
			'performer' => 'Performer',
			'type' => 'Type',
			'datetime' => 'Datetime',
			'area' => 'Area',
			'long' => 'Long',
			'language' => 'Language',
			'company' => 'Company',
			'other_name' => 'Other name',
			'introduce' => 'Introduce',
			'links' => 'Links',
		);
	}
}