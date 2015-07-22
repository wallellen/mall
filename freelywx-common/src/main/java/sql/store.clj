(ns sql.store
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 
(defsql getPageStore
  {
   :sql "select  t.*,t1.site_name  from  t_m_store  t  left join t_m_site t1 on t.site_id = t1.site_id "
   :where (AND 
        ("store_name"  "t.store_name like ?" "%" "%")
		    {"store_name"  "t.store_name like ?" "%" "%"}
        ("address"  "t.address like ?" "%" "%")
		    {"address"  " t.address like ?" "%" "%"}
        ("tel"  "t.tel like ?" "%" "%")
		    {"tel"  " t.tel like ?" "%" "%"}
        ("site_id"  "t.site_id = ? ")
		    {"site_id"  " t.site_id = ? "}
     
	)
   :page true
   :orderby true
   :orderby-default " order by sort "
   })
 
(defsql getPageSite
  {
   :sql "select  t1.*,t3.zone_name as provincename,t4.zone_name as cityname,t5.zone_name as districtname 
            from t_m_site  t1 
            left join T_B_ZONE t3 on t1.province = t3.zone_code
            left join T_B_ZONE t4 on t1.city = t4.zone_code
            left join T_B_ZONE t5 on t1.district = t5.zone_code "
   :where (AND 
        ("site_name"  "site_name like ?" "%" "%")
		    {"site_name"  " site_name like ?" "%" "%"}
	)
   :page true
   :orderby true
   :orderby-default " order by sort "
   })

(defsql getPageBuild
  {
   :sql "select  t.* ,t1.site_name from  t_m_building t  left join t_m_site t1 on t.site_id = t1.site_id"
   :where (AND 
        ("build_name"  "t.build_name like ?" "%" "%")
		    {"build_name"  " t.build_name like ?" "%" "%"}
        ("site_id"  "t.site_id = ? ")
		    {"site_id"  " t.site_id = ? "}
	)
   :page true
   :orderby true
   :orderby-default " order by sort "
   })