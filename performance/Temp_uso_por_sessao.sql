SELECT   b.TABLESPACE
       , A.STATUS         
       , b.segfile#
       , b.segblk#
       , ROUND (  (  ( b.blocks * p.VALUE ) / 1024 / 1024 /1024 ), 2 ) size_mb
       , a.SID
       , a.serial#
       , a.username
       , a.osuser
       , a.program
       , a.STATE
       ,a.SECONDS_IN_WAIT
    FROM v$session a
       , v$sort_usage b
       , v$process c
       , v$parameter p
   WHERE p.NAME = 'db_block_size'
     AND a.saddr = b.session_addr
     AND a.paddr = c.addr
     AND a.STATUS = 'INACTIVE'
ORDER BY 5 desc
