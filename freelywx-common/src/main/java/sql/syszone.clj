(ns sql.syszone
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 (def getProvince
   "select * from t_sys_zone where node_class = 1 and parent_code = 0 order by zone_code,zone_order"
  )
  
  (def getCity
   "select * from t_sys_zone where node_class = 2 and parent_code = ? order by zone_code,zone_order"
  )
  
  (def getRegion
   "select * from t_sys_zone where node_class = 3 and parent_code = ? order by zone_code,zone_order"
  )

  (def getZoneByCode
   "select * from t_sys_zone where zone_code = ? order by zone_code,zone_order"
  )
   
 (def getComboxProvince
   " select zone_code as id ,zone_name as text  from t_sys_zone where node_class = 1 and parent_code = 0 order by zone_code,zone_order"
  )
   