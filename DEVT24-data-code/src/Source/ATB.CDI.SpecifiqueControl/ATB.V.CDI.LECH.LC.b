* @ValidationCode : MjoxNTkyODI0MjQwOkNwMTI1MjoxNjIwNjk2NjQyNzY2OkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 11 May 2021 02:30:42
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
* Implementation of ATB.CDI.SpecifiqueControl.ATBICDILEchLC
*
*
SUBROUTINE ATB.V.CDI.LECH.LC
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
    
    
****RG005 VALIDATION

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.ECHEANCE.LC", POSECH)
    Y.AD.EX.DT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcAdviceExpiryDate)
    LocRef = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)
    LocalRef <1, POSECH> = Y.AD.EX.DT
    EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)

RETURN
