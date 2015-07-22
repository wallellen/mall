package com.freelywx.common.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Hashtable;
import java.util.Map;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.NotFoundException;
import com.google.zxing.Result;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;

public class QRCode {
	private static final int BLACK = 0xff000000;
	private static final int WHITE = 0xFFFFFFFF;

	public static void main(String[] args) throws NotFoundException, IOException, WriterException {

		QRCode test = new QRCode();
		File file = new File("C://fakepath//temp//test.png");
		test.encode("ghl test", file, BarcodeFormat.QR_CODE, 200, 200, null);
		test.decode(file);

	}

	/**
	 * 生成QRCode二维码
	 * 
	 * @param contents
	 * @param file
	 * @param format
	 * @param width
	 * @param height
	 * @param hints
	 * @throws WriterException
	 * @throws IOException
	 */
	public void encode(String contents, File file, BarcodeFormat format, int width, int height,
			Map<EncodeHintType, ?> hints) throws WriterException, IOException {
		BitMatrix bitMatrix = new MultiFormatWriter().encode(contents, format, width, height);

		BufferedImage image = toBufferedImage(bitMatrix);
		ImageIO.write(image, "png", file);
	}

	/**
	 * 生成二维码内容
	 * 
	 * @param matrix
	 * @return
	 */
	public static BufferedImage toBufferedImage(BitMatrix matrix) {
		int width = matrix.getWidth();
		int height = matrix.getHeight();
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				image.setRGB(x, y, matrix.get(x, y) == true ? BLACK : WHITE);
			}
		}
		return image;
	}

	/**
	 * 解析QRCode二维码
	 * 
	 * @param file
	 * @throws IOException
	 * @throws NotFoundException
	 */
	@SuppressWarnings("unchecked")
	public void decode(File file) throws IOException, NotFoundException {
		BufferedImage image = ImageIO.read(file);
		if (image == null) {
			System.out.println("Could not decode image");
		}
		LuminanceSource source = new BufferedImageLuminanceSource(image);
		BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
		@SuppressWarnings("rawtypes")
		Hashtable hints = new Hashtable();
		hints.put(DecodeHintType.CHARACTER_SET, "utf-8");
		Result result = new MultiFormatReader().decode(bitmap, hints);
		String resultStr = result.getText();
		System.out.println("解析后内容：" + resultStr);
	}
}