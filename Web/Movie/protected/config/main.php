<?php
require_once(dirname(__FILE__).'/mars/const.cfg.php');
// uncomment the following to define a path alias
// Yii::setPathOfAlias('local','path/to/local-folder');
// This is the main Web application configuration. Any writable
// CWebApplication properties can be configured here.
return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
	'name'=>'EquipSearch',
    'language'=>'ja',
	// preloading 'log' component
	'preload'=>array('log'),
 	// autoloading model and component classes
	'import'=>array(
		'application.models.*',
		'application.components.*',
		'application.extensions.*',
		'ext.YiiMongoDbSuite.*',
	),
 	'modules'=>array(
		// uncomment the following to enable the Gii tool
 		'gii'=>array(
			'class'=>'system.gii.GiiModule',
			'password'=>'123456',
		 	// If removed, Gii defaults to localhost only. Edit carefully to taste.
			'ipFilters'=>array('127.0.0.1','::1'),
			'generatorPaths'=>array(
              	'ext.YiiMongoDbSuite.gii',   // a path alias
            ),
		),
		/**/
	),

	// application components
	'components'=>array(
		'user'=>array(
			// enable cookie-based authentication
			'allowAutoLogin'=>true,
		),
		// uncomment the following to enable URLs in path-format
		/*
		'urlManager'=>array(
			'urlFormat'=>'path',
			'rules'=>array(
				'<controller:\w+>/<id:\d+>'=>'<controller>/view',
				'<controller:\w+>/<action:\w+>/<id:\d+>'=>'<controller>/<action>',
				'<controller:\w+>/<action:\w+>'=>'<controller>/<action>',
			),
		),
		*/
		'messages'=>array(
            'class'=>'CPhpMessageSource',
      	),
 		'mongodb' => array(
	        'class'             => 'EMongoDB',
	       // 'connectionString'  => 'mongodb://127.0.0.1',
	       	'connectionString'  => 'mongodb://192.168.1.11',
	        'dbName'            => 'test',
	        'fsyncFlag'         => false,
	        'safeFlag'          => false,
	        'useCursor'         => false,
		),
		
		'db'=>array(
			'connectionString' => 'mysql:host=192.168.1.20 ;dbname=ninja',
			'emulatePrepare' => true,
			'username' => 'ninja-m',
			'password' => 'ninjaFtFt05ab',
			'charset' => 'utf8',
		),
		// uncomment the following to use a MySQL database
 		'errorHandler'=>array(
			// use 'site/error' action to display errors
            'errorAction'=>'site/error',
        ),
		'log'=>array(
			'class'=>'CLogRouter',
			'routes'=>array(
				array(
					'class'=>'CFileLogRoute',
					'levels'=>'error, warning',
				),
				// uncomment the following to show log messages on web pages
				/*
				array(
					'class'=>'CWebLogRoute',
				),
				*/
			),
		),
	),

	// application-level parameters that can be accessed
	// using Yii::app()->params['paramName']
	'params'=>array(
		// this is used in contact page
		'adminEmail'=>'webmaster@example.com',
	),
);
