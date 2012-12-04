<!DOCTYPE html>
<html lang="zh-CN" class="ua-windows ua-webkit"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    

    <title>电影资讯</title>
    <meta http-equiv="Pragma" content="no-cache">
    <link href="./themes/js_files/packed_douban6899809293.css" rel="stylesheet" type="text/css">
    <style type="text/css">
      .nav-srh .inp{position:relative;z-index:40}#search_suggest{background:#fff;border:1px solid #eee;position:absolute;z-index:99;top:32px;width:303px;box-shadow:0 1px 2px rgba(0,0,0,.3);border-bottom:0 none}#search_suggest li{border-bottom:1px solid #eee;overflow:hidden}#search_suggest li.curr_item{background:#efefef}#search_suggest li a{color:#999;display:block;overflow:hidden;padding:6px;zoom:1}#search_suggest li a:hover{background:#f9f9f9;color:#999}#search_suggest li a em{font-style:normal;color:#369}#search_suggest li p{margin:0;zoom:1;overflow:hidden}#search_suggest li img{float:left;margin-right:8px;margin-top:3px}#search_suggest li.over{background:#fbfbfb}
  
        #top h2 span{font-size:12px;margin-left:12px;}
        #top .top-bd{letter-spacing:-0.31em;*letter-spacing:normal;word-spacing-0.43em;}
        #top dl{display:inline-block;*display:inline;zoom:1;letter-spacing:normal;word-spacing:normal;text-align:center;width:75px;overflow:hidden;vertical-align:top;margin:0 2px 10px 0;}
        #top dt{margin-bottom:8px;height:100px;overflow:hidden;}
    </style>
    


<script type="text/javascript">
jQuery(document).ready(
function($){
$("img").lazyload({
     placeholder : "./themes/js_files/loading.jpg", //加载图片前的占位图片
     effect      : "fadeIn" //加载图片使用的效果(淡入)
});
});
</script>
</head>

<body>  
<div id="content">
<div class="grid-16-8 clearfix">             
 <div class="aside">
    
  <div class="indent"><br>
    <div id="top">
  
        <div class="top-bd">
         <?php foreach($mlist as $m){?>
         <dl>
            <dt><a href="index.php?r=site/filmDetail&fid=<?=$m[0]?>"><img src="./images/imgs/<?=$m[1]?>" class="m_sub_img"></a></dt>
            <dd><a href="index.php?r=site/filmDetail&fid=<?=$m[0]?>"><?=$m[2]?></a><span class="gact"></span><br></dd>
        </dl>
         <?php }?>   
        </div>
    </div>
    
  </div>
 </div>
</div>
</div>        
</body></html>

	