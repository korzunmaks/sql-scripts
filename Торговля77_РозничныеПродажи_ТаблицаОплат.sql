
SET NOCOUNT ON
		
SELECT  
	LTRIM(RTRIM(��������������_����������������.���������)) AS ���������,
	LTRIM(RTRIM(��������������_����������������.�����������)) AS �����������,
	SUM(��������������_����������������.�����) AS �����

FROM dbo.���_��������������_���������������� AS ��������������_����������������

WHERE
	��������������_����������������.iddoc = ' 62D5E   '
GROUP BY
	���������,
	�����������
ORDER BY
	���������,
	����������� 
