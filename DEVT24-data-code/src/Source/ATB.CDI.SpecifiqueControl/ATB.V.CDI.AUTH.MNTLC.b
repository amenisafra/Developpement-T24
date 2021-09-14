* @ValidationCode : MjotNjg5ODkwNzgwOkNwMTI1MjoxNjIwNjk2NTAyMDMyOkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 11 May 2021 02:28:22
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
* Implementation of ATB.CDI.SpecifiqueControl.ATBICDIAuthMntLC
*
*
SUBROUTINE ATB.V.CDI.AUTH.MNTLC
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


****RG004
    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.MONTANT.LC", posMnt)
    Y.LIAB.P.AMT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLiabPortAmt)
    Y.PROV.MNT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcProvisAmount)
    Y.AMT = Y.LIAB.P.AMT - Y.PROV.MNT
    LocRefMNT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)
    LocalRef <1, posMnt> = Y.AMT
    EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)


RETURN
