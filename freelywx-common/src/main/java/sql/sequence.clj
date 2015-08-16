(ns sql.sequence
   (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(def getNextVal
   "select CONCAT(FUN_NEXTVAL(?)) currval"
  )   