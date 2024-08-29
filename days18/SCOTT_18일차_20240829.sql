--��ȣȭ(+��ȣȭ)
--https://technet.tmaxsoft.com/upload/download/online/tibero/pver-20150504-000001/tibero_pkg/chap_dbms_obfuscation.html
--(��ȣȭ ��Ű��) DBMS_OBFUSCATION_TOOLKIT

-- sys���� GRANT  EXECUTE ON DBMS_OBFUSCATION_TOOLKIT TO scott; �ؾ���
-- GRANT  EXECUTE ON DBMS_OBFUSCATION_TOOLKIT TO PUBLIC; (�̰� ��ο��� �ο�)



--��ĪŰ�� ��ȣȭ�� �ϴ� �� �����ؾ���
CREATE TABLE tbl_member
(
    id VARCHAR2(20) PRIMARY KEY
    , passwd VARCHAR2(20)
); 
INSERT INTO tbl_member ( id, passwd ) VALUES (  'hong',  cryptit.encrypt( '1234', 'test') );
INSERT INTO tbl_member ( id, passwd ) VALUES (  'kenik',  cryptit.encrypt( 'kenik', 'test') );

SELECT *
FROM tbl_member;


ROLLBACK;

--���� (���� �κ�)
CREATE OR REPLACE PACKAGE CryptIT
IS
   FUNCTION encrypt(str VARCHAR2, HASH VARCHAR2)
       RETURN VARCHAR2;
   FUNCTION decrypt(str VARCHAR2, HASH VARCHAR2)
       RETURN VARCHAR2;
END CryptIT;
--Package CRYPTIT��(��) �����ϵǾ����ϴ�.

--��ü
CREATE OR REPLACE PACKAGE BODY CryptIT
IS
   s VARCHAR2(2000);
    
   FUNCTION encrypt(str VARCHAR2, HASH VARCHAR2)
       RETURN VARCHAR2
        IS
            p NUMBER := ((FLOOR(LENGTH(str)/8+0.9))*8);
        BEGIN
            DBMS_OBFUSCATION_TOOLKIT.DESEncrypt(
               input_string => RPAD(str,p)
                ,key_string => RPAD(HASH,8,'#')
                ,encrypted_string => s
            );
            RETURN s;
        END;
   FUNCTION decrypt(str VARCHAR2, HASH VARCHAR2)
       RETURN VARCHAR2
        IS
        BEGIN
            DBMS_OBFUSCATION_TOOLKIT.DESDecrypt(
               input_string => str
                ,key_string => RPAD(HASH,8,'#')
                ,decrypted_string => s
            );
            RETURN TRIM(s);
        END;    

END CryptIT;
--Package Body CRYPTIT��(��) �����ϵǾ����ϴ�.