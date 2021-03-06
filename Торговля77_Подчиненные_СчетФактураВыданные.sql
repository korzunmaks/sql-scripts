USE RIASSE

SET NOCOUNT ON

SELECT
    ПолученныеСчетфактуры.IDD
	, ПолученныеСчетфактуры.ДатаДок
	, ПолученныеСчетфактуры.НомерДок
	, ПолученныеСчетфактуры.НомерСчетаФактуры
	, ОбщийЖурнал.*
FROM
    _1SCRDOC As ТаблицаПодчиненности
	INNER JOIN _1SJOURN As ОбщийЖурнал 
		ON (ТаблицаПодчиненности.CHILDID = ОбщийЖурнал.IDDOC)
	INNER JOIN dbo.Бух_Документ_РегистрацияСчета_фактуры AS ПолученныеСчетфактуры
		ON ОбщийЖурнал.IDDOC = ПолученныеСчетфактуры.iddoc
WHERE
    ТаблицаПодчиненности.MDID = 0 -- только документы, без граф отбора
    AND ТаблицаПодчиненности.PARENTVAL IN (SELECT
												'O1'+'  C2'+Бух_Документ_ПриходнаяНакладная.iddoc
											FROM dbo.Бух_Документ_ПриходнаяНакладная AS Бух_Документ_ПриходнаяНакладная
											WHERE
												Бух_Документ_ПриходнаяНакладная.date_time_iddoc >='20190701'
												AND Бух_Документ_ПриходнаяНакладная.date_time_iddoc <='20190701z'
												AND (Бух_Документ_ПриходнаяНакладная.ВидПоступленияТабл <> '12'	  --Товары Инт.магазина
													AND Бух_Документ_ПриходнаяНакладная.ВидПоступленияТабл <> '6' --Бонус
													AND Бух_Документ_ПриходнаяНакладная.ВидПоступленияТабл <> '7' --Минусовой сч-фак
													AND Бух_Документ_ПриходнаяНакладная.ВидПоступленияТабл <> '9' --Только остатки
													)
												AND (Бух_Документ_ПриходнаяНакладная.closed <> 0
													OR Бух_Документ_ПриходнаяНакладная.ismark <> 0
													)
												AND Бух_Документ_ПриходнаяНакладная.IDD <> ''
											)
	AND ОбщийЖурнал.CLOSED &1=1
ORDER BY
    ТаблицаПодчиненности.CHILD_DATE_TIME_IDDOC