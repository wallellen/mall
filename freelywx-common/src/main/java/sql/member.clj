(ns sql.member
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 
(defsql getPageMember
  {
   :sql "select t.* ,m.user_name from t_m_member  t  left join t_p_user m on t.uid = m.user_id "
   :where (AND 
        ("member_id"  "t.member_id like ?" "%" "%")
		    ("user_name"  " m.user_name like ?" "%" "%")
     
	)
   :page true
   :orderby true
   :orderby-default " order by member_id "
   })