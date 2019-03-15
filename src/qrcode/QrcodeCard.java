package qrcode;

/**
 * 此类没有使用，生成二维码名片已经在qrcode.jsp中完成
 */
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;

import com.swetake.util.Qrcode;

/**
 * 二维码测试类
 * @author krry
 * @version 1.0
 *
 */
public class QrcodeCard {

	public static String qrcode(String message){
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
			//设置内容
			String content = message;
			
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
			
			//生成二维码图片
			String realPath = "D:\\apache-tomcat-8.0.33\\webapps\\krry_ecard\\upload\\";
			//pathName = UUID.randomUUID()+".png";  //也可以生成随机数
			pathName = new Date().getTime()+".png";
			outputStream = new FileOutputStream(new File(realPath, pathName));
			ImageIO.write(image, "png", outputStream);
			
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
		return pathName;
	}
	public static void main(String[] args) {
		QrcodeCard qrcode = new QrcodeCard();
		qrcode.qrcode("大家好！！");
	}
}
