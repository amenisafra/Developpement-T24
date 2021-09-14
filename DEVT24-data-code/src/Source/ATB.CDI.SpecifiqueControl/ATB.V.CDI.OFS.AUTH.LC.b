* @ValidationCode : Mjo2NTM4Mzg4MTc6Q3AxMjUyOjE2MTg4MzM4MDc0MTU6QU1FTkk6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjBfU1A0LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 19 Apr 2021 13:03:27
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
* Implementation of ATB.CDI.SpecifiqueControl.ATBICDIOfsAuthLC
*
*
SUBROUTINE ATB.V.CDI.OFS.AUTH.LC

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

    ofsSource = "ATB.OFS.INT"

    tableName   = "LETTER.OF.CREDIT"
    version      = "LETTER.OF.CREDIT,ATB.SERV.VALIDIMPLC.REJETOUVAG"
    fonction     = "A"
    idLC         = EB.SystemTables.getIdNew()
    mode         = "PROCESS"
    nbrAuth      = "0"
    gtsMode      = "1"

    DEBUG
    
   
    EB.Foundation.OfsBuildRecord(tableName, "A", "PROCESS", version, "1", "0", idLC, "", ofsMessage)
    EB.Interface.OfsCallBulkManager(ofsSource, ofsMessage, trtSt, txnValSt)


RETURN
