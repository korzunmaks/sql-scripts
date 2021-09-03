SET NOCOUNT ON

SELECT
	КорректировкаПоступления.date_time_iddoc,
	КорректировкаПоступления.iddoc,
	КорректировкаПоступления.IDD,
	КорректировкаПоступления.НомерДок,
	КорректировкаПоступления.ДатаДок,
	КорректировкаПоступления.closed,
	КорректировкаПоступления.ismark,
	ПриходнаяНакладная.ВидПоступленияТабл, 
	КорректировкаПоступления.ФирмаIDD,
	КорректировкаПоступления.АвторIDD,
	КорректировкаПоступления.Комментарий,
	КорректировкаПоступления.Основание,
	КорректировкаПоступления.ДокументОснованиеIDD,
	КорректировкаПоступления.КлиентIDD,
	КорректировкаПоступления.ВхНомерКорСЧФ,
	КорректировкаПоступления.ВхДатаКоррСЧФ,
	КорректировкаПоступления.ДатаДокВходящий,
    КорректировкаПоступления.НомерДокВходящий,
	КорректировкаПоступления.СкладIDD,
	КорректировкаПоступления.ДоговорIDD,
	КорректировкаПоступления.СуммаНДСУвеличение,
	КорректировкаПоступления.СуммаНДСУменьшение,
	КорректировкаПоступления.ЗачитыватьОплатуПоСлужДоговору,
	КорректировкаПоступления.Сумма,
	КорректировкаПоступления.ВалютаIDD,
	КорректировкаПоступления.УПД,
	КорректировкаПоступления.ДатаДокВходящий,
	КорректировкаПоступления.НомерДокВходящий,
	КорректировкаПоступления.колвоСтар,
	КорректировкаПоступления.колвоНов,
	КорректировкаПоступления.СуммаНДС,
	КорректировкаПоступления.СуммаНДСновая,
	КорректировкаПоступления.СуммаБезНДС,
	КорректировкаПоступления.СуммаБезНДСновая,
	КорректировкаПоступления.СуммаСНДС,
	КорректировкаПоступления.СуммаСНДСновая

FROM 
	Бух_Документ_КорректировочныйСчетФактура AS КорректировкаПоступления
		LEFT JOIN Бух_Документ_ПриходнаяНакладная AS ПриходнаяНакладная
			ON КорректировкаПоступления.ДокументОснованиеIDD = ПриходнаяНакладная.IDD
				
WHERE
	КорректировкаПоступления.date_time_iddoc >= '20180101'  
	AND КорректировкаПоступления.date_time_iddoc <= '20181231z'

ORDER BY
	КорректировкаПоступления.date_time_iddoc 