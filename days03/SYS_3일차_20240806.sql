SELECT *
FROM all_tables
WHERE table_name = 'DUAL'; --sys꺼
WHERE table_name = 'EMPLOYEE';

--퍼블릭 synonym  만들자
CREATE PUBLIC SYNONYM arirang
FOR scott.emp;
--SYNONYM ARIRANG이(가) 생성되었습니다.

GRANT SELECT ANY TABLE TO hr;
--이러면 hr도 scott 테이블의 SELECT 권한이 생겼기 때문에 arirang도 쓸 수 있다
REVOKE SELECT ANY TABLE FROM hr;

--시노님 삭제
DROP PUBLIC SYNONYM arirang;

SELECT *
FROM user_tables;
FROM all_tables;
--여러개인것처럼 이런 키워드쓰면 시노님도 찾을 수 있겠네

SELECT*
FROM all_synonyms
WHERE synonym_name = 'DUAL';
--dual도 있음을 확인할 수 있음 = sys.dual 안써도 되는 이유