(ns sql.service
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getServiceList
  {
   :sql " SELECT t.*,t2.MEMBER_NAME from T_CUS_SERVICE t LEFT JOIN t_m_member t2  on t.MEMBER_ID = t2.MEMBER_ID "
   :where (AND 
		   ("member_name" " t2.MEMBER_NAME like ?" "%" "%")
		   ("title" " t.TITLE like ?" "%" "%")
		   ("mobile" " t.mobile like ?" "%" "%")
    	   )
   :page true
   :orderby true
   :orderby-default " order by t.create_time "
   })
