-------------------------------------------
-- ������ ��� ������������ �������� ��������� ���� ������
--
-------------------------------------------
-- ������������� ���������
-- ���� ������ ��� �������
USE buhcorp

-------------------------------------------
-- ��������� ���������� 
DECLARE @object_id int; -- ID �������
DECLARE @index_id int; -- ID �������
DECLARE @partition_number bigint; -- ���������� ������ ���� ������ �������������
DECLARE @schemaname nvarchar(130); -- ��� ����� � ������� ��������� �������
DECLARE @objectname nvarchar(130); -- ��� ������� 
DECLARE @indexname nvarchar(130); -- ��� �������
DECLARE @partitionnum bigint; -- ����� ������
DECLARE @fragmentation_in_percent float; -- ������� ������������ �������
DECLARE @command nvarchar(4000); -- ���������� T-SQL ��� �������������� ���� ������������

-------------------------------------------
-- ���� �������

-- ��������� ����� ���������� ������������ �����, ��� ��������� ������� ���������
SET NOCOUNT ON;

-- ������ ��������� �������, ���� ����� ��� ����
IF OBJECT_ID('tempdb.dbo.#work_to_do') IS NOT NULL DROP TABLE #work_to_do

-- ����� ������ � �������� � ������� ���������� ������������� sys.dm_db_index_physical_stats
-- ����� ������ ��� �������� �������:
--	�������� ��������� (index_id > 0)
--	������������ ������� ����� 5% 
--	���������� ������� � ������� ����� 128 
SELECT
    object_id,
    index_id,
    partition_number,
    avg_fragmentation_in_percent AS fragmentation_in_percent
INTO #work_to_do
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, 'LIMITED')
WHERE index_id > 0 
	AND avg_fragmentation_in_percent > 5.0
	AND page_count > 128;

-- ���������� �������� ������� ������� ��� ������ ������
DECLARE partitions CURSOR FOR SELECT * FROM #work_to_do;
OPEN partitions;

-- ���� �� �������
FETCH NEXT FROM partitions INTO @object_id, @index_id, @partition_number, @fragmentation_in_percent;
WHILE @@FETCH_STATUS = 0
    BEGIN		
		
	-- �������� ����� �������� �� ID		
        SELECT @objectname = QUOTENAME(o.name), @schemaname = QUOTENAME(s.name)
        FROM sys.objects AS o
		JOIN sys.schemas as s ON s.schema_id = o.schema_id
        WHERE o.object_id = @object_id;
        
	SELECT @indexname = QUOTENAME(name)
        FROM sys.indexes
        WHERE  object_id = @object_id AND index_id = @index_id;
        
	SELECT @partition_number = count (*)
        FROM sys.partitions
        WHERE object_id = @object_id AND index_id = @index_id;

	-- ���� ������������ ����� ��� ����� 30% ����� ��������������, ����� ������������
        IF @fragmentation_in_percent < 30.0
            SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname + N' REORGANIZE';
        IF @fragmentation_in_percent >= 30.0
            SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname + N' REBUILD';
        IF @partition_number > 1
            SET @command = @command + N' PARTITION=' + CAST(@partition_number AS nvarchar(10));
		
	-- ��������� �������				
        EXEC (@command);
	PRINT N'Index: object_id=' + STR(@object_id) + ', index_id=' + STR(@index_id) + ', fragmentation_in_percent=' + STR(@fragmentation_in_percent);
        PRINT N'Executed: ' + @command;
		
	-- ��������� ������� �����
	FETCH NEXT FROM partitions INTO @object_id, @index_id, @partition_number, @fragmentation_in_percent;

	END;

-- �������� �������
CLOSE partitions;
DEALLOCATE partitions;

-- �������� ��������� �������
DROP TABLE #work_to_do;

GO