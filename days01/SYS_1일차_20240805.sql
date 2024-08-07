--��� ����� ������ ��ȸ�ϴ� ����(����)
SELECT *
FROM all_users;
-- ����.. F5 | Ctrl Enter
--SCOTT ���� �����غ���
CREATE USER SCOTT IDENTIFIED BY tiger;
--User SCOTT��(��) �����Ǿ����ϴ�.
SELECT *
FROM dba_users;
--������� all_users�� �ٸ���

--��ı���� �����ϱ�
--CREATE SESSION ���� �ο�
--GRANT CREATE SESSION TO SCOTT;

--����� ����ִ� ���� �ο��ϸ� ���ϴ�
GRANT CONNECT, RESOURCE TO SCOTT;

SELECT *
FROM all_tables; -- ���� ���� ���̺�

FROM dba_tables; -- ��� ���̺�


FROM tabs;
FROM user_tables; --���� Ǯ��������  ��( View )

-- sys system�� ���� �ο� ���� ����
DROP USER scott; --ORA-01940: cannot drop a user that is currently connected
--���� ���̶� ���Ѵٴ� �� ,, ��ı ������ ���콺�� ��������
DROP USER scott; -- cmd������ ���� ���̶� ���� - ���������� disconnect -> exit
DROP USER scott; --ORA-01922: CASCADE must be specified to drop 'SCOTT'
--cascade�� �����ִ°� �� ������°�
DROP USER scott CASCADE; --User SCOTT��(��) �����Ǿ����ϴ�.

CREATE USER SCOTT IDENTIFIED BY tiger; --User SCOTT��(��) �����Ǿ����ϴ�.
GRANT CONNECT, RESOURCE TO SCOTT;

--  HR ������ �ִ��� ã��
SELECT *
FROM all_users;
-- HR ������ ��й�ȣ lion ���� �� ����Ŭ ���� (���)
ALTER USER HR IDENTIFIED BY lion; --User HR��(��) ����Ǿ����ϴ�.
ALTER USER HR ACCOUNT UNLOCK; --User HR��(��) ����Ǿ����ϴ�.

CREATE USER madang IDENTIFIED BY madang; --User MADANG��(��) �����Ǿ����ϴ�.
GRANT CONNECT, RESOURCE TO madang; --Grant��(��) �����߽��ϴ�.



