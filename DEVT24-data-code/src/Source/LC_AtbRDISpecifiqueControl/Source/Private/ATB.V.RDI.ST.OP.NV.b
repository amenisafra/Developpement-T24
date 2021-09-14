* @ValidationCode : MjoxODM1MTQzOTI1OkNwMTI1MjoxNjI0NzE5NTE5NTQ4OkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 26 Jun 2021 15:58:39
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDILStOpNv
*
*
SUBROUTINE ATB.V.RDI.ST.OP.NV
    

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
