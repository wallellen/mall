(ns sql.merchantwx
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 
(defsql getPageMerchantWx
  {
   :sql "select *  from t_wx_info  "
   :where (AND 
		   ("public_name"  "public_name like ?" "%" "%")
     
	)
   :page true
   :orderby true
   :orderby-default " order by wx_id "
   })