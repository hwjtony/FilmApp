<!DOCTYPE html>
<html lang="zh-CN" class="ua-windows ua-webkit"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./themes/jquery/jRating.jquery.css" media="screen" />
<!-- jQuery files -->
<script type="text/javascript" src="./themes/jquery/jquery.js"></script>
<script type="text/javascript" src="./themes/jquery/jRating.jquery.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$('.basic').jRating();
		$('.exemple5').jRating({
			length:10,
			rateMax : 10,
			decimalLength:1,
			onSuccess : function(d){
					//alert('Success : your rate has been saved :)');
			},
			onError : function(){
				alert('Error : please retry');
			}
		});
		
	 
	});

	function getRate(rate){
		$.ajax({
			type: "POST",
			url: "index.php?r=site/getScore",
			data: "fid="+<?=$film['fid']?>+'&score=' + rate,
			dataType:"html",
			success:function(content){
				
			},
		});
	}
	
	var lock = 0;
	$(function(){
		var winH = $(window).height(); //页面可视区域高度
		var i = 1;
		$(window).scroll(function () {
		    var pageH = $(document.body).height();
			var scrollT = $(window).scrollTop(); //滚动条top
			var aa = (pageH-winH-scrollT)/winH;
			if(aa<0.02){
				if(lock == 1){
					return false;
				}
				lock = 1;//防止多次加载
				$.getJSON("index.php?r=site/filmDetailMore&fid="+<?=$film['fid']?>,{page:i},function(json){
					if(json){
						var str = "";
						$.each(json,function(index,array){
							var str = array['html'];
							$("#container").append(str);
						});
						i++;
						lock = 0;
					}else{
						$(".nodata").show().html("别滚动了，已经到底了。。。");
						return false;
					}
				});
			}
		});
	});

	function more(key){
		$("#p_block_"+key).css('display','none');
		$("#more_"+key).css('display','none');
		$("#p_none_"+key).css('display','block');
	}
	
	function viewImages(id){
		var flag = window.MID.getid(id);
	}

	function pinglun(fid){
		var url="pinglun:"+fid;  
	    document.location = url; 
	}
	</script>
    <style type="text/css">
    .citation {
	    background: none repeat scroll 0% 0% rgb(255, 254, 245);
	    border: 1px solid rgb(209, 213, 219);
	    padding: 3px 3px 10px;
	    width: 280px;
	}
	.citation-title {
	    overflow: hidden;
	    line-height: 32px;
	    padding-left: 11px;
	    padding-right: 11px;
	}
    </style>

    <title>详细介绍</title>
    <meta http-equiv="Pragma" content="no-cache">
    <link href="./themes/js_files/packed_douban6899809293.css" rel="stylesheet" type="text/css">
<body>
    <div id="wrapper"  style="margin-left: 15px;" >

        <h1 style="width:300px">
<br>
    <span class="year" style="display:inline-block;*display:inline;zoom:1;"><?=$film['name']?></span></h1>
    
                <div class="article">
     
    <div class="indent"><div class="subjectwrap clearfix">

<div class="subject clearfix"  style="width:315px">
    

	
       <a class="nbg"  title="点击看更多海报">
           <img src="./images/imgs/<?=$film['big_img']?>">
       </a>
       

  
   
    <div id="info">
            <span><span class="pl">导演</span>: <?=$film['director']?></span><br>
            <span><span class="pl">主演</span>: 
            <?php
            //var_dump($film);die;
            echo implode("/",$film['performer']);
            ?><br>
            <span class="pl">类型:</span> 
            <span property="v:genre">
			<?php
            echo implode("/",$film['type']);
            ?>
            </span><br>
            
            <span class="pl">制片国家/地区:</span> 
			<?php
            echo implode("/",$film['area']);
            ?>
			<br>
            <span class="pl">语言:</span>
            <?php
            echo implode("/",$film['language']);
            ?>
            <br>
            <span class="pl">上映日期:</span> <span>
			<?=date('Y-m-d', $film['datetime']); ?>
			</span><br>
            <span class="pl">片长:</span> <span>
			<?=$film['long']?>
			</span><br>
			<span class="pl">又名:</span>
			<?php
            echo implode("/",$film['other_name']);
            ?>
			<br>
			<span class="pl">评分:</span> <span>
			<?=round($film['score'],1)?>
			</span><br>
    </div>
    
    <div id="interest_sect_level" class="clearfix" ><div class="ll j a_stars">评价:
    
<div class="exemple">
 	<div class="exemple5" id="10_5"></div>
</div>
      
</div>
</ul></div>





    
    <div class="related_info" style="width:290px"><h2><?=$film['name']?>的剧情简介 
        </h2><div class="indent" id="link-report"><span class="short">　　<span property="v:summary" style=" width: 300px; height: 300px;"><?=$film['introduce']?></span></div>



    <h2>
        <?=$film['name']?>的电影图片
    </h2>


    <ul class="pic-col5 clearfix">
    <?php 
    foreach ($film['stage_img'] as $image){
    	
    ?>
                <li style="width:80px">
                <a href="index.php?r=site/viewImages&urls=<?=implode(",",$film['big_stage_img'])?>" onclick = "viewImages(<?=$film['fid']?>)"><img  src="./images/imgs/<?=$image?>"></a>
            </li>
            <?php }?>
    </ul>

 


<a name="reviews"></a><div class="clear"></div>
            <h2 class="clearfix">
                <?=$film['name']?>的影评 <span class="pl">(<a href="http://movie.douban.com/subject/1292281/reviews">共<span property="v:count">
                <?php foreach ($comments as $temp){
                	echo $temp['count'];
                }?>
                </span>条</a>)</span>
             <a class=" rr " style="color: rgb(255, 118, 118);" onclick="pinglun(<?=$film['fid']?>);"><span>我来评论这部电影</span></a>
             
            </h2>
</div>


<div id="container">
<?php 
foreach ($comments as  $temp){
    $a = $temp['comment'];
    foreach ($a as $key =>$t){
    ?>

<div class="citation">
<div class="citation-title">
<span class="user-name"><?=$t['name']?></span>
</div>
<div id="p_block_<?=$key?>" >
	<?php 
		$short_str = Util::utf_cutstr($t['content'],0,100);
		echo $short_str;
	?>
</div>
	<?php 
		if(strlen($short_str)!=strlen($t['content'])){
	?>
<span id="more_<?=$key?>" style="" onclick="more(<?=$key?>);">更多</span>
	<?php 
		}
	?>
<div id="p_none_<?=$key?>" style="display:none;">
	<?=$t['content']?>
</div>
</div>
<br>
	<?php 
	    	}
		}
	?> 		
      </div></div></div></div></body></html>