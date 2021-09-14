* @ValidationCode : MjoxOTg5ODI2NTM6Q3AxMjUyOjE2MjY0NDU3Nzk3MjQ6QU1FTkk6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjBfU1A0LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 16 Jul 2021 15:29:39
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
* Implementation of ATB.CDI.SpecifiqueControl.ATBICDIAprLevel
*
*
SUBROUTINE ATB.V.CDI.APR.LEVEL

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
    
****RG011  Si (User->Niveau autorisation) NE (L.APR.LEVEL+1)

    User = EB.SystemTables.getRUser()
    fnUsGp = "F.EB.H.ATB.USER.GROUPE"
    fUsGp = ""
    EB.DataAccess.Opf(fnUsGp, fUsGp)
    
    RecUsGp = FX.AtbApplicationControl.EbHAtbUserGroupe.Read(User, Error)
    Y.L.AUT.LEVEL.US = RecUsGp<FX.AtbApplicationControl.EbHAtbUserGroupe.Groupe>

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.DEC.SUP.COU", POSSUPC)
    Y.L.DEC.SUP.COU = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)<1,POSSUPC>

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.APR.LEVEL", POSAPR)
    Y.L.APR.LEVEL = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)<1,POSAPR>
    Y.APR = Y.L.APR.LEVEL[2,1]
    
    Y.APR.US = Y.L.AUT.LEVEL.US[2,1]
    
    IF Y.APR.US NE Y.APR + 1 THEN
        EB.SystemTables.setText("LC-CDI.NIVAUT")
        EB.OverrideProcessing.StoreOverride(CurrNo)
    END ELSE IF Y.L.DEC.SUP.COU EQ "ACCORD" THEN
        Y.APR = Y.APR + 1
    END ELSE IF Y.L.DEC.SUP.COU EQ "REJET" THEN
        Y.APR = 0
    END

    Y.APR.LEVEL = "H":Y.APR

    LocalRef <1, POSAPR> = Y.APR.LEVEL
    EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)
        
RETURN

