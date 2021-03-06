SELECT
  ОстаткиТовара.ФирмаIDD,
  ОстаткиТовара.СкладIDD,
  ПодразделенияТорговли.IDD ПодразделенияIDD,
  SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('MD5', ОстаткиТовара.ФирмаIDD+ОстаткиТовара.СкладIDD)), 18, 32) AS ХешСкладаIDD,
  SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('MD5', ОстаткиТовара.ФирмаIDD+ПодразделенияТорговли.IDD)), 18, 32) AS ХешПодразделенияIDD,
  ОстаткиТовара.ТоварIDD,
  ОстаткиТовара.Стоимость,
  ОстаткиТовара.ОстатокТовара
FROM
  dbo.Бух_РегистрОстатки_ПартииТоваров AS ОстаткиТовара
  LEFT JOIN Бух_Справочник_МестаХранения AS МестаХранения
  ON (МестаХранения.id = ОстаткиТовара.СкладID)
  LEFT JOIN Бух_Справочник_Подразделения AS ПодразделенияТорговли
  ON МестаХранения.ВладелецID = ПодразделенияТорговли.ID



WHERE
  ОстаткиТовара.period = '20180101'
  AND ОстаткиТовара.ФирмаIDD = '10015480660352695' -- ИП Моисеев М.Д.
  AND
  not
  (
  (ОстаткиТовара.ОстатокТовара = 0)
    and
    (ОстаткиТовара.Стоимость = 0)
  )
  --AND ОстаткиТовара.ТоварIDD IS NOT NULL