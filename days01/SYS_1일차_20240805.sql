--모든 사용자 정보를 조회하는 질의(쿼리)
SELECT *
FROM all_users;
-- 실행.. F5 | Ctrl Enter
--SCOTT 계정 생성해보자
CREATE USER SCOTT IDENTIFIED BY tiger;
--User SCOTT이(가) 생성되었습니다.
SELECT *
FROM dba_users;
--결과물이 all_users랑 다르네

--스캇으로 접속하기
--CREATE SESSION 권한 부여
--GRANT CREATE SESSION TO SCOTT;

--등등이 들어있는 롤을 부여하면 편리하다
GRANT CONNECT, RESOURCE TO SCOTT;

SELECT *
FROM all_tables; -- 접근 가능 테이블

FROM dba_tables; -- 모든 테이블


FROM tabs;
FROM user_tables; --위의 풀버전이자  뷰( View )

-- sys system만 계정 부여 권한 있음
DROP USER scott; --ORA-01940: cannot drop a user that is currently connected
--접속 중이라 못한다는 뜻 ,, 스캇 오른쪽 마우스로 접속해제
DROP USER scott; -- cmd에서도 접속 중이라 오류 - 해제해주자 disconnect -> exit
DROP USER scott; --ORA-01922: CASCADE must be specified to drop 'SCOTT'
--cascade로 딸려있는거 다 버리라는거
DROP USER scott CASCADE; --User SCOTT이(가) 삭제되었습니다.

CREATE USER SCOTT IDENTIFIED BY tiger; --User SCOTT이(가) 생성되었습니다.
GRANT CONNECT, RESOURCE TO SCOTT;

--  HR 계정이 있는지 찾기
SELECT *
FROM all_users;
-- HR 계정의 비밀번호 lion 수정 후 오라클 접속 (녹색)
ALTER USER HR IDENTIFIED BY lion; --User HR이(가) 변경되었습니다.
ALTER USER HR ACCOUNT UNLOCK; --User HR이(가) 변경되었습니다.

CREATE USER madang IDENTIFIED BY madang; --User MADANG이(가) 생성되었습니다.
GRANT CONNECT, RESOURCE TO madang; --Grant을(를) 성공했습니다.



