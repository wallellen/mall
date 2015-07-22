(ns sql.coupon
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getCashCouponList
  {
   :sql " SELECT * FROM T_C_CASH_COUPON  "
   :where (AND 
		   ("cash_coupon_name" " cash_coupon_name like ?" "%" "%" )
		   ("cash_coupon_start_time" " cash_coupon_start_time > ?" )
		   ("cash_coupon_end_time" " cash_coupon_end_time < ?" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by CREATE_TIME desc "
   })

(defsql getCouponList
  {
   :sql " SELECT * FROM T_C_COUPON  "
   :where (AND 
		   ("coupon_name" " coupon_name like ?" "%" "%" )
		   ("coupon_start_time" " coupon_start_time > ?" )
		   ("coupon_end_time" " coupon_end_time < ?" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by CREATE_TIME desc "
   })

(defsql getCouponUseList
  {
   :sql " 
SELECT T_C_COUPON_2_MEMBER.* ,T_M_MEMBER.MEMBER_NAME,
CASE
	WHEN USE_TIME IS NULL AND CASH_COUPON_END_TIME>NOW() THEN '1'
	WHEN USE_TIME IS NOT NULL THEN '2'
	WHEN USE_TIME IS NULL AND CASH_COUPON_END_TIME<NOW() THEN '3'
ELSE '1' END COUPON_STATE_NEW,
CASE 
	WHEN COUPON_TYPE='1' THEN (SELECT T_C_CASH_COUPON.CASH_COUPON_NAME FROM T_C_CASH_COUPON WHERE T_C_CASH_COUPON.CASH_COUPON_ID=T_C_COUPON_2_MEMBER.CASH_COUPON_ID)
	WHEN COUPON_TYPE='2' THEN (SELECT T_C_COUPON.COUPON_NAME FROM T_C_COUPON WHERE T_C_COUPON.COUPON_ID=T_C_COUPON_2_MEMBER.CASH_COUPON_ID)
ELSE '' END COUPON_NAME,
CASE 
	WHEN COUPON_TYPE='1' THEN (SELECT T_C_CASH_COUPON.CASH_COUPON_VALUE FROM T_C_CASH_COUPON WHERE T_C_CASH_COUPON.CASH_COUPON_ID=T_C_COUPON_2_MEMBER.CASH_COUPON_ID)
	WHEN COUPON_TYPE='2' THEN (SELECT T_C_COUPON.COUPON_VALUE FROM T_C_COUPON WHERE T_C_COUPON.COUPON_ID=T_C_COUPON_2_MEMBER.CASH_COUPON_ID)
ELSE '' END COUPON_VALUE
FROM T_C_COUPON_2_MEMBER 
LEFT JOIN T_M_MEMBER ON T_C_COUPON_2_MEMBER.MEMBER_ID=T_M_MEMBER.MEMBER_ID
"
   :where (AND 
		   ("coupon_name" " coupon_name like ?" "%" "%" )
		   ("cash_coupon_start_time" " cash_coupon_start_time > ?" )
		   ("cash_coupon_end_time" " cash_coupon_end_time < ?" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by bind_time desc "
   })