* @ValidationCode : MjotMTc1NTIwMjIxNjpDcDEyNTI6MTYyNDcxOTQzNzA1NzpBTUVOSTotMTotMTowOjA6ZmFsc2U6Ti9BOlIyMF9TUDQuMDotMTotMQ==
* @ValidationInfo : Timestamp         : 26 Jun 2021 15:57:17
* @ValidationInfo : Encoding          : Cp1252
* @ValidationInfo : User Name         : AMENI
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : R20_SP4.0
$PACKAGE LC.AtbRDISpecifiqueControl
*
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDILSuspens
*
*
SUBROUTINE ATB.V.RDI.LSUSPENS
    
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
    $USING EB.Interface
    $USING FX.AtbApplicationControl

****RG0015


    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.SUSPENS", POSSUSP)

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.MONTANT.LC", posMnt)
    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.ECHEANCE.LC", POSECH)
    Y.L.ECH = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)<1,POSECH>
    Y.L.MNT.LC = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)<1,posMnt>
    Y.ADV.EXP.DT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcAdviceExpiryDate)
    Y.LIAB.P.AMT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLiabPortAmt)
    Y.PROV.MNT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcProvisAmount)
    Y.AMT = Y.LIAB.P.AMT - Y.PROV.MNT
    
    IF ( Y.AMT GT Y.L.MNT.LC ) OR ( Y.ADV.EXP.DT GT Y.L.ECH ) THEN
        LocalRef <1, POSSUSP> = "OUI"
        EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)
    END ELSE
        LocalRef <1, POSSUSP> = "NON"
        EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)
    
    END

RETURN
