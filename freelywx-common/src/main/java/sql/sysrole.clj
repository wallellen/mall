(ns sql.sysrole
  (:use [com.rps.util.dao.cljutil.daoutil2] )
  (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))

 (defsql getPageRole
  {
   :sql "select * from t_sys_role "
   :where (AND 
		 ("role_nm"  "role_nm like ?" "%" "%")
     ("role_desc"  "role_desc like ?" "%" "%")
     {"user_type"  " user_type = ?"}
	)
   :page true
   :orderby true
   :orderby-default " order by role_id "
   })
   
   
   (def getRoleName
   	"SELECT DISTINCT R.role_nm
		  FROM t_sys_role R
		  JOIN(
		       (SELECT role_id FROM t_sys_user_role  UR WHERE UR.user_id = ?)
		       	UNION 
		       (SELECT role_id FROM t_sys_user_grp_role UGR
		         JOIN t_sys_user_grp_user UGU
		           ON UGR.grp_id = UGU.grp_id
		        WHERE UGU.user_id = ?)
	        ) UNR
		    ON R.role_id = UNR.role_id"
   )
   
   (def getOptUrl
   	"SELECT DISTINCT F.url
		  FROM t_sys_fun_opt F
		  JOIN t_sys_role_fun_opt RF
		    ON F.fun_opt_id = RF.fun_opt_id
		  JOIN(
		  	(SELECT role_id FROM t_sys_user_role UR WHERE UR.user_id = ?)
			UNION 
			(SELECT role_id FROM  t_sys_user_grp_role  UGR
		         JOIN t_sys_user_grp_user UGU
		           ON UGR.grp_id = UGU.grp_id
		        WHERE UGU.user_id = ?) )UR
		    ON RF.role_id = UR.role_id"
   )
   
   (def getMenueByUserId
   	"SELECT menue_id, menue_nm, url, par_menue_id, sort FROM (
		SELECT DISTINCT menue_id, M.menue_nm, F.url, M.par_menue_id, M.sort
		  FROM t_sys_menue M
		  JOIN t_sys_fun_opt F 
		    ON M.fun_opt_id = F.fun_opt_id
		  JOIN t_sys_role_fun_opt RF
		    ON F.fun_opt_id = RF.fun_opt_id
		  JOIN ((SELECT role_id FROM t_sys_user_role UR WHERE UR.user_id = ?)
		UNION (SELECT role_id
		         FROM t_sys_user_grp_role UGR
		         JOIN t_sys_user_grp_user UGU
		           ON UGR.grp_id = UGU.grp_id
		        WHERE UGU.user_id = ?)) UR
		    ON RF.role_id = UR.role_id
		    ) T ORDER BY T.par_menue_id, T.sort"
   )