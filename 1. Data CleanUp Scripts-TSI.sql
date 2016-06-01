/********************************************************************************
These are maintenance scripts to handle data issues. That consistantly pop up 
with the Agreement Import Generator process. 
********************************************************************************/


UPDATE a SET PrimaryAgreementID = NULL
--SELECT *
FROM ImportServer.Stage_TSI_HVLP.dbo.AgreementToImport a
WHERE PrimaryAgreementID = 'NULL'


UPDATE a SET Barcode = NULL
--SELECT *
FROM ImportServer.Stage_TSI_HVLP.dbo.AgreementToImport a
WHERE Barcode = 'NULL'