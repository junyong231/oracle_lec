SELECT *
FROM tabs; -- hr ������ �����ϰ� �ִ� ���̺� ����

SELECT last_name||' '||first_name  AS NAME -- JAVA���ٸ� + ������� �ȵ�
FROM employees;
-- ����Ŭ�� ����(��), ��¥��  ' ' �ȿ� ��Ÿ����

SELECT first_name fn -- ��Ī ����� ����
       ,CONCAT (CONCAT (last_name, ' '), first_name) AS "������",
       CONCAT (CONCAT (last_name, ' '), first_name) űű
FROM employees; --�̷��Ե� ������ ǥ���� �� �ִ�.