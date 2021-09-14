* @ValidationCode : MjoxNzMxNzY5NjgyOkNwMTI1MjoxNjI1NzQ5MzcwNjEyOkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 08 Jul 2021 14:02:50
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDICheckAutLevel
*
*
SUBROUTINE ATB.V.RDI.CHECK.AUTLEVEL
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
    
****RG011 RECURSIVITE new solution VERSION

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.AUT.LEVEL", POSAUTLEVEL)
    Y.L.AUT.LEVEL = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)<1,POSAUTLEVEL>
    
    User = EB.SystemTables.getRUser()
    fnUsGp = "F.EB.H.ATB.USER.GROUPE"
    fUsGp = ""
    EB.DataAccess.Opf(fnUsGp, fUsGp)
    
    RecUsGp = FX.AtbApplicationControl.EbHAtbUserGroupe.Read(User, Error)
    Y.L.AUT.LEVEL.US = RecUsGp<FX.AtbApplicationControl.EbHAtbUserGroupe.Groupe>
      
    IF Y.L.AUT.LEVEL.US NE Y.L.AUT.LEVEL THEN
        Y.AUTH = "NON"
    END ELSE
        Y.AUTH = "OUI"
        
    END
    
    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.AUTH", POSAUTH)
    LocalRef = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)
    LocalRef <1, POSAUTH> = Y.AUTH
    LocalRef <1, POSAUTLEVEL> = Y.L.AUT.LEVEL
    EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)
    

RETURN
