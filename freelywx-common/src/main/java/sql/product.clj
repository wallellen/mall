(ns sql.product
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getProdlist
  {
   :sql " select T1.*,T2.category_name as categoryName,T3.brand_name  as brandName from T_P_PRODUCT  T1 
            left join  T_P_CATEGORY T2 ON T1.category_id = T2.category_id 
            left join  T_P_BRAND T3 ON T1.brand_id = T3.brand_id"
   :where (AND 
		   ("status" " T1.status = ?" )
       ("prod_name" " T1.prod_name like ?"  "%" "%")
       ("prod_code" " T1.prod_code like ?"  "%" "%")
		   ("category_id" " T1.CATEGORY_ID in 
                        (select distinct CHILD_CATEGORY_ID from T_P_CATEGORY_TREE where CATEGORY_ID = ? )" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by T1.display_order"
   }) 
   
(defsql getPageProdlistByType
  {
   :sql " select T1.*,T2.category_name as categoryName,T3.brand_name  as brandName from T_P_PRODUCT  T1 
            left join  T_P_CATEGORY T2 ON T1.category_id = T2.category_id 
            left join  T_P_BRAND T3 ON T1.brand_id = T3.brand_id"
   :where (AND 
		   {"status" " T1.status = ?" }
		   ("prod_type_id" " T1.prod_id IN( SELECT prod_id from T_P_RECOMMEND where prod_type_id = ?)" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by T1.create_time desc "
   }) 
   
(def getNotProdlistByType
   " select T1.*,T2.category_name as categoryName,T3.brand_name  as brandName from T_P_PRODUCT  T1 
            left join  T_P_CATEGORY T2 ON T1.category_id = T2.category_id 
            left join  T_P_BRAND T3 ON T1.brand_id = T3.brand_id
			where  T1.status = ? and
			T1.prod_id not IN( SELECT prod_id from T_P_RECOMMEND where prod_type_id = ?)" 
   ) 
(def getProdlistByType
   " select T1.*,T2.category_name as categoryName,T3.brand_name  as brandName from T_P_PRODUCT  T1 
            left join  T_P_CATEGORY T2 ON T1.category_id = T2.category_id 
            left join  T_P_BRAND T3 ON T1.brand_id = T3.brand_id
			where  T1.status = ? and
			T1.prod_id  IN( SELECT prod_id from T_P_RECOMMEND where prod_type_id = ?)" 
   ) 

(defsql getCategoryList
  {
   :sql " select * from T_P_CATEGORY  "
   :where (AND 
		   ("status" " status = ?" )
		   ("category_id" " category_id = ?" )
		   ("category_name" " category_name like ?" "%" "%" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by display_order asc,create_time desc "
   })

(defsql getAttrList
  {
   :sql " select T1.*,T2.DICT_NAME AS resName from T_P_ATTR T1 LEFT JOIN T_B_DICT T2  
           on  T1.RES_ID = T2.DICT_ID "
   :where (AND 
		   ("attr_name" " T1.ATTR_NAME like ?" "%" "%")
    	   )
   :page true
   :orderby true
   :orderby-default " order by create_time desc "
   })


(defsql getProdTypeList
  {
   :sql " select * from T_P_PROD_TYPE"
   :where (AND 
		   ("type_name" " type_name  like ?" "%" "%")
		   ("status" " status = ?" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by create_time desc "
   })

(defsql getProdBrandList
  {
   :sql " select * from T_P_BRAND"
   :where (AND 
		   ("brand_name" " brand_name like ?" "%" "%")
		   ("status" " status = ?" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by display_order asc ,create_time desc "
   })

(def getCategoryDetail
  " select t1.*,t2.category_name as pName from T_P_CATEGORY t1 
     left join T_P_CATEGORY t2 on t1.parent_category_id = t2.category_id 
     where t1.category_id = ?  "
  )


;跟句category_id查询 分类的属性
(def getAttrByCategoryId
  " select * from T_P_ATTR T1 where T1.ATTR_ID IN ( 
	 SELECT distinct ATTR_ID FROM T_P_CATEGORY_ATTR  where category_id in(
		select category_id from T_P_CATEGORY_TREE where CHILD_CATEGORY_ID = ? )) order by display_order"
  )
