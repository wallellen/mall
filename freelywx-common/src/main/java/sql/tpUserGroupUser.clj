(ns sql.tpUserGroupUser
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(def delRelation
   "delete from T_P_USER_GRP_USER where USER_ID = ?"
  )
  

(defsql getPageUserGroup
  {
   :sql "select * from T_P_USER_GRP "
   :where (AND 
		   ("grp_nm"  "grp_nm like ?" "%" "%")
	)
   :page true
   :orderby true
   :orderby-default " order by grp_id "
   })