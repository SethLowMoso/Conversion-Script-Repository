SELECT 'Agreement Import Ref Error' AS ErrorType
		, ai.OwnerId 
		, ai.AgreementReferenceId
		, ai.MappingId
		, a.ImportRef
FROM [ImportServer].[Stage_TSI_HVLP].dbo.AgreementToImport ai
LEFT JOIN [tsi-proddb].Tenant_tsi.dbo.Agreement a ON a.ImportRef = ai.MappingId
WHERE a.ImportRef IS NULL


--UPDATE AgreementToImport SET MappingId = 'Passport Conversion'

--SELECT * FROM AgreementToImport WHERE MappingID != 'Passport Conversions'

SELECT 'ItemTermLocation or BillingSchedule Ref Error' AS ErrorType
			, ai.AgreementReferenceId
			, ai.MappingId
			, itl.ImportRef
			, bp.ImportRef
			, ai.BillingScheduleRefId
			, bs.ImportRef
FROM [ImportServer].[Stage_TSI_HVLP].dbo.AgreementItemsToImport ai
LEFT JOIN [tsi-proddb].Tenant_tsi.dbo.ItemTermslocation itl ON itl.ImportRef = ai.MappingId
LEFT JOIN [tsi-proddb].Tenant_tsi.dbo.bundleprice bp on bp.importref = ai.MappingId
LEFT JOIN [tsi-proddb].Tenant_tsi.dbo.BillingSchedule bs on bs.ImportRef = ai.BillingScheduleRefId
WHERE ((itl.ImportRef IS NULL AND bp.ImportRef IS NULL)
		OR bs.ImportRef IS NULL)


SELECT 'BillingSchedule Ref Error' AS ErrorType
		, ap.ItemReferenceId
		, ap.MappingId
		, bs.ImportRef
-- SELECT *
FROM [ImportServer].[Stage_TSI_HVLP].dbo.AgreementItemPaysourcesToImport ap
LEFT JOIN [tsi-proddb].Tenant_tsi.dbo.BillingSchedule bs on bs.ImportRef = ap.MappingId
WHERE bs.ImportRef IS NULL