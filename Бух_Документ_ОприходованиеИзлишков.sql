USE RIASSE

SET NOCOUNT ON

SELECT
	CAST(Бух_Документ_ОприходованиеИзлишков.closed AS INT) AS closed,
	CAST(Бух_Документ_ОприходованиеИзлишков.ismark AS INT) AS ismark,
	Бух_Документ_ОприходованиеИзлишков.iddoc AS iddoc,
	Бух_Документ_ОприходованиеИзлишков.IDD AS IDD,
	Бух_Документ_ОприходованиеИзлишков.НомерДок AS НомерДок,
	Бух_Документ_ОприходованиеИзлишков.ДатаДок AS ДатаДок,
    Бух_Документ_ОприходованиеИзлишков.ФирмаIDD AS ФирмаIDD,
    Бух_Документ_ОприходованиеИзлишков.СкладIDD AS СкладIDD,
	LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', Бух_Документ_ОприходованиеИзлишков.ФирмаIDD+Бух_Документ_ОприходованиеИзлишков.СкладIDD),1), 18, 32))) AS ХешСкладаIDD, 
	LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', Бух_Документ_ОприходованиеИзлишков.ФирмаIDD+ПодразделенияТорговли.IDD),1), 18, 32))) AS ХешПодразделенияIDD, 
	0 AS СуммаДокумента, 
	Бух_Документ_ОприходованиеИзлишков.Комментарий AS Комментарий

FROM 
	dbo.Бух_Документ_ОприходованиеИзлишков AS Бух_Документ_ОприходованиеИзлишков
	LEFT JOIN Бух_Справочник_МестаХранения AS МестаХранения with (forceseek)
		ON (Бух_Документ_ОприходованиеИзлишков.СкладID = МестаХранения.ID)
	LEFT JOIN Бух_Справочник_Подразделения AS ПодразделенияТорговли with (forceseek)
		ON МестаХранения.ВладелецID = ПодразделенияТорговли.ID
WHERE
	Бух_Документ_ОприходованиеИзлишков.date_time_iddoc >= '20180101'
	AND Бух_Документ_ОприходованиеИзлишков.date_time_iddoc <= '20180131z'
	AND LEFT(Бух_Документ_ОприходованиеИзлишков.ДокументОснованиеID13, 4) = ' 2RG' --Значит документ введен на основании инвентарицзации
	--AND Бух_Документ_ОприходованиеИзлишков.НомерДок = '*****'
	AND Бух_Документ_ОприходованиеИзлишков.ФирмаIDD IN ('10015480660352695')