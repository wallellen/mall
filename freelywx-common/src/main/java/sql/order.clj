(ns sql.order
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getOrderlist
  {
   :sql " select o.*, m.nickname from t_o_order o left join t_m_member m on o.member_id = m.member_id "
   :where (AND 
       {"order_status" "o.order_status != ?" }
	   ( "order_id" "o.order_id = ?" )
       ( "member_id" "o.member_id = ?" )
       ( "site_id" "o.site_id = ?" )
       { "site_id" "o.site_id = ?" }
       ( "create_time_le" "o.create_time <= ?" ) 
       ( "create_time_ge" "o.create_time >= ?" ) 
       ( "order_status" "o.order_status = ?" )
       ( "nickname" "nickname like ?" "%" "%")
       ( "shipper" "shipper like ?" "%" "%")
       ( "mobile" "mobile like ?" "%" "%")
       ( "email" "email like ?" "%" "%")
    	   )
   :page true
   :orderby true
   :orderby-default " order by member_id desc "
   })

(def getOrderDetail
   " select * from t_o_order_detail where order_id = ?"
)

   
   
(defsql getActOrderlist
  {
   :sql " select * from T_PROD_ORDER "
   :where 
   	(AND 
   	   { "order_status" "order_status != ?" }
	   ( "order_id" "order_id = ?" )
	   ( "receive_nick" "receive_nick like ?" "%" "%")
       ( "shipper" "shipper like ?" "%" "%")
	   ( "phone" "phone = ?" )
       ( "create_time_le" "create_time <= ?" ) 
       ( "create_time_ge" "create_time >= ?" ) 
   )
   :page true
   :orderby true
   :orderby-default " order by CREATE_TIME desc "
   })