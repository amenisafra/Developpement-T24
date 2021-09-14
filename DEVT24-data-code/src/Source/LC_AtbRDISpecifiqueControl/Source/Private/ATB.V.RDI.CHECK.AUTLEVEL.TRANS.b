* @ValidationCode : MjoxMDczNDY2OTk3OkNwMTI1MjoxNjI1NTU2NTA5MTYxOkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 06 Jul 2021 08:28:29
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDICheckAutLevelTrans
*
* Y.REC.TR(INOUT) :
*
SUBROUTINE ATB.V.RDI.CHECK.AUTLEVEL.TRANS(Y.REC.TR)

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
    $USING PW.Foundation
    
****RG011 RECURSIVITE Routine PW.TRANSITION

******
    PW.ACT.TXN = PW.Foundation.getActivityTxnId()
    ACT.TXN.REC = PW.Foundation.ActivityTxn.Read(PW.ACT.TXN, Error)
    
    TRANS.REF = ACT.TXN.REC<PW.Foundation.ActivityTxn.ActTxnTransactionRef>
    
    fnLc = "F.LETTER.OF.CREDIT$NAU"
    fLc = ""
    EB.DataAccess.Opf(fnLc, fLc)
    
    RECLC = LC.Contract.LetterOfCredit.ReadNau(TRANS.REF, error)
    
    LOCALREF = RECLC<LC.Contract.LetterOfCredit.TfLcLocalRef>
    
*******

    Y.REC.TR= ""

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.AUT.LEVEL", POSAUT)
*    Y.L.AUT.LEVEL = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)<1,POSAUT>
    Y.L.AUT.LEVEL = LOCALREF<1,POSAUT>
    
    
    User = EB.SystemTables.getRUser()
    fnUsGp = "F.EB.H.ATB.USER.GROUPE"
    fUsGp = ""
    EB.DataAccess.Opf(fnUsGp, fUsGp)
    
    RecUsGp = FX.AtbApplicationControl.EbHAtbUserGroupe.Read(User, Error)
    Y.L.AUT.LEVEL.US = RecUsGp<FX.AtbApplicationControl.EbHAtbUserGroupe.Groupe>
      
    IF Y.L.AUT.LEVEL.US NE Y.L.AUT.LEVEL THEN
        Y.REC.TR = 0
    END ELSE
        Y.REC.TR = 1
    END

RETURN
