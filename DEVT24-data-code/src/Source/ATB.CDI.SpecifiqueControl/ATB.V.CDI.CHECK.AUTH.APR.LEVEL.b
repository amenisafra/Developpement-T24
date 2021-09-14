* @ValidationCode : MjoyNDYyMTkwNTpDcDEyNTI6MTYyMTI0OTY5Nzk1ODpBTUVOSTotMTotMTowOjA6ZmFsc2U6Ti9BOlIyMF9TUDQuMDotMTotMQ==
* @ValidationInfo : Timestamp         : 17 May 2021 12:08:17
* @ValidationInfo : Encoding          : Cp1252
* @ValidationInfo : User Name         : AMENI
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : R20_SP4.0
$PACKAGE ATB.CDI.SpecifiqueControl
*
* Implementation of ATB.CDI.SpecifiqueControl.ATBICDICheckAuthAprLevel
*
*
SUBROUTINE ATB.V.CDI.CHECK.AUTH.APR.LEVEL


    $USING EB.SystemTables
    $USING EB.API
    $USING EB.DataAccess
    $USING EB.ErrorProcessing
    $USING EB.OverrideProcessing
    $USING EB.LocalReferences
    $USING AC.EntryCreation
    $USING LC.Contract
    $USING EB.Foundation
    $USING EB.Security


    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.AUT.LEVEL", POSAUTHLV)
    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.APR.LEVEL", POSAPRLV)
    LocRef = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)

    Y.L.AUTH.LEVEL = LocRef<1,POSAUTHLV>
    Y.L.APR.LEVEL = LocRef<1,POSAPRLV>

    IF Y.L.AUTH.LEVEL NE Y.L.APR.LEVEL THEN
        EB.SystemTables.setEtext(ATB.INT.AUTHLV.NE.APRLV) ; * paramterer EB.ERROR
        EB.ErrorProcessing.StoreEndError()
        
    END


RETURN
