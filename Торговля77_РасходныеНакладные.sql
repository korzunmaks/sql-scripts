
SET NOCOUNT ON

IF OBJECT_ID(N'tempdb..#РасходныеНакладные', N'U') IS NOT NULL 
DROP TABLE #РасходныеНакладные

SELECT
	CAST(Бух_Документ_РасходнаяНакладная.closed AS INT) AS closed
	, CAST(Бух_Документ_РасходнаяНакладная.ismark AS INT) AS ismark
	, Бух_Документ_РасходнаяНакладная.iddoc AS iddoc
	, 'O1'+'  BE'+Бух_Документ_РасходнаяНакладная.iddoc AS ИдентификаторРодителя 
	, Бух_Документ_РасходнаяНакладная.IDD AS IDD
	, Бух_Документ_РасходнаяНакладная.НомерДок AS НомерДок
	, Бух_Документ_РасходнаяНакладная.ДатаДок AS ДатаДок
	, Бух_Документ_РасходнаяНакладная.ПризнакНакладной_Идентификатор AS ПризнакНакладной
	, Бух_Документ_РасходнаяНакладная.ФирмаIDD AS ФирмаIDD
	, Бух_Документ_РасходнаяНакладная.ВидРасходаТабл AS ВидРасходаТабл
	, Бух_Документ_РасходнаяНакладная.ДоговорIDD AS ДоговорIDD
	, Бух_Документ_РасходнаяНакладная.КлиентIDD AS КлиентIDD
	, Бух_Документ_РасходнаяНакладная.Комментарий AS Комментарий
	, Бух_Документ_РасходнаяНакладная.СкладIDD AS СкладIDD
	, LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', Бух_Документ_РасходнаяНакладная.ФирмаIDD+Бух_Документ_РасходнаяНакладная.СкладIDD),1), 18, 32))) AS ХешСкладаIDD 
	, LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', Бух_Документ_РасходнаяНакладная.ФирмаIDD+ПодразделенияТорговли.IDD),1), 18, 32))) AS ХешПодразделенияIDD
	, Бух_Документ_РасходнаяНакладная.Сумма AS СуммаДокумента
INTO #РасходныеНакладные
FROM
	dbo.Бух_Документ_РасходнаяНакладная AS Бух_Документ_РасходнаяНакладная with (forceseek)
	LEFT JOIN Бух_Справочник_МестаХранения AS МестаХранения with (forceseek)
	ON (Бух_Документ_РасходнаяНакладная.СкладID = МестаХранения.ID)
	LEFT JOIN Бух_Справочник_Подразделения AS ПодразделенияТорговли with (forceseek)
	ON МестаХранения.ВладелецID = ПодразделенияТорговли.ID
WHERE
	Бух_Документ_РасходнаяНакладная.date_time_iddoc >= '20190401' AND Бух_Документ_РасходнаяНакладная.date_time_iddoc <= '20190701z'
	AND Бух_Документ_РасходнаяНакладная.ФирмаIDD IN ('10015480544879301')
	AND (Бух_Документ_РасходнаяНакладная.closed <> 0
	OR Бух_Документ_РасходнаяНакладная.ismark <> 0
		)
	AND Бух_Документ_РасходнаяНакладная.ВидРасходаТабл <> 3 --Тара
	AND Бух_Документ_РасходнаяНакладная.ВидРасходаТабл <> 4 --Бонус
	AND Бух_Документ_РасходнаяНакладная.ВидРасходаТабл <> 9 --Только остатки
	AND Бух_Документ_РасходнаяНакладная.ВидРасходаТабл <> 10 --Товары интернет магазина
	AND Бух_Документ_РасходнаяНакладная.IDD <> ''

CREATE INDEX ИдентификаторРодителяИндекс ON #РасходныеНакладные (ИдентификаторРодителя)

SELECT
	РасходныеНакладные.*
	, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураIDD, '') AS СчетФактураIDD 
	, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураНомер, '') AS СчетФактураНомер 
	, ISNULL(ВыданныеСчетфактурыIDD.СчетФактураДата, '') AS СчетФактураДата
FROM
	#РасходныеНакладные AS РасходныеНакладные
	OUTER APPLY
		(SELECT TOP (1)
		ВыданныеСчетфактуры.IDD AS СчетФактураIDD
			, ВыданныеСчетфактуры.НомерДок AS СчетФактураНомер
			, ВыданныеСчетфактуры.ДатаДок AS СчетФактураДата
			, CAST(ВыданныеСчетфактуры.closed AS INT) AS СчетФактураClosed
			, CAST(ВыданныеСчетфактуры.ismark AS INT) AS СчетФактураIsmark
			, CASE 
				WHEN CAST(ВыданныеСчетфактуры.closed AS INT) = 0
			AND CAST(ВыданныеСчетфактуры.ismark AS INT) = 0 
				THEN CAST(1 AS INT) 
				ELSE CAST(0 AS INT)  
			END AS СчетФактураOnlySaved
			, ВыданныеСчетфактуры.Сумма AS СчетФактураСуммаДокумента
			, ВыданныеСчетфактуры.Комментарий AS СчетФактураКомментарий
	FROM
		_1SCRDOC As ТаблицаПодчиненности with (forceseek)
		LEFT JOIN dbo.Бух_Документ_Счет_фактура AS ВыданныеСчетфактуры with (forceseek)
		ON ТаблицаПодчиненности.CHILDID = ВыданныеСчетфактуры.iddoc
	WHERE
			ТаблицаПодчиненности.MDID = 0 -- только документы, без граф отбора
		AND ТаблицаПодчиненности.PARENTVAL = РасходныеНакладные.ИдентификаторРодителя
	--AND ВыданныеСчетфактуры.CLOSED &1=1 -- Проведенность нет смысла проверять здесь, контроль будет в отчете 
	ORDER BY 
			ТаблицаПодчиненности.CHILD_DATE_TIME_IDDOC desc
		) AS ВыданныеСчетфактурыIDD
ORDER BY 
	РасходныеНакладные.ДатаДок,
	РасходныеНакладные.НомерДок	
