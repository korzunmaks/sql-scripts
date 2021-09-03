USE [RIASSE]
GO

/****** Object:  View [dbo].[Бух_Документ_ОтчетКассовойСмены]    Script Date: 11.02.2019 13:45:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[Бух_Документ_ОтчетКассовойСмены] as 
select j.date_time_iddoc date_time_iddoc
,j.iddoc iddoc
,j.sp6452 IDD
,j.docno НомерДок
,dbo.getDateTimeFromJourn(j.date_time_iddoc) ДатаДок
,j.closed closed
,j.sp1005 ФирмаID
,СпрФ.sp6368 ФирмаIDD
,j.sp1006 АвторID
,СпрП.sp6356 АвторIDD
,Док.sp3852 Комментарий
,j.sp1151 ТипУчета
,j.sp2653 ФинУчет
,Док.sp1008 Основание
,j.ismark ismark
--Генирируем поля хеш-идентификаторы для удобного доступа при синхронизации данных с бухгалтерией
,LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', СпрФ.sp6368+Спр_Шапка_Склад.SP6352),1), 18, 32))) AS ХешСкладаIDD
,LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', СпрФ.sp6368+СпрПодр.SP6355),1), 18, 32))) AS ХешПодразделенияIDD
--Далее стандартный код обработки гениратора view-представлений MsSQL
, Док.sp9111 as АннулированныхВозвратов
, Док.sp9110 as АннулированныхПродаж
, Док.sp10345 as БезналНДС10
, Док.sp10344 as БезналНДС18
, Док.sp10337 as БезналСумма
, Док.sp10343 as БезналСумма0
, Док.sp10342 as БезналСумма10
, Док.sp10341 as БезналСумма18
, Док.sp3489 ВалютаID
, Спр_Шапка_Валюта.sp6339 ВалютаIDD
, Док.sp8777 as ВремяВыручки
, Док.sp9112 as Выручка
, Док.sp3490 as Дата_курса
, Док.sp8776 as ДатаВыручки
, Док.sp3495 ККМID
, Спр_Шапка_ККМ.sp6348 ККМIDD
, Док.sp6308 КлиентID
, Спр_Шапка_Клиент.sp6351 КлиентIDD
, Док.sp3491 as Курс
, Док.sp9103 as НеобнулСуммаКон
, Док.sp9102 as НеобнулСуммаНач
, Док.sp5809 as НеУчитыватьНДС
, Док.sp8575 as НомерСмены
, Док.sp10338 as СертификатСумма
, Док.sp3488 СкладID
, Спр_Шапка_Склад.sp6352 СкладIDD
, Док.sp9109 as СуммаВозвратовБезнал
, Док.sp9108 as СуммаВозвратовНал
, Док.sp10871 as СуммаКопилка0
, Док.sp10872 as СуммаКопилка10
, Док.sp10873 as СуммаКопилка18
, Док.sp9106 as СуммаПродажБезнал
, Док.sp9105 as СуммаПродажНал
, Док.sp10874 as СуммаСертификат0
, Док.sp10875 as СуммаСертификат10
, Док.sp10876 as СуммаСертификат18
, Док.sp9107 as ЧековВозвратов
, Док.sp9104 as ЧековПродаж
, Док.sp10887 as НДСКопилка10
, Док.sp10888 as НДСКопилка18
, Док.sp10893 as СуммаПродажКопилка
, Док.sp10894 as СуммаПродажСертификат
, Док.sp12527 as СертификатНДС18
, Док.sp12528 as СертификатНДС10
, Док.sp3504 as Сумма
, Док.sp3505 as НДС
 from _1sjourn j with (nolock)
	left join sc13 СпрФ on (СпрФ.id = j.sp1005)
	left join sc838 СпрП on (СпрП.id = j.sp1006)
	inner join dh3487 Док with (nolock) on (Док.iddoc = j.iddoc)
	left join sc89  Спр_Шапка_Валюта with (nolock) on (Спр_Шапка_Валюта.id = Док.sp3489)
	left join sc3509  Спр_Шапка_ККМ with (nolock) on (Спр_Шапка_ККМ.id = Док.sp3495)
	left join sc46  Спр_Шапка_Клиент with (nolock) on (Спр_Шапка_Клиент.id = Док.sp6308)
	left join sc31  Спр_Шапка_Склад with (nolock) on (Спр_Шапка_Склад.id = Док.sp3488)
	left join SC6115 СпрПодр with (nolock) on (Спр_Шапка_Склад.parentext = СпрПодр.ID)

where j.iddocdef = 3487
GO


