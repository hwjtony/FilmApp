<style>
body,ul,li,p{
	padding:0;
	margin:0;
}
ul,li{
	list-style:none;
	list-style-type:none;
}
img{
	border:none;
	}
body{ 
    
	font-size:12px;
	}

#ieage_login{
	width:1000px;
	height:700px;
	margin:0 auto;
	margin-top:40px;
	
	}
	
.login-box{
	width:499px;
	height:270px;
	display:inline-block;
	}
.login-box .left{
	height:270px;
	float:left;
	width:245px;
	}
.login-box .left .form{
	margin-top:40px;
	position:relative;
	width:245px;
	}	
.login-box .left .form .input-item, #loginBox .form .login-item {
    display: inline;
    float: left;
    height: 42px;
    margin: 0 0 0 15px;
    position: relative;
}
.login-box .left .form .input-item {
    width: 200px;
}
.login-box .left .form .input-item label {
    color: #728290;
    display: block;
    font-size: 14px;
    left: 180px;
    position: absolute;
    top: 11px;
    width: 98%;
}
.login-box .left .form .text-input {
    border: medium none;
    height: 16px;
    line-height: 16px;
    margin: 2px 3px 0 2px;
    outline: medium none;
    padding: 10px 0 10px 14px;
    width: 200px;
}

.login-box .left .form .login-item {
	padding-top:10px;
	display:inline-block;
    width: 170px;
	padding-left:15px;
}
.login-box .left .form .login-item .btn1 {
    border: medium none;
    cursor: pointer;
    height: 41px;
    width: 78px;
	float:left;
}
.login-box .left .form .login-item .btn2 {
    border: medium none;
    cursor: pointer;
	margin-top:2px;
    height: 39px;
    width: 78px;
	float:right;
}
.login-box .right{
	height:270px;
	float:right;
	width:250px;
	}		
.right .logo{
	width:110px;
	height:110px;
	margin-left:70px;
	margin-top:20px;
	}	
.right .text{
	width:220px;
	height:110px;
	margin-left:15px;
	margin-top:20px;
	}
.right .text p{
	line-height:20px;
	}	
.right .text p a{
	color:#65a127;
	text-decoration:none;
}	
</style>
<script type="text/javascript">
function addComment(){
	var username = document.getElementById("username").value;
	var title = document.getElementById("title").value;
	var content = document.getElementById("tex").value;
	$.ajax({
		type: "POST",
		url: "index.php?r=site/getComment",
		data: "fid=<?=$_REQUEST['fid']?>&username="+username+"&title="+title+"&content="+content,
		dataType:"html",
		success:function(content){
			document.getElementById("main").innerHTML=content;
		},
	});
}
</script>
<html>
<div id="main">
   <div class="login-box">
       <div class="left">
       <form action="#" method="post" name="login">
       <div class="form">
       <div class="input-item">
       昵称<br>
       <input id="username"  type="text" maxlength="150" value="" name="username">
       </div>
       <div class="input-item">
       主题<br>
      <input id="title"  type="text" maxlength="150" value="" name="username">
       </div>
       <div class="input-item">
       内容<br>
      <input id="tex"  type="text" maxlength="150" value="" name="username">
       </div>
       <br><br><br><br><br><br><br><br><br><br><br><br><br>
       <div class="input-item">
       
       <span onclick="addComment();">提交</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
       </div>
       </div>
       </form>
       </div>
   </div>
</div>
</html>
<?php
