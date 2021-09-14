* @ValidationCode : MjotMzE4NTk2OTYxOkNwMTI1MjoxNjI0NzE3ODIxNzg2OkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 26 Jun 2021 15:30:21
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDIAuthMntLC
*
*
SUBROUTINE ATB.V.RDI.AUTH.MNTLC

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

****RG004 OUVERTURE tested and it works

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.MONTANT.LC", posMnt)
    Y.LIAB.P.AMT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLiabPortAmt)
    Y.PROV.MNT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcProvisAmount)
    Y.AMT = Y.LIAB.P.AMT - Y.PROV.MNT

    LocalRef <1, posMnt> = Y.AMT
    EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)


RETURN
