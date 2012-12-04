<!DOCTYPE html>
<!-- Camera is a Pixedelic free jQuery slideshow | Manuel Masia (designer and developer) --> 
<html> 
<head> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" > 
    <title>Camera | a free jQuery slideshow by Pixedelic</title> 
    <meta name="description" content="Camera a free jQuery slideshow with many effects, transitions, adaptive layout, easy to customize, using canvas and mobile ready"> 
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--///////////////////////////////////////////////////////////////////////////////////////////////////
    //
    //		Styles
    //
    ///////////////////////////////////////////////////////////////////////////////////////////////////--> 
    <link rel='stylesheet' id='camera-css'  href='./themes/js_files/camera.css' type='text/css' media='all'> 
    <style>
		body {
			margin: 0;
			padding: 0;
			height: 100%;
			background-color:#000000;
		}
		a {
			color: #09f;
		}
		a:hover {
			text-decoration: none;
		}
		#back_to_camera {
			clear: both;
			display: block;
			height: 80px;
			line-height: 40px;
			padding: 20px;
		}
		.fluid_container {
			margin: 0 auto;
			max-width: 1000px;
			width: 90%;
			height: 100%;
		}
	</style>

    <!--///////////////////////////////////////////////////////////////////////////////////////////////////
    //
    //		Scripts
    //
    ///////////////////////////////////////////////////////////////////////////////////////////////////--> 
    
    <script type='text/javascript' src='./themes/js_files/scripts/jquery.min.js'></script>
<script type='text/javascript' src='./themes/js_files/scripts/jquery.mobile.customized.min.js'></script>
<script type='text/javascript' src='./themes/js_files/scripts/jquery.easing.1.3.js'></script> 
<script type='text/javascript' src='./themes/js_files/scripts/camera.min.js'></script> 
    
    <script>
		jQuery(function(){
			jQuery('#camera_wrap_2').camera({
				//height: '500',
				minHeight: '400px',
				//loader: 'pie',
				fx: 'scrollHorz',
				//gridDifference: 1,
				pagination: false,
				portrait: true,
				thumbnails: false,
				playPause: false,
				transPeriod: 800,
				navigation: false,
				mobileAutoAdvance: true,
				autoAdvance: true
			});
			jQuery('#camera_wrap_2').cameraPause();
		});
	</script>
</head>
<body>

        <div class="camera_wrap camera_magenta_skin" id="camera_wrap_2">
            <?php foreach($imgs_urls as $url){?>
            <div data-thumb="../images/slides/thumbs/bridge.jpg" data-src="./images/imgs/<?=$url?>">
                
            </div>
            <?php } ?>
        </div><!-- #camera_wrap_2 -->
    </div><!-- .fluid_container -->
    
</body> 
</html>



