SET NOCOUNT ON

SELECT
	���������������������.iddoc,
	CASE
		WHEN ���������������������.���������ID = '    L9   '
				OR ���������������������.���������ID = '     0   '
			THEN '@0000000000000000'
		WHEN ���������������������.���������ID = '    LB   '
			THEN '@0000000000000010'
		WHEN ���������������������.���������ID = '   5ZQ   '
			THEN '@0000000000000018'
		WHEN ���������������������.���������ID = '    LA   '
			THEN '@0000000000000020'
		ELSE '@0000000000000001'
	END AS �����IDD,
	���������������������.���������ID,
	SUM(
		CASE
			WHEN ���������������������.����� = 0 
				THEN 0
			ELSE
				���������������������.����� / ���������������������.�����
		END
		) AS ����,
	SUM(���������������������.�����) AS ����������,
	SUM(���������������������.�������) AS ������������,
	SUM(���������������������.���) AS ���,
	SUM(���������������������.�����) AS �����
FROM
	���_��������������_��������������� AS ���������������������
WHERE
	���������������������.iddoc=' 6PDM1   '
GROUP BY
	���������������������.iddoc,
	CASE
		WHEN ���������������������.���������ID = '    L9   '
			OR ���������������������.���������ID = '     0   '
		THEN '@0000000000000000'
		WHEN ���������������������.���������ID = '    LB   '
		THEN '@0000000000000010'
		WHEN ���������������������.���������ID = '   5ZQ   '
		THEN '@0000000000000018'
		WHEN ���������������������.���������ID = '    LA   '
		THEN '@0000000000000020'
		ELSE '@0000000000000001'
	END,
���������������������.���������ID

