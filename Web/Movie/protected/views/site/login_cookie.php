<script>
function login(){
			var username = $("#username").val();
			var password = $("#password").val();
			var data = 'r=site/login&username='+username+'&password='+password;
			$.ajax({ 
				type: "GET", 
				url: 'index.php', 
				dataType: 'json', 
				data: data, 
				success: function(content){
					if(content){
						window.location.href="index.php?r=site/index"; 
					}else{alert("用户名或密码错误！");}
		 		}
			});
	
}

</script>

   username:<input type="text" id="username" value="<?=$_COOKIE[name]?>"/><br/>
   password:<input type="password" id="password"/><br/>
   <button  style="width:80px;height:24px;background:#81B8D6" onclick="login()">登录</button>

