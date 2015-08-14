(ns sql.sysuser
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(def getUserByLoginID
   "select * from t_sys_user where login_id = ?"
  )
 
(def getUserById
   "select * from t_sys_user where user_id = ?"
  )

 (defsql getPageUser
  {
   :sql "select * from t_sys_user  "
   :where (AND  "user_status != '3' " 
		  ("login_id"  "login_id like ?" "%" "%")
		  ("user_name"  " user_name like ?" "%" "%")
		  ("site_id"  " site_id = ? ")
      {"user_type"  " user_type = ?"}
	)
   :page true
   :orderby true
   :orderby-default " order by user_id "
   })