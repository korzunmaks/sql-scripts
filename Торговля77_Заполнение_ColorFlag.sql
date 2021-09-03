USE RIASSE

SET NOCOUNT ON

DECLARE
@Flag char(1)
SET @Flag = 1

IF OBJECT_ID(N'ColorFlag', N'U') IS NULL 
	BEGIN
		CREATE TABLE dbo.ColorFlag (Flag char(1) NOT NULL)
		INSERT INTO dbo.ColorFlag VALUES (@Flag)
	END
ELSE
	UPDATE dbo.ColorFlag
	SET Flag = @Flag
	WHERE Flag <> @Flag