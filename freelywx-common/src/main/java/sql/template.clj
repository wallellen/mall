(ns sql.template
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 
(defsql getPageTempLate
  {
   :sql "select *  from t_temp_template  "
   :where (AND 
        ("temp_name"  "temp_name like ?" "%" "%")
     
	)
   :page true
   :orderby true
   :orderby-default " order by temp_id "
   })