package com.freelywx.mall.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.store.TmSite;
import com.freelywx.common.model.store.TsiteBuilding;
import com.freelywx.mall.vo.CityVo;
import com.freelywx.mall.vo.Result;
import com.freelywx.mall.vo.SearchVo;
import com.rps.util.D;

@Controller
@RequestMapping("/store")
public class StoreController {
	@RequestMapping("")
	public String init() { 
		return "store";
	}
	
	@RequestMapping("getList")
	@ResponseBody
	public Result<List<CityVo>> getList() { 
		Result<List<CityVo>> vo = new Result<List<CityVo>>();
		try{
			//查询城市
			String citySql = "select distinct(t.city),t1.zone_name as cityname from t_m_site  t  left join T_B_ZONE t1 on t.city = t1.zone_code  ";
			List<CityVo> citys = D.sql(citySql).list(CityVo.class);
			if(citys!= null && citys.size() > 0){
				for(CityVo city : citys){
					String sql = "select * from t_m_site where city = ?  order by sort ";
					String build_sql = "select * from t_m_building where site_id = ?  order by sort  " ;   
					List<TmSite> list =  D.sql(sql).many(TmSite.class,city.getCity());
					if(list !=null && list.size() > 0){
						for(TmSite site : list){
							List<TsiteBuilding> bList =  D.sql(build_sql).many(TsiteBuilding.class,site.getSite_id());
							site.setBuildings(bList);
						}
						city.setSites(list);
					}
				}
				vo.setRet_code("0");
				vo.setDatas(citys);
			}
		}catch (Exception e) {
			e.printStackTrace();
			vo.setRet_code("1");
		}
		return vo;
	}
	
	@RequestMapping("search")
	@ResponseBody
	public Result<SearchVo> search(@RequestParam("keyword") String keyword) { 
		Result<SearchVo> vo = new Result<SearchVo>();
		SearchVo svo = new SearchVo();
		try{
			//查询城市
			String citySql = "SELECT * FROM t_m_building WHERE LOCATE( BUILD_NAME,?) >0 ";
			List<TsiteBuilding> list = D.sql(citySql).list(TsiteBuilding.class, keyword);
			if(list != null && list.size() > 0){
				svo.setBuilding(list.get(0));
				String build_sql = "select * from t_m_building where site_id = ?    order by sort  " ;   
				List<TsiteBuilding> buildList =  D.sql(build_sql).many(TsiteBuilding.class,list.get(0).getSite_id());
				svo.setAll_buildings(buildList);
				vo.setRet_code("0");
				vo.setDatas(svo);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			vo.setRet_code("1");
		}
		return vo;
	}
}
