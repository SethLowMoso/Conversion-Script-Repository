/******************************************************************************
This is the backdating Script for the basic configurations.
******************************************************************************/


DECLARE @BacktoDate AS datetime = '1905-01-01 00:00:00.000'
		, @Val bit = 0
		, @Update BIT = 1


IF(@Update = 1) 
	BEGIN
		update Agreement
		set StartDate = @BacktoDate,
			StartDate_UTC = @BacktoDate
		FROM Agreement a
		INNER JOIN ImportServer.Stage_TSI_HVLP.[dbo].[AgreementToImport] ai ON ai.MappingID = a.ImportRef 
		WHERE a.StartDate <> @BacktoDate
			--AND AgreementID IN (42,43,44,51,55,48,56,57,74, 81,142,141, 160, 170)

		UPDATE AgreementGroup
		SET StartDate = @BacktoDate, 
			StartDate_UTC = @BacktoDate
		FROM AgreementGroup ag
		INNER JOIN ImportServer.Stage_TSI_HVLP.[dbo].[AgreementToImport] ai ON ai.AgreementGroupReferenceID = ag.ImportRef 
		WHERE ag.Startdate <> @BacktoDate 

		update AgreementLocation
		set StartDate = @BacktoDate,
			StartDate_UTC = @BacktoDate
		FROM AgreementLocation al
		INNER JOIN Agreement a ON al.AgreementID = a.AgreementId
		INNER JOIN ImportServer.Stage_TSI_HVLP.[dbo].[AgreementToImport] ai ON ai.MappingID = a.ImportRef 
		WHERE al.StartDate <> @BacktoDate

		Update Bundle
		set FirstAvailableDate = @BacktoDate,
			FirstAvailableDate_UTC = @BacktoDate
		WHERE FirstAvailableDate <> @BacktoDate

		Update BundleLocation
		set StartDate = @BacktoDate,
			StartDate_UTC = @BacktoDate
		WHERE StartDate <> @BacktoDate

		Update ItemTermsLocation
		set StartDate = @BacktoDate,
		StartDate_UTC = @BacktoDate
		FROM ItemTermsLocation itl
		INNER JOIN ImportServer.Stage_TSI_HVLP.[dbo].[AgreementItemsToImport]  ai ON ai.mappingID = itl.ImportRef
		WHERE itl.StartDate <> @BacktoDate

		Update ItemPrice
		set StartDate = @BacktoDate,
			StartDate_UTC = @BacktoDate
		WHERE StartDate <> @BacktoDate

		--update TaxRate
		--set StartDate = @BacktoDate,
		--	StartDate_UTC = @BacktoDate
		--WHERE StartDate <> @BacktoDate
	END 

IF(@Val = 1)
	BEGIN
	
		SELECT 'Agreement' AS Agreement, ai.MappingID, a.StartDate, a.ImportRef
		FROM Agreement a
		INNER JOIN ImportServer.Stage_TSI_HVLP.[dbo].[AgreementToImport] ai ON ai.MappingID = a.ImportRef 
		WHERE a.StartDate <> @BacktoDate
			--AND AgreementID IN (42,43,44,51,55,48,56,57,74, 81,142,141, 160, 170)

		SELECT 'AgreementGroup' AS AgreementGroup, ai.AgreementGroupReferenceID, ag.StartDate 
		FROM AgreementGroup ag
		INNER JOIN ImportServer.Stage_TSI_HVLP.[dbo].[AgreementToImport] ai ON ai.AgreementGroupReferenceID = ag.ImportRef 
		WHERE ag.Startdate <> @BacktoDate 

		SELECT 'AgreementLocation' AS AgreementLocation,al.AgreementId, al.AgreementLocationId, al.StartDate
		FROM AgreementLocation al
		INNER JOIN Agreement a ON al.AgreementID = a.AgreementId
		INNER JOIN ImportServer.Stage_TSI_HVLP.[dbo].[AgreementToImport] ai ON ai.MappingID = a.ImportRef 
		WHERE al.StartDate <> @BacktoDate

		SELECT 'Bundle' AS Bundle, *
		FROM Bundle 
		WHERE FirstAvailableDate <> @BacktoDate

		SELECT 'BundleLocation' AS BundleLocation, *
		FROM BundleLocation
		WHERE StartDate <> @BacktoDate

		SELECT 'ItemTermsLocation' AS ItemTermsLocation, *
		FROM ItemTermsLocation itl
		INNER JOIN ImportServer.Stage_TSI_HVLP.[dbo].[AgreementItemsToImport]  ai ON ai.mappingID = itl.ImportRef
		WHERE itl.StartDate <> @BacktoDate

		SELECT 'ItemPrice' AS ItemPrice, *
		FROM ItemPrice
		WHERE StartDate <> @BacktoDate

		SELECT 'TaxRate' AS Taxrate, * 
		FROM TaxRate
		WHERE StartDate <> @BacktoDate
	END

/*
	SELECT *
	UPDATE al SET StartDate = '1905-01-01 00:00:00.000'
	FROM AgreementLocation al
	INNER JOIN Agreement a ON a.AgreementID = al.AgreementID 
	WHERE al.StartDate != '1905-01-01 00:00:00.000'
		AND a.Name Like '%Conversion%'

*/