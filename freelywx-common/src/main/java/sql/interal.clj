(ns sql.interal
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getInteralLogList
  {
   :sql " SELECT T_I_INTERAL_LOG.*,T_M_MEMBER.MEMBER_NAME FROM T_I_INTERAL_LOG 
            LEFT JOIN T_M_MEMBER ON T_I_INTERAL_LOG.MEMBER_ID=T_M_MEMBER.MEMBER_ID"
   :where (AND 
		   ("member_name" " MEMBER_NAME like ?" "%" "%" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by T_I_INTERAL_LOG.CREATE_TIME DESC "
   })

(defsql getInteralRuleList
  {
   :sql " SELECT * FROM T_I_INTERAL_RULE"
   :where (AND 
		   ("interal_rule_name" " T_I_INTERAL_RULE.INTERAL_RULE_NAME like ?" "%" "%" )
    	   )
   :page true
   :orderby true
   :orderby-default " order by T_I_INTERAL_RULE.LAST_UPDATE_TIME DESC "
   })
   
(defsql getInteralExchangeList
  {
   :sql " SELECT * FROM T_I_INTERAL_EXCHANGE"
   :where (AND 
		   ("interal_exchange_id" " T_I_INTERAL_EXCHANGE.INTERAL_EXCHANGE_ID = ?")
    	   )
   :page true
   :orderby true
   :orderby-default " order by T_I_INTERAL_EXCHANGE.CREATE_TIME DESC "
   })