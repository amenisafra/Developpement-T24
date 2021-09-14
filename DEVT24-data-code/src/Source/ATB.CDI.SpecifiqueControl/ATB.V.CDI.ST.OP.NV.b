* @ValidationCode : MjotNTg5NzUyNDMzOkNwMTI1MjoxNjIwNjk3NDUxNTYzOkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 11 May 2021 02:44:11
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
* Implementation of ATB.CDI.SpecifiqueControl.ATBICDILStOpNv
*
*
SUBROUTINE ATB.V.CDI.ST.OP.NV
    
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

****RG029 OUVERTURE
    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.STAT.OP", POSSTOP)

    LocRef = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)
    Y.L.STAT.OP = LocRef<1, POSSTOP>

    IF Y.L.STAT.OP EQ "NOUVEAU" THEN
             
        EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcBeneficiary, "")
        EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcAdvisingBk, "")
        EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcAvailableWith, "")
        
    END

RETURN
