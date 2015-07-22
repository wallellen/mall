(ns sql.tpuser
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(def getUserByLoginID
   "select * from T_P_USER where LOGIN_ID = ?"
  )
 
(def getUserById
   "select * from T_P_USER where USER_ID = ?"
  )

 (defsql getPageUser
  {
   :sql "select * from T_P_USER  "
   :where (AND 
        "user_status != '3' " 
		  ("login_id"  "login_id like ?" "%" "%")
		  ("user_name"  " user_name like ?" "%" "%")
      {"user_type"  " user_type = ?"}
	)
   :page true
   :orderby true
   :orderby-default " order by user_id "
   })