ALTER PROCEDURE [dbo].[ProcedurePacketInsetInTable]  
--параметры: @NameTable - уникальное имя глобальной временной таблицы, формируемое на клиенте, несмотря на мануал на msdn, даже в рамках одного коннекта
--разные объекты command могут работать только с глобальной ВТ, для надежности записи и чтения имя формируем уникальным
--@FlagCreate - флаг создания глобальной временной таблицы  
--@FlagInsert - флаг результируещей записи (записи всей переданной построчно таблицы значений)  
--@Text       - текст запроса, содержащий все значения     
@NameTable nchar(100),
@NameTableDelete nchar(100),
@FlagCreate int,
@FlagInsert int,
@Text nvarchar(max)      
 
AS BEGIN    --результирующий инсерт делаем, если передан флаг, если нет - создаем и заполняем таблицу  
IF @FlagInsert = 0   --////   
    BEGIN   --если передан флаг создания таблицы - динамически создадим глобальную временную таблицу, используя переданное имя    
        IF @FlagCreate = 1
            BEGIN   --хотя SQL сам удаляет ВТ при отсутствии обращений к ним, тем не менее, подстрахуемся:      
                DECLARE @DinamicDeleteTable nvarchar(max)      
                SET @DinamicDeleteTable = 'IF OBJECT_ID('+@NameTableDelete+') IS NOT NULL DROP TABLE ' + @NameTable      
                EXEC sp_executesql @DinamicDeleteTable
                DECLARE @DinamicCreate nvarchar(max)      
                SET @DinamicCreate = 'SELECT TOP 0 * INTO ' + @NameTable + ' FROM EdbTranzactionsPC'         
                EXEC sp_executesql @DinamicCreate     
            END --если флаг не передан - таблица уже создана, выполняем динамический построчный инсерт в глобальную ВТ        
        ELSE 
            EXEC sp_executesql @Text
  END   --////  
ELSE    --передан флаг записи, выполняем запись и очистку ВТ   
    BEGIN    
        DECLARE @DinamicALLInsert nvarchar(max)    
        SET @DinamicALLInsert = 'INSERT INTO EdbTranzactionsPc SELECT * FROM ' + @NameTable    
        EXEC sp_executesql @DinamicALLInsert        DECLARE @DinamicDELETE nvarchar(max)    
        SET @DinamicDELETE = 'DELETE FROM ' + @NameTable     
        EXEC sp_executesql @DinamicDELETE        
    END    
END