(ns sql.tbDict
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 
(def getComboxDict
   " select dict_param_value as id,dict_param_name as text from T_B_DICT_DETAIL  where   dict_id = ? "
 )
   

 (defsql getPageDict
  {
   :sql "select * from T_B_DICT "
   :where (AND 
		   ("dict_id"  "dict_id like ?" "%" "%")
		   ("dict_name"  " DICT_NAME like ?" "%" "%")
	)
   :page true
   ;:orderby true
   :orderby-default " order by dict_id "
   })