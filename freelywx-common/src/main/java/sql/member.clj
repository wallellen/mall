(ns sql.member
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 
(defsql getPageMember
  {
   :sql "select t.*   from t_m_member  t   "
   :where (AND 
        ("member_id"  "t.member_id like ?" "%" "%")
     
	)
   :page true
   :orderby true
   :orderby-default " order by member_id "
   })