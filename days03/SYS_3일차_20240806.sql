SELECT *
FROM all_tables
WHERE table_name = 'DUAL'; --sys��
WHERE table_name = 'EMPLOYEE';

--�ۺ� synonym  ������
CREATE PUBLIC SYNONYM arirang
FOR scott.emp;
--SYNONYM ARIRANG��(��) �����Ǿ����ϴ�.

GRANT SELECT ANY TABLE TO hr;
--�̷��� hr�� scott ���̺��� SELECT ������ ����� ������ arirang�� �� �� �ִ�
REVOKE SELECT ANY TABLE FROM hr;

--�ó�� ����
DROP PUBLIC SYNONYM arirang;

SELECT *
FROM user_tables;
FROM all_tables;
--�������ΰ�ó�� �̷� Ű���徲�� �ó�Ե� ã�� �� �ְڳ�

SELECT*
FROM all_synonyms
WHERE synonym_name = 'DUAL';
--dual�� ������ Ȯ���� �� ���� = sys.dual �Ƚᵵ �Ǵ� ����