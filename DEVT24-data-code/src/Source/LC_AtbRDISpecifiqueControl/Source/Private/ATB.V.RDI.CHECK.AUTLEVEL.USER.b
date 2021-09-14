* @ValidationCode : MjoxMjIzMzQ3Mjg6Q3AxMjUyOjE2MjU1NTYzMzUzNzg6QU1FTkk6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjBfU1A0LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 06 Jul 2021 08:25:35
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDICheckAutLevelUser
*
*
SUBROUTINE ATB.V.RDI.CHECK.AUTLEVEL.USER(Y.REC.BOOL, Y.REC.VALUE)

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
    
****RG011 RECURSIVITE

******
pathFile = "./LOG"
    fileName = "adama_BUILDRTN3"
    fnLog = pathFile:'/':fileName
    OPENSEQ pathFile,fileName TO fileLog THEN
    END ELSE
        CREATE fileLog ELSE NULL
    END		
   
    PW.ACT.TXN = PW.Foundation.getActivityTxnId()
    ACT.TXN.REC = PW.Foundation.ActivityTxn.Read(PW.ACT.TXN, Error)
    
    TRANS.REF = ACT.TXN.REC<PW.Foundation.ActivityTxn.ActTxnTransactionRef>
    
    fnLc = "F.LETTER.OF.CREDIT$NAU"
    fLc = ""
    EB.DataAccess.Opf(fnLc, fLc)
    
    RECLC = LC.Contract.LetterOfCredit.ReadNau(TRANS.REF, error)
    log = RECLC
    WRITESEQ log APPEND TO fileLog ELSE NULL
    LOCALREF = RECLC<LC.Contract.LetterOfCredit.TfLcLocalRef>
*******

    Y.REC.BOOL= ''

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.AUT.LEVEL", POSAUT)
*    Y.L.AUT.LEVEL = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)<1,POSAUT>

    Y.L.AUT.LEVEL = LOCALREF<1,POSAUT>
    log = Y.L.AUT.LEVEL
    WRITESEQ log APPEND TO fileLog ELSE NULL
    User = EB.SystemTables.getRUser()
    fnUsGp = "F.EB.H.ATB.USER.GROUPE"
    fUsGp = ""
    EB.DataAccess.Opf(fnUsGp, fUsGp)
    
    RecUsGp = FX.AtbApplicationControl.EbHAtbUserGroupe.Read(User, Error)
    Y.L.AUT.LEVEL.US = RecUsGp<FX.AtbApplicationControl.EbHAtbUserGroupe.Groupe>
      log = Y.L.AUT.LEVEL.US
    WRITESEQ log APPEND TO fileLog ELSE NULL
    IF Y.L.AUT.LEVEL.US NE Y.L.AUT.LEVEL THEN
        Y.REC.BOOL = 'TRUE'
    END ELSE
        Y.REC.BOOL = 'FALSE'
    END
log = Y.REC.BOOL
    WRITESEQ log APPEND TO fileLog ELSE NULL
RETURN
