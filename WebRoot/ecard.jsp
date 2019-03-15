<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="Keywords" content="关键词,关键词">
		<meta name="Description" content="网页描述">
		<title>Java开发微信二维码电子名片系统 --krry</title>
		<link rel="stylesheet" href="css/animate.css"/>
		<link rel="stylesheet" type="text/css" href="css/sg.css" />
		<style type="text/css">
			*{margin:0;padding:0}
			body{background:url("images/1.jpg");background-size:cover;font-size:12px;font-family:"微软雅黑";overflow:hidden;}

			/*top start*/
			.top{width:100%;height:70px;background:#333;text-align:center;}
			.top img{margin:5px 15px;float:left;}
			.top .title{font-size:24px;color:#fff;position:absolute;top:0;width:100%;line-height:70px;text-align:center;}
			/*end top*/

			/*table start*/
			.table{width:600px;float:left;margin:50px 80px;}
			.table p{font-size:24px;color:#fff;line-height:50px;}
			.table span{color:#fff;display:inline-block;background:#393939;width:45px;height:35px;text-align:center;line-height:36px;}
			.table input{color:#fff;font-size:14px;border:none;outline:none;font-family:"微软雅黑";}
			.table .inp{width:175px;height:35px;text-indent:1em;background:#303030;margin:20px 54px 0 0;}
			.table #sub{width:498px;height:35px;background:#6c0;margin-top:25px;transition:.5s;cursor:pointer;border-radius:7px;}
			.table #sub:hover{background:#fe7a7d;transition:.5s;}
			/*end start*/

			.imge{height:200px;width:200px;position:absolute;top:220px;right:220px;}
		</style>
	</head>
	<body>
		<!--top start-->
		<div class="top">
			<img src="images/logo.png" alt="我的logo" height="60" width="112"/>
			<div class="title">Java开发微信二维码电子名片系统 --krry</div>
		</div>
		<!--end top-->

		<!--table start-->
		<div class="table">
			<p>再小的个体，也有自己的品牌</p>
			<span>姓名：</span><input id="name" class="inp" type="text"/>
			<span>公司：</span><input id="com" class="inp" type="text"/>
			<span>部门：</span><input id="dept" class="inp" type="text"/>
			<span>职务：</span><input id="job" class="inp" type="text"/>
			<span>手机：</span><input id="phone" class="inp" type="text"/>
			<span>电话：</span><input id="call" class="inp" type="text"/>
			<span>地址：</span><input id="ess" class="inp" type="text"/>
			<span>传真：</span><input id="fax" class="inp" type="text"/>
			<span>邮箱：</span><input id="email" class="inp" type="text"/>
			<span>网址：</span><input id="http" class="inp" type="text"/>
			<input id="sub" type="button" value="开启通讯录"/>
		</div>
		<!--end table-->

		<div class="imge">
			<img src=""/>
		</div>
		
		<script src="js/jquery-1.11.3.min.js"></script>
		<script src="js/sg.js"></script>
		<script src="js/sgutil.js"></script>
		<script>
			$(function(){
				var close = true;
				$("#sub").click(function(){
					$(".imge").removeClass("animated bounceInRight");
					createCode();
				});
				
				function createCode(){
					var name,com,job,ess,phone,call,fax,email,http;
					if($("#name").val()){
						name = "FN:"+$("#name").val()+"\n";
					}else{
						close = false;
					}
					
					if($("#com").val()){
						if($("#dept").val()){
							com = "ORG:"+$("#com").val()+"("+$("#dept").val()+")"+"\n";
						}else{
							com = "ORG:"+$("#com").val()+"\n";
						}
					}else{
						com = "";
					}
					
					if($("#job").val()){
						job = "TITLE:"+$("#job").val()+"\n";
					}else{
						job = "";
					}
					
					if($("#ess").val()){
						ess = "ADR;WORK:"+$("#ess").val()+"\n";
					}else{
						ess = "";
					}
					
					if($("#phone").val()){
						phone = "TEL;CELL:"+$("#phone").val()+"\n";
					}else{
						close = false;
					}
					
					if($("#call").val()){
						call = "TEL;WORK:"+$("#call").val()+"\n";
					}else{
						call = "";
					}
					
					if($("#fax").val()){
						fax = "TEL;WORK;FAX:"+$("#fax").val()+"\n";
					}else{
						fax = "";
					}
					
					if($("#email").val()){
						email = "EMAIL;WORK:"+$("#email").val()+"\n";
					}else{
						email = "";
					}
					
					if($("#http").val()){
						http = "URL:"+$("#http").val()+"\n";
					}else{
						http = "";
					}
					
					if(close){
						var str = "BEGIN:VCARD\n"+name+com+job+ess+phone+call+fax+email+http+"END:VCARD";
						
						$.ajax({
							type:"post",
							url:"qrcode.jsp",
							data:{content:str},  //将str信息传入content，后台可获取
							success:function(data){
								$(".imge").addClass("animated bounceInRight");
								$(".imge").find("img").attr("src",data);
							}
						});
					}else{
						$.tmDialog.alert({open:"top",content:"姓名和手机号码必填！！",title:"出错啦"});
						close = true;
					}
				}
			});
		</script>
	</body>
</html>







