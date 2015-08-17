(ns sql.publish
   (:use [com.rps.util.dao.cljutil.daoutil2] )
   (:import [javax.servlet.http HttpServletRequest]
           [com.rps.util.dao SqlAndParams]
           [java.util ArrayList]))


(defsql getPageKeyword {
   :sql "SELECT * FROM t_wx_keyword  "
   :where (AND 
       {"keyword_id" "keyword_id = ?" }
       {"keyword" "keyword = ?" }
       {"keyword_type" "keyword_type = ?" }
       ("keyword_id" "keyword_id = ?" )
       ("keyword" "keyword = ?" )
       ("keyword_type" "keyword_type = ?" )
    )
   :page true
   :orderby true
   :orderby-default " order by keyword_id asc "
})

;; text
(defsql getTextPage {
   :sql "SELECT * FROM t_wx_text"
   :where (AND 
       {"id" "id = ?" }
       ("content"  "content like ?" "%" "%")
    )
   :page true
   :orderby true
   :orderby-default " order by id asc "
})

;;图文消息
(defsql getImgPage {
   :sql "SELECT * FROM t_wx_img"
   :where (AND 
       {"id" "id = ?" }
       ("title"  "title like ?" "%" "%")
       ("content"  "content like ?" "%" "%")
       {"title"  "title like ?" "%" "%"}
       {"content"  "content like ?" "%" "%"}
    )
   :page true
   :orderby true
   :orderby-default " order by id asc "
})

(defsql getAttentionPage {
   :sql "SELECT a.*,b.keyword  FROM t_wx_attention a left join t_wx_keyword b on a.keyword_id = b.keyword_id  "
   :where (AND 
       ("startTime" "a.start_time>=?")
       ("endTime" "a.start_time<=?")
       ("title" "a.title like ?" "%" "%")
    )
   :page true
   :orderby true
   :orderby-default " order by a.attention_id asc "
})
 
;;多图文消息
(defsql getImgMultiPage {
   :sql "SELECT a.*   FROM t_wx_img_multi  a   "
   :where (AND  
       ("keyword"  " a.keyword like ?" "%" "%")
    )
   :page true
   :orderby true
   :orderby-default " order by id asc "
})
 

;;根据ID查询对应的图文信息
(deftemplate getImgByIds [ids]
  "select * from  t_wx_img WHERE id IN @{ids}"
)
 
