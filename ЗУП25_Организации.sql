 SELECT 
	_InfoRg6621_IR2._Period AS _Период, 
	_InfoRg6621_IR2._Fld6622RRef AS _ФизЛицо, 
	_InfoRg6621_IR2._Fld6623RRef AS _ДокументВид,
	_VidDoc._Description AS _ДокументВидТекст,
	_InfoRg6621_IR2._Fld6624 AS _ДокументСерия, 
	_InfoRg6621_IR2._Fld6625 AS _ДокументНомер,
	CASE 
		WHEN _InfoRg6621_IR2._Fld6626 >= '3753-01-01' THEN DATEADD(yyyy,-2000,_InfoRg6621_IR2._Fld6626) 
		ELSE _InfoRg6621_IR2._Fld6626
	END AS _ДокументДатаВыдачи, 
	_InfoRg6621_IR2._Fld6627 AS _ДокументКемВыдан,
	_InfoRg6621_IR2._Fld6628 AS _ДокументКодПодразделения,
	CASE 
		WHEN _InfoRg6621_IR2._Fld6629 >= '3753-01-01' THEN DATEADD(yyyy,-2000,_InfoRg6621_IR2._Fld6629)
		ELSE _InfoRg6621_IR2._Fld6629  
	END AS _ДатаРегистрацииПоМестуЖительства 
	INTO #PasportnieDannie
	FROM 
		( 
		 SELECT 
		 _InfoRg6621._Fld6622RRef AS __Fld6622RRef, 
		 MAX(_InfoRg6621._Period) AS _MAXPERIOD 
		 FROM 
		    [zup].[dbo]._InfoRg6621 WITH(NOLOCK)
		 GROUP BY
		    _InfoRg6621._Fld6622RRef
		) #V8TblAli1_IR1 
		INNER JOIN [zup].[dbo]._InfoRg6621 _InfoRg6621_IR2 WITH(NOLOCK) 
		    ON #V8TblAli1_IR1.__Fld6622RRef = _InfoRg6621_IR2._Fld6622RRef 
		       AND #V8TblAli1_IR1._MAXPERIOD = _InfoRg6621_IR2._Period
		INNER JOIN [zup].[dbo]._Reference48 _VidDoc WITH(NOLOCK) 
			ON _InfoRg6621_IR2._Fld6623RRef = _VidDoc._IDRRef SELECT
	ОрганизацииЗУП._Marked AS ПометкаУдаления,
	ОрганизацииЗУП._IsMetadata AS Предопределенный,
	ОрганизацииЗУП._Code AS Код,
	ОрганизацииЗУП._Description AS Наименование,
	ОрганизацииЗУП._Fld1285 AS Префикс,
	ОрганизацииЗУП._Fld1286 AS ИНН,
	ОрганизацииЗУП._Fld1287 AS КПП,
	ОрганизацииЗУП._Fld1288 AS РегистрационныйНомерПФР,
	ОрганизацииЗУП._Fld1289RRef AS ГоловнаяОрганизация,
	ОрганизацииЗУП._Fld1290 AS НаименованиеПолное,
	ОрганизацииЗУП._Fld1291 AS КодПоОКПО,
	ОрганизацииЗУП._Fld1292 AS КодПоОКАТО,
	ОрганизацииЗУП._Fld1293 AS КодИМНС,
	ОрганизацииЗУП._Fld1294 AS РайонныйКоэффициент,
	CASE ПеречислениеЮрФизЛицо._IDRRef
         WHEN 0x8D7CC8BF1CFD20504AB6773D7ACE16A3 THEN 'ЮридическоеЛицо'
         WHEN 0xB4B7E024A2188C8E4860DD97453323F4 THEN 'ФизическоеЛицо'
    END AS ЮрФизЛицо, 
	ОрганизацииЗУП._Fld1296RRef AS ТерриториальныеУсловияПФР,
	ОрганизацииЗУП._Fld1297RRef AS ОсновнойБанковскийСчет,
	ОрганизацииЗУП._Fld1298RRef AS ВидСтавокЕСНиПФР,
	ОрганизацииЗУП._Fld1299 AS ИностраннаяОрганизация,
	ОрганизацииЗУП._Fld1300 AS КодОКОПФ,
	ОрганизацииЗУП._Fld1301 AS НаименованиеОКОПФ,
	ОрганизацииЗУП._Fld1302 AS КодОКФС,
	ОрганизацииЗУП._Fld1303 AS НаименованиеОКФС,
	ОрганизацииЗУП._Fld1304RRef AS СтранаРегистрации,
	ОрганизацииЗУП._Fld1305RRef AS СтранаПостоянногоМестонахождения,
	ОрганизацииЗУП._Fld1306 AS КодВСтранеРегистрации,
	ОрганизацииЗУП._Fld1307 AS ОГРН,
	ОрганизацииЗУП._Fld1308 AS НаименованиеИнострОрганизации,
	ОрганизацииЗУП._Fld1309 AS РегистрационныйНомерФСС,
	ОрганизацииЗУП._Fld1310 AS НаименованиеИМНС,
	ОрганизацииЗУП._Fld1311 AS КодОКВЭД,
	ОрганизацииЗУП._Fld1312 AS НаименованиеОКВЭД,
	ОрганизацииЗУП._Fld1313 AS КодОКОНХ,
	ОрганизацииЗУП._Fld1314RRef AS ИндивидуальныйПредприниматель,
	Pasport._ДокументНомер AS НомерПаспорта,
	Pasport._ДокументСерия AS НомерПаспорта,	
	ОрганизацииЗУП._Fld1316 AS ОбменКодАбонента,
	ОрганизацииЗУП._Fld1317 AS ОбменКаталогОтправкиДанныхОтчетности,
	ОрганизацииЗУП._Fld1318 AS ОбменКаталогПрограммыЭлектроннойПочты,
	ОрганизацииЗУП._Fld1319 AS РайонныйКоэффициентРФ,
	ОрганизацииЗУП._Fld1320 AS КодИФНСПолучателя,
	ОрганизацииЗУП._Fld1321 AS НаименованиеТерриториальногоОрганаПФР,
	ОрганизацииЗУП._Fld1322 AS НаименованиеСокращенное,
	ОрганизацииЗУП._Fld1324RRef AS ВидОбменаСКонтролирующимиОрганами,
	ОрганизацииЗУП._Fld1325RRef AS УчетнаяЗаписьОбмена,
	ОрганизацииЗУП._Fld1327 AS КодОрганаПФР,
	ОрганизацииЗУП._Fld9503 AS КодОрганаФСГС,
	ОрганизацииЗУП._Fld8263 AS ДополнительныйКодФСС,
	ОрганизацииЗУП._Fld8264 AS КодПодчиненностиФСС,
	ОрганизацииЗУП._Fld8265 AS НаименованиеТерриториальногоОрганаФСС,
	ОрганизацииЗУП._Fld10115 AS КодПоОКТМО,
	ОрганизацииЗУП._Fld11321 AS КодОКВЭД2,
	ОрганизацииЗУП._Fld11322 AS НаименованиеОКВЭД2

 FROM _Reference79 AS ОрганизацииЗУП
	LEFT JOIN _Enum420 AS ПеречислениеЮрФизЛицо on ОрганизацииЗУП._Fld1295RRef = ПеречислениеЮрФизЛицо._IDRRef 
 	LEFT JOIN #PasportnieDannie AS Pasport ON ОрганизацииЗУП._Fld1314RRef = Pasport._ФизЛицо
 		
 where _Fld1286 = '2460019847'

DROP TABLE #PasportnieDannie