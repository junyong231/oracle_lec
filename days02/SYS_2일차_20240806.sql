
SELECT *
FROM dba_users;
FROM all_users;

SELECT *
FROM all_tables  --조건으로 OWNER가 scott인걸 주면?
WHERE owner = 'SCOTT';

--예약어
SELECT *
FROM V$RESERVED_WORDS