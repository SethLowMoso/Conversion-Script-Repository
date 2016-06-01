/****************************************************************
Correct the MemberAgreementEditable StartDate
****************************************************************/


UPDATE ma SET ma.EditableStartDate = na.STARTDATE 
-- SELECT ma.MemberAgreementID, ma.EditableStartDate,na.Startdate AS DesiredStart, a.StartDate
FROM dbo.ForeignObjects fo
INNER JOIN ImportServer.Stage_TSI_HVLP.dbo.AgreementToImport a ON fo.ForeignId = a.AgreementReferenceID 
INNER JOIN  [TSI_tactical].[dbo].[Storage_NS132542_SoHo_AgreementImport] na ON na.MEMBERID = a.OwnerID
INNER JOIN dbo.MemberAgreement ma ON ma.MemberAgreementID = fo.InternalObjectId
INNER JOIN dbo.PartyRole p ON p.PartyRoleID = ma.PartyRoleId
WHERE InternalObjectType = 2
	AND CONVERT(DATE,ma.EditableStartDate, 101) != na.STARTDATE

