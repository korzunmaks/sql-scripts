--����� ���������� ���� ����������� ����������
USE RIASSE

SELECT 
	IsNull(Min(T1.���), 0) + 1 
FROM 
	[dbo].[���_����������_����������] T1 (NoLock) 
	Left Join [dbo].[���_����������_����������] T2 (NoLock)
		On (T1.��� + 1) = T2.��� 
WHERE 
	T2.��� Is NULL	
	