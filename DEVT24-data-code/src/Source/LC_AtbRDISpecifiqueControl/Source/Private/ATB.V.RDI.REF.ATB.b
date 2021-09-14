* @ValidationCode : MjoxNTUyNjYzMDc6Q3AxMjUyOjE2MjQ3MTk2MDI0MDA6QU1FTkk6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjBfU1A0LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 26 Jun 2021 16:00:02
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDIRefAtb
*
*
SUBROUTINE ATB.V.RDI.REF.ATB


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
    
****RG001
    
    
    Y.ID = EB.SystemTables.getIdNew()
    LEN.ID = LEN(Y.ID)
    
    Y.ID10 = Y.ID[3,10]

    Y.OLD.LC.NUM ="RDI": Y.ID10
 

    EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcOldLcNumber, Y.OLD.LC.NUM)
    

RETURN
