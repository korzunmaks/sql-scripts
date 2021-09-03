WITH Parts(ParentID, ID, CODE, DESCR, goodsLevel, ord) as
(   SELECT 
           main.ParentID, 
           main.ID,
           main.CODE,
           main.DESCR, 
           0 goodsLevel, 
           CAST((LTRIM(RTRIM(main.ISFOLDER)) + LTRIM(RTRIM(ISNULL(main.DESCR,'')))) as nvarchar(max)) ord
    FROM 
           SC46 main 
    WHERE 
           main.ISFolder = 1 AND main.ParentID = '     0   '
           --main.CODE = ' 5097' 
    UNION ALL  
    SELECT 
           child.ParentID, 
           child.ID,
           child.CODE,
           child.DESCR ,
           goodsLevel + 1, 
           (p.ord + LTRIM(RTRIM(child.ISFOLDER)) + LTRIM(RTRIM(ISNULL(child.DESCR,'')))) ord
    FROM SC46 child
        INNER JOIN Parts p  
        ON child.ParentID = p.ID 
        AND child.ISFolder = 1

)  
SELECT CODE, DESCR, ID, ParentID, goodsLevel, ord
FROM Parts 
ORDER BY ord