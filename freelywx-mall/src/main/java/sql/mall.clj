(ns sql.mall
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

(defsql getProduct {
   :sql " SELECT S.*,R.PROD_ID origin_id FROM T_PROD_SALE S LEFT JOIN T_P_RECOMMEND R ON R.SORT = S.PROD_ID  "
   :where (AND 
           " R.PROD_TYPE_ID = 1 "
          ("prod_id" " S.PROD_ID = ? ")
          ("prod_id_r" " R.PROD_ID = ? ")
   )
})

(defsql pageProd {
   :sql " SELECT P.* FROM T_P_PRODUCT P LEFT JOIN T_P_CATEGORY C ON P.CATEGORY_ID = C.CATEGORY_ID "
   :where (AND 
           " P.STATUS = 2 "
   )
  :page true
  :orderby true
  :orderby-default " ORDER BY C.DISPLAY_ORDER, P.DISPLAY_ORDER ASC "
})

(defsql listProd {
   :sql " SELECT P.* FROM T_P_PRODUCT P LEFT JOIN T_P_CATEGORY C ON P.CATEGORY_ID = C.CATEGORY_ID "
   :where (AND 
           " P.STATUS = 2 "
           ("prod_id" " P.PROD_ID = ? ")
   )
  :orderby true
  :orderby-default " ORDER BY C.DISPLAY_ORDER, P.DISPLAY_ORDER ASC "
})

(defsql listZone {
  :sql " SELECT * FROM T_B_ZONE "
  :where (AND 
           {"pid" " PARENT_CODE = ? "}
           {"nid" " NODE_CLASS = ? "}
         )
  :orderby true
  :orderby-default " ORDER BY ZONE_ORDER ASC "
})

(def getColor "SELECT A.ATTR_ID,A.ATTR_NAME,B.ATTR_VALUE attrValue FROM T_P_ATTR A LEFT JOIN T_P_PRODUCT_ATTR B ON A.ATTR_ID = B.ATTR_ID WHERE B.PROD_ID = ? AND A.ATTR_ID = 16")