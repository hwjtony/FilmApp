<?php

class SiteController extends Controller
{
	/**
	 * Declares class-based actions.
	 */
	public function actions()
	{
		return array(
			// captcha action renders the CAPTCHA image displayed on the contact page
			'captcha'=>array(
				'class'=>'CCaptchaAction',
				'backColor'=>0xFFFFFF,
			),
			// page action renders "static" pages stored under 'protected/views/site/pages'
			// They can be accessed via: index.php?r=site/page&view=FileName
			'page'=>array(
				'class'=>'CViewAction',
			),
		);
	}

	/**
	 * This is the default 'index' action that is invoked
	 * when an action is not explicitly requested by users.
	 */

	public function actionUpdate(){
    	$session = new CHttpSession;
	    $session->open();
	    $criteria = new EMongoCriteria;
	    $criteria->limit(1)->sort('updateEid' , EMongoCriteria::SORT_DESC);
	    $Res = UpdateRecord::model()->findAll($criteria);
	    $lastUpdateEid  = $Res[0]['updateEid'];
	    $dba = Yii::app()->db;
	    $cmd = $dba->createCommand("select p.name,e.id as eid,e.player_id,e.equip_id,e.level,e.status,e.star,e.type,e.ninja_id,e.color,e.del_flag,e.update_time,e.record_time from player_equip as e  left join player as p  on e.player_id = p.id where e.id>{$lastUpdateEid} and p.name<>'0'");
		$res = $cmd->queryAll();
   		$lasteid=0;
 		$eid_str='';
 		foreach($res as $key=>$value){
 			$cmd2 = $dba->createCommand("select type,val,add_type,val_type,source from magic where player_equip_id = {$value['eid']}");
			$res2 = $cmd2->queryAll();
			$model = new Equips();
 			$model->property = $res2;
			$model->color = (int)$value['color'];
			$model->del_flag = (int)$value['del_flag'];
			$model->eid = (int)$value['eid'];
			$model->equip_id = (int)$value['equip_id'];
			$model->level = (int)$value['level'];
			$model->name = $value['name'];
			$model->ninja_id = (int)$value['ninja_id'];
			$model->player_id = (int)$value['player_id'];
			$model->record_time = (int)$value['record_time'];
			$model->star = (int)$value['star'];
			$model->status = (int)$value['status'];
			$model->type = (int)$value['type'];
			$model->update_time = (int)$value['update_time'];
			$equip_list[] = $model;
 			$flag = $model->save();
 			$lasteid = (int)$value['eid'];
			$eid_str.=$lasteid."_";
  		}
 		if($lasteid){
	 		$model2 = new UpdateRecord();
	 		$model2->updateEid = $lasteid;
	 		$model2->updateItems = $eid_str;
	 		$model2->save();
	 		echo json_encode($equip_list);
 		}else{
 			echo json_encode(0);
 		}
 		exit();
    }

    
	public function actionSuggest(){
    	$session = new CHttpSession;
	    $session->open();
	    $search = isset($_REQUEST['search'])?$_REQUEST['search']:0;
	    $criteria = new EMongoCriteria;
	    $criteria->name('==',new MongoRegex("/^".$search.".*/"));
	    $criteria->limit(5);
	    $criteria->select(array('name'));
	  
  		$equips = Film::model()->findAll($criteria);
  		$result = array();
  		foreach($equips as $a){
  			$result[]= $a['name'];
  		}
		echo json_encode($result);   //echo json_encode(array("hihu","hihuu"));
		exit();
    }
    
    
    public function actionSearch(){
    	$session = new CHttpSession;
	    $session->open();
	    $name = isset($_REQUEST['name'])?$_REQUEST['name']:0;
	    $criteria = new EMongoCriteria;
	    $criteria->name('==',new MongoRegex("/^".$name.".*/"));
	  	$criteria->limit(3);
  		$films = Film::model()->findAll($criteria);
  		$this->render('searchDetail',array(
    			'films'		=> $films
 			));
    }
    
    
	public function actionIndex()
	{
		$session = new CHttpSession;
	    $session->open();
	    $search = isset($_REQUEST['search'])?$_REQUEST['search']:0;
	    $criteria = new EMongoCriteria;
	    $time_start = time()-51840000;
	 	$criteria->datetime('>',(string)$time_start);
	    $criteria->limit(48)->sort('score' , EMongoCriteria::SORT_DESC);
	    $criteria->select(array('fid','small_img','name'));
	  
  		$films = Film::model()->findAll($criteria);
  		$mlist = array();
  		foreach($films as $f){
  			$mlist[]= array($f['fid'],$f['small_img'],$f['name']);
  		}
  
		$this->render('index',array(
            'mlist' 		=> $mlist,
        ));	
	}
	
	public function actionFilmDetail(){
    	$fid = isset($_REQUEST['fid'])?$_REQUEST['fid']:0;
    	if ($fid) {
    		$conn = new Mongo("mongodb://192.168.1.11");
    		$db = $conn->test;
    		$collection = $db->comment;
    		$query = array("fid" => $fid);
			$cond = (object)array('comment' => array('$slice' => 5));
			$cursor = $collection->find($query, $cond);
    		/*foreach ($cursor as $temp){
    			$a = $temp['comment'];
    			foreach ($a as $t){
    				echo $t['content'];
    			}
    		}die;*/
    		$criteria = new EMongoCriteria;
	    	$criteria->fid('==',$fid);
    		$criteria->limit(1);
	    	$films = Film::model()->findAll($criteria);
	  		
    		$this->render('filmDetail',array(
    			'film'		=> $films[0],
    			'comments'	=> $cursor,
 			));
    	}
    }
    
    public function actionFilmDetailMore(){
    	$fid = isset($_REQUEST['fid'])?$_REQUEST['fid']:0;
    	$page = isset($_REQUEST['page'])?$_REQUEST['page']:0;
    	if($fid){
    		$conn = new Mongo("mongodb://192.168.1.11");
    		$db = $conn->test;
    		$collection = $db->comment;
    		$query = array("fid" => $fid);
			$cond = (object)array('comment' => array('$slice' => array(5*$page,5)));
			$cursor = $collection->find($query, $cond);
			$res = array();
			foreach ($cursor as $temp){
				$comments = $temp['comment'];
				foreach($comments as $key => &$comment){
					$short_str = Util::utf_cutstr($comment['content'],0,100);		
					$str = "<br><div class=\"citation\"><div class=\"citation-title\">";
					$str .= "<span class=\"user-name\">".$comment['name']."</span></div>";
					$str .= "<div id=\"p_block_".($key+5*$page)."\" >".$short_str;
					$str .= "</div>";
					if(strlen($short_str)!=strlen($comment['content'])){
						$str .= "<span id=\"more_".($key+5*$page)."\"  onclick=\"more(".($key+5*$page).");\">更多</span>";
					}
					$str .= "<div id=\"p_none_".($key+5*$page)."\" style=\"display:none;\">".$comment['content']."</div></div>";
					$comment['html'] = $str;
					$res[] = $comment;
				}
			}
			echo json_encode($res);
    	}
    }
    
    public function actionViewImages(){
    	$imgs_urls = isset($_REQUEST['urls'])?$_REQUEST['urls']:null;
    	$imgs_urls = explode(',',$imgs_urls);
    	//var_dump($imgs_urls);die;
    	if($imgs_urls){
    		$this->render('viewImages',array(
    			'imgs_urls'		=> $imgs_urls,  
 			));
    	}
    }
    
    public function actionIphoneSearch(){
    	$session = new CHttpSession;
	    $session->open();
	    $search = isset($_REQUEST['search'])?$_REQUEST['search']:0;$search = iconv('GB2312','UTF-8',  $search);
	    $criteria = new EMongoCriteria;
	    $criteria->name('==',new MongoRegex("/^".$search.".*/"));
	    $criteria->limit(20);
	    $criteria->select(array('name','fid','small_img','performer'));
        
  		$films = Film::model()->findAll($criteria);
  		$result = array();
  		foreach($films as $key=>$a){
  			$result[$key]['name'] = $a['name'];
  			$result[$key]['url'] = 'http://127.0.0.1/index.php?r=site/filmDetail&fid='.$a['fid'];
  			$result[$key]['imgUrl'] = 'http://127.0.0.1/images/imgs/'.$a['small_img'];
  			$result[$key]['performer'] = '主演：'.implode("/",$a['performer']);
  		}
  		//var_dump($result);die;
		echo json_encode($result);   //echo json_encode(array("hihu","hihuu"));
		exit();
    }
    
	public function actionTypeSearch(){
    	$session = new CHttpSession;
	    $session->open();
	    $type = isset($_REQUEST['type'])?$_REQUEST['type']:0;
	    $offset = isset($_REQUEST['offset'])?$_REQUEST['offset']:0;
	    $criteria = new EMongoCriteria;
	    if($type=="最新影片"){
	    	 $criteria->sort('datetime' , EMongoCriteria::SORT_DESC);
	    }else if($type=="评分最高"){
	    	 $criteria->sort('score' , EMongoCriteria::SORT_DESC);
	    }else if($type){
	    	$criteria->type('==',$type);
	    }else{echo json_encode("error");die();}
	    
	    if($offset > 0){//更多
	    	$criteria->limit(10);
	        $criteria->select(array('name','fid','small_img','performer'));
	        $criteria->offset($offset); 
	    }else{//第一次
	    	$criteria->limit(10);
	        $criteria->select(array('name','fid','small_img','performer'));
	    }
  		$films = Film::model()->findAll($criteria);
  		$result = array();
  		foreach($films as $key=>$a){
  			$result[$key]['name'] = $a['name'];
  			$result[$key]['url'] = 'http://192.168.2.184/Movie/index.php?r=site/filmDetail&fid='.$a['fid'];
  			$result[$key]['imgUrl'] = 'http://192.168.2.184/Movie/images/imgs/'.$a['small_img'];
  			$result[$key]['performer'] = '主演：'.implode("/",$a['performer']);
  		}
  		//var_dump($result);die;
		echo json_encode($result); 
		exit();
    }
    
	public function actionGetScore(){
    	$fid = isset($_REQUEST['fid'])?$_REQUEST['fid']:0;
    	$score = isset($_REQUEST['score'])?$_REQUEST['score']:0;
    	if($fid&&$score){
	    	$criteria = new EMongoCriteria;
		    $criteria->fid('==',$fid);
	  		$film = Film::model()->find($criteria);
	  		$s = $film['score'];
	  		$count = $film['score_count'];
	  		$film->score = ($s*$count+$score)/($count+1);
			$film->score_count = $count+1;
			// Use partial update
			$res  = $film->update(array('score', 'score_count'), true);
			echo $res;
    	}else{echo 0;}
    }
    
    public function actionAddCommentView(){
    	$this->render('addCommentView',array(
 		));
    }
    
	public function actionGetComment(){
		$fid = isset($_REQUEST['fid'])?$_REQUEST['fid']:0;
    	$name= isset($_REQUEST['username'])?$_REQUEST['username']:"";
		$username = $name!=""?$name:"游客";
    	$title = isset($_REQUEST['title'])?$_REQUEST['title']:0;
    	$content = isset($_REQUEST['content'])?$_REQUEST['content']:0;
		if($fid&&$title&&$content){
			$com  = array(
			'title' => $title,
			'time' => date("Y-m-d   h:i:s") ,
			'name' => $username,
			'content' => $content
			);
			$modifier = new EMongoModifier();
			$modifier->addModifier('count', 'inc', 1);
			$modifier->addModifier('comment', 'push', $com);
			
			$criteria = new EMongoCriteria();
			$criteria->addCond('fid','==', $fid);
			$status = Comment::model()->updateAll($modifier, $criteria); 
			if($status==1){
				echo "sucess";//"评论成功！";
			}else{echo "error";}//"评论提交失败";
		}else{echo "error";}//"评论提交失败";
    }

}