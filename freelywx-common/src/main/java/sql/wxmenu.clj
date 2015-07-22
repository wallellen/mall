(ns sql.wxmenu
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 
(defsql getPageMenu
  {
   :sql "select * from t_pub_menu  "
   :where (AND 
        
     "UID = 2 " 
	)
   :page true
   :orderby true
   :orderby-default " order by MENU_ID "
   })