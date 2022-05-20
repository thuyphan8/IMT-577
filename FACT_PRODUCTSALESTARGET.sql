--CREATE TABLE FACT_ProductSalesTarget
CREATE OR REPLACE TABLE PUBLIC.FACT_ProductSalesTarget (
    DimProductID INTEGER CONSTRAINT FK_DimProductIDProduct FOREIGN KEY REFERENCES PUBLIC.Dim_Product (DimProductID) NOT NULL 
    , DimTargetDateID number(9) CONSTRAINT FK_DimTargetDateIDDDate FOREIGN KEY REFERENCES PUBLIC.Dim_Date (DATE_PKEY) NOT NULL
    , ProductTargetSalesQuantity INT NOT NULL
); 
--Load unknown ProductSalesTarget
INSERT INTO PUBLIC.FACT_ProductSalesTarget (
    DimProductID
    , DimTargetDateID
    , ProductTargetSalesQuantity
)
VALUES (
    -1
    ,-1
    , -1
)
--Load ProductSalesTarget data
INSERT INTO PUBLIC.FACT_ProductSalesTarget (
    DimProductID
    , DimTargetDateID
    , ProductTargetSalesQuantity
)
SELECT COALESCE(B.DimProductID, -1)
    , C.DATE_PKEY
    , CAST(A.SALESQUANTITYTARGET as INT)
FROM STAGE_TARGETDATAPRODUCT A
LEFT JOIN PUBLIC.DIM_PRODUCT B ON A.PRODUCTID = B.PRODUCTID
LEFT JOIN PUBLIC.DIM_DATE C ON A.YEAR = CAST(C.YEAR AS VARCHAR)

