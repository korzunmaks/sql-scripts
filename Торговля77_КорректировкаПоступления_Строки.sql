
SET NOCOUNT ON

SELECT 
	������������������_������������������������.iddoc,
	CASE
		WHEN ������������������_������������������������.���������ID = '    L9   ' 
			OR ������������������_������������������������.���������ID = '     0   '
			THEN '@0000000000000000'
		WHEN ������������������_������������������������.���������ID = '    LB   '
			THEN '@0000000000000010'
		WHEN ������������������_������������������������.���������ID = '   5ZQ   '
			THEN '@0000000000000018'
		WHEN ������������������_������������������������.���������ID = '    LA   '
			THEN '@0000000000000020'
		ELSE '@0000000000000001'
	END AS �����IDD,
	������������������_������������������������.���������ID AS ���������ID,
	SUM(������������������_������������������������.��������) AS ����������,
	SUM(	
		CASE
			WHEN ������������������_������������������������.�������� = 0 THEN
				0
			ELSE 
				������������������_������������������������.�������������� / ������������������_������������������������.��������
		END
	) AS ����,
	SUM(������������������_������������������������.��������������) AS �����,
	SUM(������������������_������������������������.��������) AS ���

FROM 
	���_��������������_��������������������������� AS ������������������_������������������������

WHERE 
	������������������_������������������������.iddoc = ' 63QTJ   '  
GROUP BY
	������������������_������������������������.iddoc,
	CASE
		WHEN ������������������_������������������������.���������ID = '    L9   '
			OR ������������������_������������������������.���������ID = '     0   '
			THEN '@0000000000000000'
		WHEN ������������������_������������������������.���������ID = '    LB   '
			THEN '@0000000000000010'
		WHEN ������������������_������������������������.���������ID = '   5ZQ   '
			THEN '@0000000000000018'
		WHEN ������������������_������������������������.���������ID = '    LA   '
			THEN '@0000000000000020'
		ELSE '@0000000000000001'
	END,
	������������������_������������������������.���������ID		
