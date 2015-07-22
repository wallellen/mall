(ns sql.tprole
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 (defsql getPageRole
  {
   :sql "select * from T_P_ROLE "
   :where (AND 
		 ("role_nm"  "ROLE_NM like ?" "%" "%")
     ("role_desc"  "role_desc like ?" "%" "%")
     {"user_type"  " user_type = ?"}
	)
   :page true
   :orderby true
   :orderby-default " order by ROLE_ID "
   })
   
   
   (def getRoleName
   	"SELECT DISTINCT R.ROLE_NM
		  FROM T_P_ROLE R
		  JOIN(
		       (SELECT ROLE_ID FROM T_P_USER_ROLE UR WHERE UR.USER_ID = ?)
		       	UNION 
		       (SELECT ROLE_ID FROM T_P_USER_GRP_ROLE UGR
		         JOIN T_P_USER_GRP_USER UGU
		           ON UGR.GRP_ID = UGU.GRP_ID
		        WHERE UGU.USER_ID = ?)
	        ) UNR
		    ON R.ROLE_ID = UNR.ROLE_ID"
   )
   
   (def getOptUrl
   	"SELECT DISTINCT F.URL
		  FROM T_P_FUN_OPT F
		  JOIN T_P_ROLE_FUN_OPT RF
		    ON F.FUN_OPT_ID = RF.FUN_OPT_ID
		  JOIN(
		  	(SELECT ROLE_ID FROM T_P_USER_ROLE UR WHERE UR.USER_ID = ?)
			UNION 
			(SELECT ROLE_ID FROM T_P_USER_GRP_ROLE UGR
		         JOIN T_P_USER_GRP_USER UGU
		           ON UGR.GRP_ID = UGU.GRP_ID
		        WHERE UGU.USER_ID = ?) )UR
		    ON RF.ROLE_ID = UR.ROLE_ID"
   )
   
   (def getMenueByUserId
   	"SELECT MENUE_ID, MENUE_NM, URL, PAR_MENUE_ID, MENUE_ORDER FROM (
		SELECT DISTINCT MENUE_ID, M.MENUE_NM, F.URL, M.PAR_MENUE_ID, M.MENUE_ORDER
		  FROM T_P_MENUE M
		  JOIN T_P_FUN_OPT F 
		    ON M.FUN_OPT_ID = F.FUN_OPT_ID
		  JOIN T_P_ROLE_FUN_OPT RF
		    ON F.FUN_OPT_ID = RF.FUN_OPT_ID
		  JOIN ((SELECT ROLE_ID FROM T_P_USER_ROLE UR WHERE UR.USER_ID = ?)
		UNION (SELECT ROLE_ID
		         FROM T_P_USER_GRP_ROLE UGR
		         JOIN T_P_USER_GRP_USER UGU
		           ON UGR.GRP_ID = UGU.GRP_ID
		        WHERE UGU.USER_ID = ?)) UR
		    ON RF.ROLE_ID = UR.ROLE_ID
		    ) T ORDER BY T.PAR_MENUE_ID, T.MENUE_ORDER"
   )