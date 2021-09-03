
SET NOCOUNT ON

SELECT
	LTRIM(RTRIM(ДокументСтроки_РозничнаяВыручка.ВидОплаты)) AS ВидОплаты,
	LTRIM(RTRIM(ДокументСтроки_РозничнаяВыручка.ВидОтгрузки)) AS ВидОтгрузки,
	SUM(ДокументСтроки_РозничнаяВыручка.Сумма) AS Сумма

FROM dbo.Бух_ДокументСтроки_РозничнаяВыручка AS ДокументСтроки_РозничнаяВыручка

WHERE
	ДокументСтроки_РозничнаяВыручка.iddoc = ' 62D5E   '
GROUP BY
	ВидОплаты,
	ВидОтгрузки
ORDER BY
	ВидОплаты,
	ВидОтгрузки 
