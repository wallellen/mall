(ns sql.merchant
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 (defsql getPageMerchant
  {
   :sql "select T1.*,T2.user_name,T2.login_id from WX_M_MERCHANT T1 LEFT JOIN T_P_USER T2 on T1.USER_ID = T2.USER_ID  "
   :where (AND 
		   ;("USER_NAME"  "T2.USER_NAME = ?")
		   {"USER_ID"  "T2.USER_ID = ?"}
	)
   :page true
   :orderby true
   :orderby-default " order by T2.USER_ID "
   })
 
 
 (defsql getPageMerchantInfo
  {
   :sql "select * from WX_M_MERCHANT_INFO "
   :where (AND 
		     {"user_id"  "user_id = ?"}
		     ("public_name"  "public_name = ?")
	)
   :page true
   :orderby true
   :orderby-default " order by user_id "
   })
 
  (defsql getPageMerchantContacts
  {
   :sql "select * from WX_M_MERCHANT_CONTACTS "
   :where (AND 
		     {"user_id"  "user_id = ?"}
		     ("name"  "name = ?")
		     ("open_id"  "open_id = ?")
	)
   :page true
   :orderby true
   :orderby-default " order by contacts_id "
   })