(ns sql.product
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getProdlist
  {
   :sql " select T1.*,T2.category_name as categoryName,T3.name  as brandName from t_p_product  T1 
            left join  t_p_category T2 ON T1.category_id = T2.category_id 
            left join  t_p_brand T3 ON T1.brand_id = T3.brand_id"
   :where (AND 
		   ("status" " T1.status = ?" )
       ("prod_name" " T1.prod_name like ?"  "%" "%")
       ("prod_code" " T1.prod_code like ?"  "%" "%")
       ("site_id" " T1.site_id = ?")
       {"site_id" " T1.site_id = ?"}
       ("category_id" " T1.category_id in 
                        (select distinct child_id from t_p_category_tree where category_id = ? )" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by T1.sort"
   }) 
   
(defsql getPageProdlistByType
  {
   :sql " select T1.*,T2.category_name as categoryName,T3.name  as brandName from t_p_product  T1 
            left join  t_p_category T2 ON T1.category_id = T2.category_id 
            left join  t_p_brand T3 ON T1.brand_id = T3.brand_id"
   :where (AND 
		   {"status" " T1.status = ?" }
      ("site_id" " T1.site_id = ?")
       {"site_id" " T1.site_id = ?"}
		   ("prod_type_id" " T1.prod_id IN( SELECT prod_id from t_p_recommend where prod_type_id = ?)" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by T1.create_time desc "
   }) 
   
(def getNotProdlistByType
   " select T1.*,T2.category_name as categoryName,T3.name  as brandName from t_p_product  T1 
            left join  t_p_category T2 ON T1.category_id = T2.category_id 
            left join  t_p_brand T3 ON T1.brand_id = T3.brand_id
			where  T1.status = ? and
			T1.prod_id not IN( SELECT prod_id from t_p_recommend where prod_type_id = ?)" 
   ) 
(def getProdlistByType
   " select T1.*,T2.category_name as categoryName,T3.name  as brandName from T_P_PRODUCT  T1 
            left join  T_P_CATEGORY T2 ON T1.category_id = T2.category_id 
            left join  T_P_BRAND T3 ON T1.brand_id = T3.brand_id
			where  T1.status = ? and
			T1.prod_id  IN( SELECT prod_id from T_P_RECOMMEND where prod_type_id = ?)" 
   ) 

(defsql getCategoryList
  {
   :sql " select * from t_p_category  "
   :where (AND 
		   ("status" " status = ?" )
		   ("category_id" " category_id = ?" )
		   ("category_name" " category_name like ?" "%" "%" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by sort asc,create_time desc "
   })

(defsql getAttrList
  {
   :sql " select T1.*,T2.dict_name AS resName from t_p_attr T1 LEFT JOIN t_sys_dict T2  
           on  T1.res_id = T2.dict_id "
   :where (AND 
		   ("attr_name" " T1.attr_name like ?" "%" "%")
    	   )
   :page true
   :orderby true
   :orderby-default " order by create_time desc "
   })


(defsql getProdTypeList
  {
   :sql " select * from t_p_prod_tag"
   :where (AND 
		   ("tag_name" " tag_name  like ?" "%" "%")
		   ("status" " status = ?" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by create_time desc "
   })

(defsql getProdBrandList
  {
   :sql " select * from t_p_brand "
   :where (AND 
		   ("name" " name like ?" "%" "%")
		   ("status" " status = ?" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by sort asc ,create_time desc "
   })

(def getCategoryDetail
  " select t1.*,t2.category_name as pName from T_P_CATEGORY t1 
     left join t_p_category t2 on t1.par_category_id = t2.category_id 
     where t1.category_id = ?  "
  )


;跟句category_id查询 分类的属性
(def getAttrByCategoryId
  " select * from t_p_attr T1 where T1.attr_id IN ( 
	 SELECT distinct attr_id FROM t_p_category_attr  where category_id in(
		select category_id from t_p_category_tree where child_id = ? )) order by sort"
  )
