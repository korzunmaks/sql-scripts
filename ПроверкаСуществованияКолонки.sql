USE RIASSE
if COLUMNPROPERTY(object_id('dbo.ColorColumnTables1'), 'ДатаОбновления', 'ColumnId') is null
BEGIN
	print 'doesn\t exist'
	--ALTER TABLE ColorColumnTables2 ADD ДатаОбновления DateTime
END
else
	print 'exists'