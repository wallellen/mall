(ns sql.tribe
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql pageTTT {
  :sql " SELECT * FROM T_T_TOPIC "
  :where (AND 
           {"status" " STATUS = 0 "}
           {"user_id" " CREATE_USER = ? "}
           {"prod_id" " PROD_ID = ? "}
           {"topic_type" " TOPIC_TYPE = ? "}
         )
  :page true
  :orderby true
  :orderby-default " ORDER BY CREATE_TIME DESC "
})

(defsql listTTT {
  :sql " SELECT * FROM T_T_TOPIC "
  :where (AND 
           {"status" " STATUS = 0 "}
           {"user_id" " CREATE_USER = ? "}
           {"prod_id" " PROD_ID = ? "}
           {"topic_type" " TOPIC_TYPE = ? "}
         )
  :orderby true
  :orderby-default " ORDER BY CREATE_TIME DESC "
})

(defsql pageTTR {
  :sql " SELECT * FROM T_T_REPLY "
  :where (AND 
           {"status" " STATUS = 0 "}
           ("topic_id" " TOPIC_ID = ? ")
           {"topic_id" " TOPIC_ID = ? "}
           {"user_id" " REPLY_USER = ? "}
         )
  :page true
  :orderby true
  :orderby-default " ORDER BY REPLY_TIME DESC "
})

(defsql listTTR {
  :sql " SELECT * FROM T_T_REPLY "
  :where (AND 
           {"status" " STATUS = 0 "}
           {"topic_id" " TOPIC_ID = ? "}
           {"user_id" " REPLY_USER = ? "}
         )
  :orderby true
  :orderby-default " ORDER BY REPLY_TIME DESC "
})

(defsql pageTTP {
  :sql " SELECT * FROM T_T_PRAISE "
  :where (AND 
           {"status" " STATUS = 0 "}
           {"topic_id" " TOPIC_ID = ? "}
           {"user_id" " PRAISE_USER = ? "}
         )
  :page true
  :orderby true
  :orderby-default " ORDER BY PRAISE_TIME DESC "
})

(defsql listTTP {
  :sql " SELECT * FROM T_T_PRAISE "
  :where (AND 
           {"status" " STATUS = 0 "}
           {"topic_id" " TOPIC_ID = ? "}
           {"user_id" " PRAISE_USER = ? "}
         )
  :orderby true
  :orderby-default " ORDER BY PRAISE_TIME DESC "
})



(defsql getPayCrowd
  "select  ORDER_ID, MEMBER_ID,sum( PAY_AMOUNT) as PAY_AMOUNT from ( 
	         SELECT P.* FROM T_O_ORDER_PAY P 
	         LEFT JOIN T_O_ORDER O ON P.ORDER_ID = O.ORDER_ID 
	         WHERE O.TYPE = 2 AND P.MEMBER_ID = ? AND P.MEMBER_ID != O.MEMBER_ID AND P.STATUS = '2')  t
	         group by ORDER_ID ,member_id "
  )