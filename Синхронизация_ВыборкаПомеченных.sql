USE RIASSE

SELECT
	 [ROW_ID]
	,[IDD]
	,[TIP]
	,[VIDD]
	,[POS]
	,[DATE1]	
	,[DATE2]
	,[IDD_DB]
	,[IDD_Packet]
	,[DateOfInsert]
	--,Convert(datetime, '13.08.2018 15:05:38', 103) AS ДатаУсловия

FROM 
	[RIASSE].[dbo].[tran2_buh]
WHERE
	[IDD_DB] = '8888888'
	--AND [RIASSE].[dbo].[tran2_buh].VIDD LIKE '%ПриходнаяНакладная%'
	--AND [RIASSE].[dbo].[tran2_buh].DateOfInsert <= Convert(datetime, '13.08.2018 15:05:38', 103)

ORDER BY
	--[DateOfInsert]
	--[VIDD]
	 [DateOfInsert]
	,[VIDD]