USE RIASSE

	DELETE
	FROM 
		[RIASSE].[dbo].[tran2_buh]
	WHERE
		[IDD_DB] = '8888888'
		AND [RIASSE].[dbo].[tran2_buh].VIDD NOT IN (
			-- '�����                                             '
			--,'���������������                                   '
			--,'������������                                      '
			--,'��������                                          '
			--,'���������������������                             '
			--,'�����������                                       '
			--,'�������������                                     '
			--,'������������                                      '
			--,'�������������                                     '
			--,'��������������������                              '
			--,'��������������                                    '
			--,'���������������������                             '
			--,'�����������������������                           '
			--,'�����                                             '
			 '�����������������������                           '
			,'���������                                         '
			,'���������������                                   '
			,'����������                                        '
			,'���������������������������                       '
			,'������������������                                '
			,'����������������                                  '
			,'������������������                                '
			,'����������������                                  '
			,'����������������                                  '
			,'��������                                          '
	
		)

