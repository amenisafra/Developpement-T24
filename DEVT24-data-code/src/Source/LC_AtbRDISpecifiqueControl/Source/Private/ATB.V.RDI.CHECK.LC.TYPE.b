* @ValidationCode : MjotNjI5MDgyODY3OkNwMTI1MjoxNjI2MTg2ODE2ODQyOkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 13 Jul 2021 15:33:36
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDICheckLcType
*
*
SUBROUTINE ATB.V.RDI.CHECK.LC.TYPE


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


*******RG008

    LC.TYPE = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLcType)

    IF LC.TYPE EQ "IRAG" THEN
        EB.SystemTables.setAf(LC.Contract.LetterOfCredit.TfLcLcType)
        EB.SystemTables.setEtext("LC-RDI.LCTYPE") ; * paramterer EB.ERROR
        EB.ErrorProcessing.StoreEndError()

    END


RETURN
