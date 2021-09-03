SELECT
	РегистрДополнительныеСведения._Fld20896_S,
	РегистрДополнительныеСведения._Fld20894_RTRef
FROM
	buhcorp.dbo._InfoRg20893 AS РегистрДополнительныеСведения

WHERE
	РегистрДополнительныеСведения._Fld20894_RTRef
IN (
	0x000001B2, -- документ ОперацияБух (Операция)
	0x000001C4, -- документ ОтчетОРозничныхПродажах (Отчет о розничных продажах)
	0x000001EC, -- документ ПоступлениеНаРасчетныйСчет (Поступление на расчетный счет)
	0x00000210, -- документ СписаниеСРасчетногоСчета (Списание с расчетного счета) 
	0x000001EE, -- документ ПоступлениеТоваровУслуг (Поступление (акты, накладные))
	0x000001F4, -- документ ПриходныйКассовыйОрдер (Поступление наличных)
	0x000001F6, -- документ РасходныйКассовыйОрдер (Выдача наличных)
	0x000001F9, -- документ РеализацияТоваровУслуг (Реализация (акты, накладные))
	0x00000218, -- документ СчетФактураВыданный (Счет-фактура выданный)
	0x00000219  -- документ СчетФактураПолученный (Счет-фактура полученный)
	)
