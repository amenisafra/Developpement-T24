* @ValidationCode : MjozNTA1ODQyMDE6Q3AxMjUyOjE2MjA2OTY3NDEwMTM6QU1FTkk6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjBfU1A0LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 11 May 2021 02:32:21
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
* Implementation of ATB.CDI.SpecifiqueControl.ATBICDILUserInit
*
*
SUBROUTINE ATB.V.CDI.LUSER.INIT
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
    
****RG006 VALIDATION

    User = EB.SystemTables.getRUser()
    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.USER.INIT", POSUSER)
 
    LocRefUS = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)
    LocalRef <1, POSUSER> = User
    EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)
       

RETURN
