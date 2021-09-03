	SELECT 
	_InfoRg6621_IR2._Period AS Период, 
	_InfoRg6621_IR2._Fld6622RRef AS ФизЛицо, 
	_InfoRg6621_IR2._Fld6623RRef AS ДокументВид,
	_VidDoc._Description AS ДокументВидТекст,
	_InfoRg6621_IR2._Fld6624 AS ДокументСерия, 
	_InfoRg6621_IR2._Fld6625 AS ДокументНомер,
	_InfoRg6621_IR2._Fld6626 AS ДокументДатаВыдачи, 
	_InfoRg6621_IR2._Fld6627 AS ДокументКемВыдан,
	_InfoRg6621_IR2._Fld6628 AS ДокументКодПодразделения,
	_InfoRg6621_IR2._Fld6629 AS ДатаРегистрацииПоМестуЖительства
	--INTO #PasportnieDannieFizLica
	FROM 
		( 
		 SELECT 
		 _InfoRg6621._Fld6622RRef AS __Fld6622RRef, 
		 MAX(_InfoRg6621._Period) AS _MAXPERIOD 
		 FROM 
		    _InfoRg6621 WITH(NOLOCK)
		 GROUP BY
		    _InfoRg6621._Fld6622RRef
		) #V8TblAli1_IR1 
		INNER JOIN _InfoRg6621 _InfoRg6621_IR2 WITH(NOLOCK) 
		    ON #V8TblAli1_IR1.__Fld6622RRef = _InfoRg6621_IR2._Fld6622RRef 
		       AND #V8TblAli1_IR1._MAXPERIOD = _InfoRg6621_IR2._Period
		INNER JOIN _Reference48 _VidDoc WITH(NOLOCK) 
			ON _InfoRg6621_IR2._Fld6623RRef = _VidDoc._IDRRef

	Where _InfoRg6621_IR2._Fld6622RRef = 0xBFBAA4BF0107458411E7704B11A5C8F9