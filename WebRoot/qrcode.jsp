<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.Color"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="com.swetake.util.Qrcode"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//设置编码方式
	request.setCharacterEncoding("utf-8");
	//设置内容
	String content = request.getParameter("content");

	String pathName = null;
	FileOutputStream outputStream = null;
	try{
		//创建二维码对象
		Qrcode qrcode = new Qrcode();
		//设置二维码纠错级别  L(7%) M(15%) Q(25%) H(30%)
		qrcode.setQrcodeErrorCorrect('L'); //一般设置小一点
		//设置二维码的编码模式 （Binary :按照字节编码方式）
		qrcode.setQrcodeEncodeMode('B');
		//设置二维码的版本号 1-40  二维码的尺寸   1:20*21    2:25*25   40:177*177
		qrcode.setQrcodeVersion(10);
		
		//获取图片缓冲流对象
		int width = 175;
		int height = 175;
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		//获取画笔
		Graphics2D gs = image.createGraphics();
		//设置背景颜色为白色
		gs.setBackground(Color.WHITE);
		//设置画笔的颜色为红色
		gs.setColor(Color.RED);
		//绘制矩形
		gs.clearRect(0, 0, width, height);
		
		byte[] contentsBytes = content.getBytes("utf-8");
		
		//绘制方法
		//设置偏移量，不设置可能会导致解析错误
		int pixoff = 2;
		//利用二维数组的布尔值绘制二维码，true就绘制，false就不绘制
		boolean[][] code = qrcode.calQrcode(contentsBytes);
		for (int i = 0; i < code.length; i++) {
			for (int j = 0; j < code.length; j++) {
				if(code[j][i]){
					gs.fillRect(j*3+pixoff, i*3+pixoff, 3, 3);
				}
			}
		}
		
		//释放画笔
		gs.dispose();
		//刷新缓冲区
		image.flush();
		
		//生成二维码图片
		String realPath = request.getServletContext().getRealPath("/upload");
		//pathName = UUID.randomUUID()+".png";  //也可以生成随机数
		pathName = new Date().getTime()+".png";
		outputStream = new FileOutputStream(new File(realPath, pathName));
		ImageIO.write(image, "png", outputStream);
		
		//输出到页面中，前台用ajax获取，异步刷新页面
		out.print("upload/"+pathName);
		
		System.out.println("二维码图片生成成功!");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		//关闭流
		try {
			outputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
%>
