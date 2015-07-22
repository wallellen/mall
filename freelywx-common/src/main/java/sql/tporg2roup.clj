(ns sql.tporg2roup
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(def getOrgGroupByOrgId
   "select * from T_F_ORG_GROUP where FINANCE_ORG_ID = ?"
  )

(def delete
   "delete from T_F_ORG_GROUP where FINANCE_ORG_ID = ? "
  )
  