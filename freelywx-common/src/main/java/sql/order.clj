(ns sql.order
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getOrderlist
  {
   :sql " select o.*, m.member_name from T_O_ORDER o left join T_M_MEMBER m on o.MEMBER_ID = m.MEMBER_ID "
   :where (AND 
       {"order_status" "o.order_status != ?" }
	   ( "order_id" "o.order_id = ?" )
       ( "member_id" "o.member_id = ?" )
       ( "create_time_le" "o.create_time <= ?" ) 
       ( "create_time_ge" "o.create_time >= ?" ) 
       ( "order_status" "o.order_status = ?" )
       ( "member_name" "member_name like ?" "%" "%")
       ( "shipper" "shipper like ?" "%" "%")
       ( "mobile" "mobile like ?" "%" "%")
       ( "email" "email like ?" "%" "%")
    	   )
   :page true
   :orderby true
   :orderby-default " order by member_id desc "
   })

(def getOrderDetail
   " select * from T_O_ORDER_DETAIL where ORDER_ID = ?"
)

(defsql transReqlist
  {
   :sql " 
SELECT T_B_EVERY_MORNING_TRANS_REQ.*,T_M_MEMBER_OUT.MEMBER_NAME REQ_MEMBER_NAME,T_M_MEMBER_IN.MEMBER_NAME RES_MEMBER_NAME
,T_B_EVERY_MORNING.EVERY_NAME,T_P_PRODUCT.PROD_NAME
FROM T_B_EVERY_MORNING_TRANS_REQ
LEFT JOIN T_M_MEMBER T_M_MEMBER_OUT ON T_B_EVERY_MORNING_TRANS_REQ.REQ_MEMBER_ID = T_M_MEMBER_OUT.MEMBER_ID
LEFT JOIN T_M_MEMBER T_M_MEMBER_IN ON T_B_EVERY_MORNING_TRANS_REQ.RES_MEMBER_ID = T_M_MEMBER_IN.MEMBER_ID
LEFT JOIN T_B_EVERY_MORNING ON T_B_EVERY_MORNING_TRANS_REQ.EVERY_ID = T_B_EVERY_MORNING.EVERY_ID
LEFT JOIN T_P_PRODUCT ON T_B_EVERY_MORNING_TRANS_REQ.PROD_ID = T_P_PRODUCT.PROD_ID
"
   :where (AND 
		   ( "order_id" "T_B_EVERY_MORNING_TRANS_REQ.order_id = ?" )
		   ( "every_id" "T_B_EVERY_MORNING_TRANS_REQ.every_id = ?" )
		   ( "prod_id" "T_B_EVERY_MORNING_TRANS_REQ.prod_id = ?" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by T_B_EVERY_MORNING_TRANS_REQ.CREATE_TIME desc "
   })

(defsql transReslist
  {
   :sql " 
SELECT T_B_EVERY_MORNING_TRANS_RES.*,T_M_MEMBER_OUT.MEMBER_NAME OUT_MEMBER_NAME,T_M_MEMBER_IN.MEMBER_NAME IN_MEMBER_NAME
,T_B_EVERY_MORNING.EVERY_NAME,T_P_PRODUCT.PROD_NAME
FROM T_B_EVERY_MORNING_TRANS_RES
LEFT JOIN T_M_MEMBER T_M_MEMBER_OUT ON T_B_EVERY_MORNING_TRANS_RES.OUT_MEMBER_ID = T_M_MEMBER_OUT.MEMBER_ID
LEFT JOIN T_M_MEMBER T_M_MEMBER_IN ON T_B_EVERY_MORNING_TRANS_RES.IN_MEMBER_ID = T_M_MEMBER_IN.MEMBER_ID
LEFT JOIN T_B_EVERY_MORNING ON T_B_EVERY_MORNING_TRANS_RES.EVERY_ID = T_B_EVERY_MORNING.EVERY_ID
LEFT JOIN T_P_PRODUCT ON T_B_EVERY_MORNING_TRANS_RES.PROD_ID = T_P_PRODUCT.PROD_ID
"
   :where (AND 
		   ( "order_id" "T_B_EVERY_MORNING_TRANS_RES.order_id = ?" )
		   ( "every_id" "T_B_EVERY_MORNING_TRANS_RES.every_id = ?" )
		   ( "prod_id" "T_B_EVERY_MORNING_TRANS_RES.prod_id = ?" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by T_B_EVERY_MORNING_TRANS_RES.CREATE_TIME desc "
   })
   
   
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