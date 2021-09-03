--Поиск свободного кода справочника сотрудники
USE RIASSE

SELECT 
	IsNull(Min(T1.Код), 0) + 1 
FROM 
	[dbo].[Бух_Справочник_Сотрудники] T1 (NoLock) 
	Left Join [dbo].[Бух_Справочник_Сотрудники] T2 (NoLock)
		On (T1.Код + 1) = T2.Код 
WHERE 
	T2.Код Is NULL	
	