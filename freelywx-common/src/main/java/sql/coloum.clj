(ns sql.coloum
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getColoumList
  {
   :sql " select * from T_A_COLOUM"
   :where (AND 
		   ("coloum_name" " coloum_name like ?" "%" "%")
    	   )
   :page true
   })