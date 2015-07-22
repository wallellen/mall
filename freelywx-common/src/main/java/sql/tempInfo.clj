(ns sql.tempInfo
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 
(defsql getPageTempInfo
  {
   :sql "select *  from t_temp_info  "
   :where (AND 
        ("info_name"  "info_name like ?" "%" "%")
     
	)
   :page true
   :orderby true
   :orderby-default " order by temp_infoid "
   })