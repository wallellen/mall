package com.freelywx.admin.product;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.config.Config;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.product.TpCategory;
import com.freelywx.common.model.product.TpCategoryAttr;
import com.freelywx.common.model.product.TpCategoryTree;
import com.freelywx.common.model.product.TpProduct;
import com.rps.util.D;

/**
 * 商品管理
 * 
 * @author Administrator
 * 
 */

@Controller
@RequestMapping(value = "/prodCate")
public class ProdCategoryController {

	@RequestMapping("")
	public String init() throws  IOException {
		return "product/prodCategory/category";
	}

	@RequestMapping("/list")
	@ResponseBody
	public List<TpCategory> list(HttpServletRequest request, HttpServletResponse response) {
		String categoryName = request.getParameter("category_name");
		String sql;
		if (StringUtils.isEmpty(categoryName)) {
			sql = "select * from T_P_CATEGORY   order by display_order ";
			return D.sql(sql).many(TpCategory.class);
		} else {
			sql = "select * from T_P_CATEGORY where  category_name like ?  order by display_order ";
			return D.sql(sql).many(TpCategory.class, "%" + categoryName + "%");
		}
	}

	@RequestMapping("/listAll")
	@ResponseBody
	public List<TpCategory> listAll(HttpServletRequest request, HttpServletResponse response) throws 
			IOException {
		String categoryName = request.getParameter("category_name");
		String sql;
		if (StringUtils.isEmpty(categoryName)) {
			sql = "select * from T_P_CATEGORY  where  parent_category_id > 0   order by display_order ";
			return D.sql(sql).many(TpCategory.class);
		} else {
			sql = "select * from T_P_CATEGORY where parent_category_id > 0 and category_name like ?  order by display_order ";
			return D.sql(sql).many(TpCategory.class, "%" + categoryName + "%");
		}
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean saveCategory(@ModelAttribute final TpCategory category, HttpServletRequest request) {
		try {
			ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			if (category.getCategory_id() != null) {
				category.setLast_update_time(new Date());
				category.setLast_updated_by(user.getUser_id());
				D.startTranSaction(new Callable() {
					@Override
					public Object call() {
						// TODO Auto-generated method stub
						Integer id = category.getCategory_id();
						Integer pid = category.getParent_category_id();
						D.sql("DELETE FROM T_P_CATEGORY_TREE   WHERE child_category_id IN (select child_category_id  from (SELECT child_category_id FROM T_P_CATEGORY_TREE  WHERE category_id = ?) p1) AND category_id"
								+ " IN  (select category_id from ( SELECT category_id FROM T_P_CATEGORY_TREE t3 WHERE t3.child_category_id = ? AND t3.category_id != t3.child_category_id) p2)")
								.update(id, id);

						D.sql("INSERT INTO T_P_CATEGORY_TREE (category_id, child_category_id) SELECT supertree.category_id, subtree.child_category_id FROM T_P_CATEGORY_TREE "
								+ "AS supertree CROSS JOIN T_P_CATEGORY_TREE AS subtree WHERE supertree.child_category_id = ? AND subtree.category_id = ?")
								.update(pid, id);

						D.updateWithoutNull(category);
						return null;
					}
				});
			} else {
				category.setStatus(SystemConstant.State.STATE_ENABLE);
				category.setCreate_time(new Date());
				category.setCreated_by(user.getUser_id());
				D.startTranSaction(new Callable() {
					@Override
					public Object call() {
						// TODO Auto-generated method stub
						int cateGoryId = D.insertAndReturnInteger(category);
						// 在关系结构表插入数据
						TpCategoryTree tpCategoryTree = new TpCategoryTree();
						tpCategoryTree.setCategory_id(cateGoryId);
						tpCategoryTree.setChild_category_id(cateGoryId);
						D.insert(tpCategoryTree);
						if (category.getParent_category_id() != null) {
							D.sql("INSERT INTO T_P_CATEGORY_TREE (category_id, child_category_id) SELECT t.category_id, ? FROM T_P_CATEGORY_TREE AS t WHERE t.child_category_id = ?")
									.update(cateGoryId, category.getParent_category_id());
						}
						return null;
					}
				});
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 跳转
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/edit")
	public String editCategory(HttpServletRequest request, Model model) {
		model.addAttribute("server_url", Config.SERVER_BASE);
		return "product/prodCategory/editCategory";
	}

	@RequestMapping("/bind")
	public String bind(HttpServletRequest request) {
		return "product/prodCategory/attrBind";
	}

	@RequestMapping("/bindAttr")
	@ResponseBody
	public boolean bindAttr(@RequestParam final String attrIds, @RequestParam final Integer categoryId) {
		try {
			D.startTranSaction(new Callable() {
				@Override
				public Object call() {
					// 先删除原有的关系
					D.sql("delete   from T_P_CATEGORY_ATTR where category_id = ?").update(categoryId);
					String[] ids = attrIds.split(",");
					int num = 0;
					for (String id : ids) {
						if (!StringUtils.isEmpty(id)) {
							TpCategoryAttr tpca = new TpCategoryAttr();
							tpca.setAttr_id(Integer.parseInt(id));
							tpca.setCategory_id(categoryId);
							tpca.setDisplay_order(++num);
							D.insert(tpca);
						}
					}
					return null;
				}
			});
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}

	@RequestMapping("/selectCategory")
	public String selectCategory(HttpServletRequest request, Model model) {
		model.addAttribute("category_id", request.getParameter("id"));
		model.addAttribute("default_category_id", request.getParameter("pid"));
		return "product/prodCategory/selectCategory";
	}

	/**
	 * 获取分类的详情
	 * 
	 * @param categoryId
	 * @return
	 */
	@RequestMapping("/category")
	@ResponseBody
	public TpCategory getCategory(HttpServletRequest request) {
		try {
			Long categoryId = Long.valueOf(request.getParameter("categoryId"));
			TpCategory category = D.sqlAt("sql.product/getCategoryDetail").oneOrNull(TpCategory.class, categoryId);
			return category;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/delete")
	@ResponseBody
	public HashMap<String, String> deleteCategory(HttpServletRequest request) {
		final HashMap<String, String> map = new HashMap<String, String>();
		try {
			final Long categoryId = Long.valueOf(request.getParameter("categoryId"));
			// 查询该分类是否绑定产品
			List<TpProduct> prodList = D.sql("select * from T_P_PRODUCT where category_id = ?").many(TpProduct.class,
					categoryId);
			// 查询是否有子分类
			List<TpCategory> cateList = D.sql("select * from T_P_CATEGORY where parent_category_id = ?").many(
					TpCategory.class, categoryId);
			if (prodList.size() > 0) {
				map.put("status", "1");
			} else if (cateList.size() > 0) {
				map.put("status", "2");
			} else {
				D.startTranSaction(new Callable() {
					@Override
					public Object call() {
						// TODO Auto-generated method stub
						D.deleteById(TpCategory.class, categoryId);
						D.sql("delete from T_P_CATEGORY_TREE where child_category_id = ?").update(categoryId);
						map.put("status", "3");
						return null;
					}
				});
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "0");
		}
		return map;
	}

	@RequestMapping("/check")
	@ResponseBody
	public boolean checkName(HttpServletRequest request) {
		try {
			String categoryName = request.getParameter("categoryName");
			String categoryId = request.getParameter("categoryId");
			if (!StringUtils.isEmpty(categoryId)) {
				List<TpCategory> categoryList = D.sql(
						"select * from T_P_CATEGORY where category_name = ? and category_id != ?").many(
						TpCategory.class, categoryName, categoryId);
				if (categoryList.size() > 0) {
					return false;
				}
			} else {
				List<TpCategory> categoryList = D.sql("select * from T_P_CATEGORY where category_name = ?").many(
						TpCategory.class, categoryName);
				if (categoryList.size() > 0) {
					return false;
				}
			}
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/res/upload", method = RequestMethod.POST)
	public HashMap<String, String> uploadeImg(HttpServletRequest request) {
		HashMap<String, String> map = new HashMap<String, String>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		// 文件保存路径
		String basePath = Config.UPLOAD_PATH;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String ymd = sdf.format(new Date());
		String extPath = File.separator + "category" + File.separator + ymd + File.separator;
		basePath = basePath + extPath;
		// 创建文件夹
		File file = new File(basePath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String srcPath = "";
		String fileName = null;
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			// 上传文件
			MultipartFile mf = entity.getValue();
			fileName = mf.getOriginalFilename();
			String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
			// 重命名文件
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
			File uploadFile = new File(basePath + newFileName);
			srcPath = extPath + newFileName;
			// 将\\斜杠改为/斜杠
			srcPath = StringUtils.replace(srcPath, "\\", "/");
			try {
				FileCopyUtils.copy(mf.getBytes(), uploadFile);
				map.put("url", srcPath);
				map.put("previewUrl", Config.SERVER_BASE+ srcPath);
				map.put("status", "1");
			} catch (IOException e) {
				map.put("status", "0");
				map.put("message", "图片上传失败");
				e.printStackTrace();
			}
		}
		return map;
	}
}
