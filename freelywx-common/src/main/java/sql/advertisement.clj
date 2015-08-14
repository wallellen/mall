(ns sql.advertisement
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getAdvertList
  {
   :sql " select a.*,c.coloum_name from t_ad_coloum a left join t_a_coloum c on a.coloum_id=c.coloum_id"
   :where (AND 
		   ("ad_name" " ad_name like ?" "%" "%")
    	   )
   :page true
   :orderby true
   :orderby-default " order by a.start_time desc"
   })
   
   
(defsql getColoumList
  {
   :sql " select * from T_A_COLOUM"
   :where (AND 
		   ("coloum_name" " coloum_name like ?" "%" "%")
    	   )
   :page true
   })
   

(defsql tipPage {
   :sql " SELECT * FROM T_A_TIP "
   :where (AND 
      ("type" "type = ?")
   )
   :page true
   :orderby true
   :orderby-default " ORDER BY CREATE_TIME DESC "
}) 

(defsql getPcTip {
	:sql " SELECT * FROM T_A_PC_TIP "
	:where (AND 
		("text" " TEXT LIKE ? " "%" "%")
	)
	:page true
	:orderby true
	:orderby-default " ORDER BY START_TIME DESC "
})


