(ns sql.tpUserGroupUser
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(def delRelation
   "delete from t_sys_user_grp_user where user_id = ?"
  )
  

(defsql getPageUserGroup
  {
   :sql "select * from t_sys_user_grp "
   :where (AND 
		   ("grp_nm"  "grp_nm like ?" "%" "%")
	)
   :page true
   :orderby true
   :orderby-default " order by grp_id "
   })