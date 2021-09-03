
SET NOCOUNT ON

SELECT distinct
	ColorTables.ТипыРаскрасокТоваровIDD
	,ColorTables.ТипМагазина
	,ColorTables.Приоритет
	,ColorTables.Цвет
	,CASE
		WHEN ColorTables.Цвет = 255 THEN 'Каталог Эльсити, Красный'
		WHEN ColorTables.Цвет = 8421631 THEN 'Каталог Эльсити (начало), Розовый'
		WHEN ColorTables.Цвет = 183 THEN 'Каталог Эльсити (конец), Бордовый'
		WHEN ColorTables.Цвет = 65535 THEN 'Желтый ценник, Желтый'
		WHEN ColorTables.Цвет = 13303807 THEN 'Желтый ценник, (начало), Бледно желтый' 
		WHEN ColorTables.Цвет = 52942 THEN 'Желтый ценник (конец), Темно желтый' 
		WHEN ColorTables.Цвет = 16744448 THEN 'Спец цена по копилке, Синий'
		WHEN ColorTables.Цвет = 16763025 THEN 'Спец цена по копилке (начало), Бледно синий' 
		WHEN ColorTables.Цвет = 16711680 THEN 'Спец цена по копилке (конец), Темно синий'
		WHEN ColorTables.Цвет = 65280 THEN 'Новинки, Зеленый'
		WHEN ColorTables.Цвет = 12632256 THEN 'Вывод из ассортимента (старый товар), чччч'
		WHEN ColorTables.Цвет = 16776960 THEN 'Акция ограничения по копилке, чччч'
		WHEN ColorTables.Цвет = 33023 THEN 'ТПЦ, Светло коричневый'
		WHEN ColorTables.Цвет = 4227200 THEN 'чччччччч, чччч'
		ELSE
			''
	END AS Коментарий
	 
FROM 
	[dbo].[ColorColumnTables1] AS ColorTables
ORDER BY
	ColorTables.ТипыРаскрасокТоваровIDD
	,ColorTables.Приоритет