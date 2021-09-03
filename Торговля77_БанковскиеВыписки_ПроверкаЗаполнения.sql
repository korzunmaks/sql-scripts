
SET NOCOUNT ON

SELECT
    ШапкаВыписки.date_time_iddoc,
    ШапкаВыписки.IDD,
    СтрокиВыписки.НомерСтроки AS НомерСтроки,
    ШапкаВыписки.НомерДок,
    ШапкаВыписки.ДатаДок,
    ШапкаВыписки.closed,
    ШапкаВыписки.ФирмаIDD,
    ШапкаВыписки.АвторIDD,
    ШапкаВыписки.РасчетныйСчетIDD,
    СтрокиВыписки.Приход,
    СтрокиВыписки.Расход,
    СтрокиВыписки.НомерПлатДок,
    СтрокиВыписки.ДатаПлатДокум,
    СтрокиВыписки.Содержание,
    СтрокиВыписки.КлиентIDD,
    СтрокиВыписки.ДоговорIDD,
    СтрокиВыписки.СтавкаНДСID,
    СтрокиВыписки.ДокументОснованиеID13,
    СтрокиВыписки.ДокументОснованиеIDD,
    СтрокиВыписки.ВидОплаты_Идентификатор AS ВидыОплаты,
    ПланСчетов.Код AS КоррСчетКод,
    Справочники1.Идентификатор AS Субконто1_Идентификатор,
    СтрокиВыписки.Субконто1_IDD

FROM Бух_Документ_ДвиженияДенежныхСредств AS ШапкаВыписки
    LEFT JOIN
    Бух_ДокументСтроки_ДвиженияДенежныхСредств AS СтрокиВыписки
    ON СтрокиВыписки.iddoc = ШапкаВыписки.iddoc
    LEFT JOIN
    Перечисление_ВидыОплаты
    ON СтрокиВыписки.ВидОплатыID = Перечисление_ВидыОплаты.ID
    LEFT JOIN
    Бух_Справочник_ПланСчетов AS ПланСчетов
    ON СтрокиВыписки.КоррСчетID = ПланСчетов.ID
    LEFT JOIN
    Справочники AS Справочники1
    ON СтрокиВыписки.Субконто1_Вид = Справочники1.ID

WHERE (ШапкаВыписки.closed = 1)
    AND date_time_iddoc >='20170101' AND date_time_iddoc <='20171231'
    AND (СтрокиВыписки.ДоговорIDD = '' OR СтрокиВыписки.ДоговорIDD IS NULL)


ORDER BY  
	ШапкаВыписки.date_time_iddoc,
	ШапкаВыписки.НомерДок, 
	КоррСчетКод
