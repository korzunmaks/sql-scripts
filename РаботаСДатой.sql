USE RIASSE

SET NOCOUNT ON

SELECT
SP9256
, SP9259 AS ГоденДо
, GETDATE() AS ТекущаяДата
, DATEADD(year, 3, GETDATE()) AS ДатаПлюс
, DATEADD(year, 3, SP9259) AS ДатаПлюс1
FROM
    SC9263 AS спрПодарочныеСертификаты

WHERE
    спрПодарочныеСертификаты.SP9256 = '2998000000039'

