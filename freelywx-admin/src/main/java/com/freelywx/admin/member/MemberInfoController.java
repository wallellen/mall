package com.freelywx.admin.member;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.config.Config;
import com.freelywx.common.model.member.Member;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.freelywx.common.util.QRCode;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.rps.util.D;

/**
 * 会员信息
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/member")
public class MemberInfoController {

	@RequestMapping("/init")
	public String index()  {
		return "member/member/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(Member.class, "sql.member/getPageMember", request);
		List<Member> memberList = (List<Member>) page.getData();
		String httpPath = Config.SERVER_BASE;
		for (Member member : memberList) {
			// 用户图像
			String member_img = member.getImg();
			if (!checkUrlOk(member_img)) {
				// 如果图片不存在的情况，就用本地图片
				member_img = request.getContextPath() + "/res/images/member/default.png";
			}
			member.setImg(member_img);
		}
		return page;
	}

	@RequestMapping("/createQR/{qr}")
	public void qa(@PathVariable String qr, HttpServletRequest request, HttpServletResponse response)
			throws WriterException, IOException {

		BitMatrix bitMatrix = new MultiFormatWriter().encode(qr, BarcodeFormat.QR_CODE, 400, 400);
		BufferedImage bufferedImage = QRCode.toBufferedImage(bitMatrix);
		response.setContentType("image/jpeg");
		ImageIO.write(bufferedImage, "png", response.getOutputStream());
	}

	private boolean checkUrlOk(String urlStr) {
		// urlStr =
		// "http://whtriples.com/wApp/infoColumnItem/c6612994-0c63-4504-b821-0dd0f47a64ca.png1";

		boolean urlOk = false;

		int responseCode = 0;
		try {
			responseCode = ((HttpURLConnection) new URL(urlStr).openConnection()).getResponseCode();
		} catch (MalformedURLException e) {
		} catch (IOException e) {
		}
		if (responseCode == 200) {
			urlOk = true;
		}
		return urlOk;
	}

	/**
	 * 手动刷新会员等级
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/reloadLevel")
	@ResponseBody
	public boolean reloadLevel(HttpServletRequest request) {

		int updateNum = D.sqlAt("sql.member/reloadLevel").update();
		System.out.println("reloadLevel updateNum:" + updateNum);
		return true;
	}

	@RequestMapping("/edit/{member_id}")
	public String edit(@PathVariable("member_id") Long member_id, HttpServletRequest request) {
		Member member = D.selectById(Member.class, member_id);
		request.setAttribute("memberR", member);
		return "member/member/edit";
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean save(@RequestBody Member member) {
		D.updateWithoutNull(member);
		return true;
	}
}
