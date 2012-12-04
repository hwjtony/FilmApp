<!DOCTYPE html>
<html lang="zh-CN" class="ua-windows ua-webkit">
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 	
    <style type="text/css">
      .nav-srh .inp{position:relative;z-index:40}#search_suggest{background:#fff;border:1px solid #ddd;position:absolute;z-index:99;top:32px;width:302px;border-top:0 none}#search_suggest li{border-bottom:1px solid #eee;overflow:hidden}#search_suggest li:last-child{border-bottom:0 none}#search_suggest li.curr_item{background:#efefef}#search_suggest li a{color:#999;display:block;overflow:hidden;padding:6px;zoom:1}#search_suggest li a:hover{background:#f9f9f9;color:#999}#search_suggest li a em{font-style:normal;color:#369}#search_suggest li p{margin:0;zoom:1;overflow:hidden}#search_suggest li img{float:left;margin-right:8px;margin-top:3px}#search_suggest li.over{background:#fbfbfb}
    </style>
</head>

<div class="grid-16-8 clearfix">
  <div class="article">    
<?php 
if($films){
foreach ($films as $film){
?>
        <p class="ul first"></p>
		<table width="100%">
		<tbody>
		<tr class="item">
		<td width="100" valign="top">
        <a class="nbg" href="index.php?r=site/filmDetail&fid=<?=$film['fid']?>"><img src="./images/imgs/<?=$film['small_img']?>"></a>
        </td>
		<td valign="top">
		<div class="pl2"><a href="index.php?r=site/filmDetail&fid=<?=$film['fid']?>"><?=$film['name']?></a></div>
		
		<p class="pl"><?=date('Y-m-d', $film['datetime'])?>(<?=implode("/",$film['area'])?>)/<?=implode("/",$film['language'])?>/导演:<?=$film['director']?>/<?=implode("/",$film['performer']);?>/<?=implode("/",$film['type']);?> /<?=$film['long']?>...</p>
		<div class="star clearfix"><span class="rating_nums"><?=$film['score']?></span></div></td>
		</tr>
		</tbody>
		</table>
<?php }}else{?>	
<span>对不起，没有找到影片的详细信息</span>
<?php }?>	
   </div>  
</div> 