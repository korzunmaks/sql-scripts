USE RIASSE

SET NOCOUNT ON

IF OBJECT_ID(N'tempdb..#ПриходныеНакладные', N'U') IS NOT NULL 
DROP TABLE #ПриходныеНакладные

IF OBJECT_ID(N'tempdb..#ПриходныеНакладныеИСчетфактура', N'U') IS NOT NULL 
DROP TABLE #ПриходныеНакладныеИСчетфактура

SELECT
	'Приходная накладная' AS ТипДокументов,
	Бух_Документ_ПриходнаяНакладная.ФирмаIDD AS ФирмаIDD,
	Бух_Документ_ПриходнаяНакладная.IDD AS IDD,
	Бух_Документ_ПриходнаяНакладная.НомерДок AS НомерДок,
	Бух_Документ_ПриходнаяНакладная.ДатаДок AS ДатаДок,
	CAST(Бух_Документ_ПриходнаяНакладная.closed AS INT) AS closed,
	CAST(Бух_Документ_ПриходнаяНакладная.ismark AS INT) AS ismark,
	'O1'+'  C2'+Бух_Документ_ПриходнаяНакладная.iddoc AS ИдентификаторРодителя,
	CASE 
	    WHEN CAST(Бух_Документ_ПриходнаяНакладная.closed AS INT) = 0
		AND CAST(Бух_Документ_ПриходнаяНакладная.ismark AS INT) = 0 
		THEN CAST(1 AS INT) 
	ELSE CAST(0 AS INT)  
	END AS OnlySaved,
	Бух_Документ_ПриходнаяНакладная.Сумма AS СуммаДокумента,
	Бух_Документ_ПриходнаяНакладная.НомерСчетаФактуры AS НомерСчетаФактуры,
	Бух_Документ_ПриходнаяНакладная.Комментарий AS Комментарий
INTO #ПриходныеНакладные
FROM
	dbo.Бух_Документ_ПриходнаяНакладная AS Бух_Документ_ПриходнаяНакладная with (forceseek)
	LEFT JOIN Бух_Справочник_МестаХранения AS МестаХранения with (forceseek)
	ON (Бух_Документ_ПриходнаяНакладная.СкладID = МестаХранения.ID)
	LEFT JOIN Бух_Справочник_Подразделения AS ПодразделенияТорговли with (forceseek)
	ON МестаХранения.ВладелецID = ПодразделенияТорговли.ID
WHERE
	Бух_Документ_ПриходнаяНакладная.date_time_iddoc >= '20190401'
	AND Бух_Документ_ПриходнаяНакладная.date_time_iddoc <= '20190430z'
	AND Бух_Документ_ПриходнаяНакладная.ФирмаIDD IN ('99000050003469724','99000050001392908','99000050001392899','99000250000021115','99000050003734229','10015480000092117','10015480001804350','10096050000000004','10015480404750476','10015480537831211','10015480537998437','10015480544879301','40000200000006027','10015480576117910','10015480591479342','10015480657086884','10015480660352695','10015480662483960','10015480662483982','10015480677235543','10015480683097043','10015480690560431','10015480776946477','10015480786651044','10015480825125526','10015480660657321','99000050003129843')
	AND (Бух_Документ_ПриходнаяНакладная.ВидПоступленияТабл <> '12' --Товары Инт.магазина
	AND Бух_Документ_ПриходнаяНакладная.ВидПоступленияТабл <> '6' --Бонус
	AND Бух_Документ_ПриходнаяНакладная.ВидПоступленияТабл <> '7' --Минусовой сч-фак
	AND Бух_Документ_ПриходнаяНакладная.ВидПоступленияТабл <> '9' --Только остатки
	    )
	AND Бух_Документ_ПриходнаяНакладная.IDD <> ''

CREATE INDEX ИдентификаторРодителяИндекс ON #ПриходныеНакладные (ИдентификаторРодителя)

SELECT
	ПриходныеНакладные.*
		, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураIDD, '') AS СчетФактураIDD
		, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураНомер, '') AS СчетФактураНомер
		, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураДата, '') AS СчетФактураДата
		, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураClosed, '') AS СчетФактураClosed
		, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураIsmark, '') AS СчетФактураIsmark
		, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураOnlySaved, '') AS СчетФактураOnlySaved
		, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураСуммаДокумента, 0) AS СчетФактураСуммаДокумента
		, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураКомментарий, '') AS СчетФактураКомментарий
INTO #ПриходныеНакладныеИСчетфактура
FROM
	#ПриходныеНакладные AS ПриходныеНакладные
OUTER APPLY
	(SELECT TOP (1)
		ПолученныеСчетфактуры.IDD AS СчетФактураIDD
		, ПолученныеСчетфактуры.НомерСчетаФактуры AS СчетФактураНомер
		, ПолученныеСчетфактуры.ДатаСчетаФактуры AS СчетФактураДата
		, CAST(ПолученныеСчетфактуры.closed AS INT) AS СчетФактураClosed
		, CAST(ПолученныеСчетфактуры.ismark AS INT) AS СчетФактураIsmark
		, CASE 
			WHEN CAST(ПолученныеСчетфактуры.closed AS INT) = 0
			AND CAST(ПолученныеСчетфактуры.ismark AS INT) = 0 
			THEN CAST(1 AS INT) 
			ELSE CAST(0 AS INT)  
		  END AS СчетФактураOnlySaved
		, ПолученныеСчетфактуры.Сумма AS СчетФактураСуммаДокумента
		, ПолученныеСчетфактуры.Комментарий AS СчетФактураКомментарий
	FROM
		_1SCRDOC As ТаблицаПодчиненности with (forceseek)
		LEFT JOIN dbo.Бух_Документ_РегистрацияСчета_фактуры AS ПолученныеСчетфактуры with (forceseek)
		ON ТаблицаПодчиненности.CHILDID = ПолученныеСчетфактуры.iddoc
	WHERE
		ТаблицаПодчиненности.MDID = 0 -- только документы, без граф отбора
		AND ТаблицаПодчиненности.PARENTVAL = ПриходныеНакладные.ИдентификаторРодителя
		AND ПолученныеСчетфактуры.НомерСчетаФактуры = ПриходныеНакладные.НомерСчетаФактуры
	--AND ВыданныеСчетфактуры.CLOSED &1=1 -- Проведенность нет смысла проверять здесь, контроль будет в отчете 
	ORDER BY 
		ТаблицаПодчиненности.CHILD_DATE_TIME_IDDOC desc
	) AS ВыданныеСчетфактурыIDD

	SELECT
		Приходные.ТипДокументов
	, Приходные.ФирмаIDD
	, Приходные.IDD
	, Приходные.НомерДок
	, Приходные.ДатаДок
	, Приходные.closed
	, Приходные.ismark
	, Приходные.OnlySaved
	, Приходные.СуммаДокумента
	, Приходные.Комментарий
	FROM
		#ПриходныеНакладныеИСчетфактура AS Приходные

UNION ALL

	SELECT
		'СчетФактура полученный' AS ТипДокументов
	, Счетфактуры.ФирмаIDD AS ФирмаIDD
	, Счетфактуры.СчетФактураIDD AS IDD
	, Счетфактуры.СчетФактураНомер AS НомерДок
	, Счетфактуры.СчетФактураДата AS ДатаДок
	, Счетфактуры.СчетФактураclosed AS closed
	, Счетфактуры.СчетФактураismark AS ismark
	, Счетфактуры.СчетФактураOnlySaved AS OnlySaved
	, Счетфактуры.СчетФактураСуммаДокумента AS СуммаДокумента
	, Счетфактуры.СчетФактураКомментарий AS Комментарий
	FROM
		#ПриходныеНакладныеИСчетфактура AS Счетфактуры
	WHERE
	Счетфактуры.СчетФактураIDD <> ''

IF OBJECT_ID(N'tempdb..#ПриходныеНакладные', N'U') IS NOT NULL 
DROP TABLE #ПриходныеНакладные

IF OBJECT_ID(N'tempdb..#ПриходныеНакладныеИСчетфактура', N'U') IS NOT NULL 
DROP TABLE #ПриходныеНакладныеИСчетфактура