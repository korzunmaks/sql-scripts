USE RIASSE

SET NOCOUNT ON

WITH ������������������ (date_time_iddoc
	, iddoc
	, ���������������������
	, IDD
	, ��������
	, �������
	, closed
	, ismark
	, ����������������
	, �����IDD
	, �����IDD
	, ���������IDD
	, ����������������IDD
	, ������IDD
	, �������IDD
	, �����������
	, ������������������
	, ���������������
	, ����������������
	, ����������������
	, �����������������
	, ��������������
)
AS (SELECT 
	���_��������_������������������.date_time_iddoc AS date_time_iddoc
	, ���_��������_������������������.iddoc AS iddoc
	, 'O1'+'  C2'+���_��������_������������������.iddoc AS ��������������������� 
	, ���_��������_������������������.IDD AS IDD
	, ���_��������_������������������.�������� AS �������� 
	, ���_��������_������������������.������� AS �������
	, CAST(���_��������_������������������.closed AS INT) AS closed
	, CAST(���_��������_������������������.ismark AS INT) AS ismark
	, ���_��������_������������������.����������������_������������� AS ����������������
	, ���_��������_������������������.�����IDD AS �����IDD
	, ���_��������_������������������.�����IDD AS �����IDD
	, LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', ���_��������_������������������.�����IDD+���_��������_������������������.�����IDD),1), 18, 32))) AS ���������IDD 
	, LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', ���_��������_������������������.�����IDD+���������������������.IDD),1), 18, 32))) AS ����������������IDD 
	, ���_��������_������������������.������IDD AS ������IDD
	, ���_��������_������������������.�������IDD AS �������IDD
	, ���_��������_������������������.����������� AS �����������	
	, ���_��������_������������������.������������������ AS ������������������
	, ���_��������_������������������.��������������� AS ���������������
	, ���_��������_������������������.���������������� AS ����������������
	, ���_��������_������������������.���������������� AS ����������������
	, ���_��������_������������������.����������������� AS �����������������
	, ���_��������_������������������.�������������� AS ��������������

FROM 
	dbo.���_��������_������������������ AS ���_��������_������������������ with (forceseek)
   	LEFT JOIN ���_����������_������������� AS ������������� with (forceseek)
		ON ���_��������_������������������.�����ID = �������������.ID
   	LEFT JOIN ���_����������_������������� AS ��������������������� with (forceseek)
		ON �������������.��������ID = ���������������������.ID
WHERE 
	���_��������_������������������.date_time_iddoc >='20190401'
	AND ���_��������_������������������.date_time_iddoc <='20190630z'
	AND (���_��������_������������������.������������������ <> '12'	  --������ ���.��������
		AND ���_��������_������������������.������������������ <> '6' --�����
		AND ���_��������_������������������.������������������ <> '7' --��������� ��-���
		AND ���_��������_������������������.������������������ <> '9' --������ �������
		)
	--AND ���_��������_������������������.closed &1=1
	AND (���_��������_������������������.closed <> 0
		OR ���_��������_������������������.ismark <> 0
		)
	AND ���_��������_������������������.IDD <> ''
	--AND ���_��������_������������������.�����IDD IN ('99000050003469724')
)
SELECT ���������.* 
From(
SELECT 
	������������������.*
	,(SELECT TOP (1) 
		���������������������.IDD
	FROM
		_1SCRDOC As �������������������� with (forceseek)
		 LEFT JOIN dbo.���_��������_����������������_������� AS ��������������������� with (forceseek)
			ON ��������������������.CHILDID = ���������������������.iddoc
	WHERE
		��������������������.MDID = 0 -- ������ ���������, ��� ���� ������
		AND ��������������������.PARENTVAL = ������������������.���������������������
		AND ���������������������.CLOSED &1=1
		AND ���������������������.����������������� = ������������������.�����������������
	ORDER BY 
		��������������������.CHILD_DATE_TIME_IDDOC
	) AS ���������������������IDD  
FROM 
	������������������) AS ���������
WHERE
	���������.���������������������IDD = '99000810000272757'
