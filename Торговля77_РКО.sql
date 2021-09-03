SELECT 
         КассовыйДокумент.IDD AS IDD,
         КассовыйДокумент.НомерДок AS Номер,
         КассовыйДокумент.ДатаДок AS Дата,
         КассовыйДокумент.closed AS ПометкаУдаления,
         КассовыйДокумент.Комментарий AS Комментарий,
         КассовыйДокумент.Сумма AS СуммаДокумента,
         КассовыйДокумент.СтавкаНДСID AS СтавкаНДС,
         КассовыйДокумент.ФирмаIDD AS ФирмаIDD,
         КассовыйДокумент.ПодразделениеIDD AS ПодразделениеIDD,
         КассовыйДокумент.КодОперацииID AS ВидОперации,
         КассовыйДокумент.КодОперации_Идентификатор,
         Бух_Справочник_ПланСчетов.Код AS КоррСчетКод,
         КассовыйДокумент.Субконто1_IDD,
         Справочники1.Идентификатор AS Субконто1_Идентификатор,
         КассовыйДокумент.Субконто2_IDD,
         Справочники2.Идентификатор AS Субконто2_Идентификатор,
         КассовыйДокумент.Субконто3_IDD,
         Справочники3.Идентификатор AS Субконто3_Идентификатор,
         КассовыйДокумент.Основание,
         КассовыйДокумент.ДоговорIDD,
         КассовыйДокумент.ДокументОснованиеID13,
         КассовыйДокумент.ДокументОснованиеIDD,
         КассовыйДокумент.Приложение,
         КассовыйДокумент.Выдать AS Выдать,
         КассовыйДокумент.РежимОплатыID,
         КассовыйДокумент.РежимОплаты_Идентификатор,
         КассовыйДокумент.ТипУчета,
         КассовыйДокумент.ФинУчет
         
FROM Бух_Документ_РасходныйОрдерТБ AS КассовыйДокумент 
LEFT JOIN
    Бух_Справочник_ПланСчетов
        ON КассовыйДокумент.КоррСчетID = Бух_Справочник_ПланСчетов.ID 
LEFT JOIN 
    Справочники AS Справочники1
    ON КассовыйДокумент.Субконто1_Вид = Справочники1.ID 
LEFT JOIN
    Справочники AS Справочники2
    ON КассовыйДокумент.Субконто2_Вид = Справочники2.ID 
LEFT JOIN Справочники AS Справочники3
    ON КассовыйДокумент.Субконто3_Вид = Справочники3.ID

WHERE (КассовыйДокумент.date_time_iddoc >= '20180101')
        AND (КассовыйДокумент.date_time_iddoc <= '20180331')
  --      AND CLOSED = 1
  --      --AND КассовыйДокумент.КодОперацииID <> '   61X   ' --Исключили розничную выручку, для ник ПКО сформируем по отчету розничных продаж
		--AND ФирмаIDD <> '10015480680368847'  -- ИП Подпорина Н.А.
		--AND ФирмаIDD <> '10015480748078260'  -- ИП Лобанова Е.В.
		--AND ФирмаIDD <> '10015480626553528'  -- ООО М-Актив
		--AND ФирмаIDD = '10015480660657321'
		--AND Бух_Справочник_ПланСчетов.Код = '62.1    '
		AND КассовыйДокумент.НомерДок = 'СМРкоЦ01-000059'
ORDER BY
	КассовыйДокумент.ФирмаIDD,
	КассовыйДокумент.date_time_iddoc
