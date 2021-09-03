SET NOCOUNT ON

SELECT
	МестаХранения.IDD AS ИДД_Склад,
	ПодразделенияТорговли.ID,
	ПодразделенияТорговли.IDD,
	ПодразделенияТорговли.ismark AS ПометкаУдаления,
	ПодразделенияТорговли.Код AS Код,
	ПодразделенияТорговли.Наименование AS Наименование,
	ПодразделенияТорговли.ЭтоГруппа,
	ПодразделенияТорговли.РодительID,
	ПодразделенияТорговли.РодительIDD,
	ПодразделенияТорговли.Адрес,
	ПодразделенияТорговли.ОсновнаяФирмаРозницыID,
	ПодразделенияТорговли.ОсновнаяФирмаРозницыIDD,
	ПодразделенияТорговли.ПрефиксДокументов AS Префикс,
	ПодразделенияТорговли.КППОбособленный AS КПП,
	ФирмыРозницы.Наименование AS ФирмаРозницы,
	ФирмыРозницы.ИНН

FROM
	Бух_Справочник_Подразделения AS ПодразделенияТорговли
	LEFT JOIN Бух_Справочник_МестаХранения AS МестаХранения
	ON ПодразделенияТорговли.ID = МестаХранения.ВладелецID
	LEFT JOIN Бух_Справочник_Фирмы AS ФирмыРозницы
	ON ПодразделенияТорговли.ОсновнаяФирмаРозницыID = ФирмыРозницы.ID

--WHERE
--	[ПодразделенияIDD]
--	[СкладIDD]
ORDER BY
	ПодразделенияТорговли.Наименование