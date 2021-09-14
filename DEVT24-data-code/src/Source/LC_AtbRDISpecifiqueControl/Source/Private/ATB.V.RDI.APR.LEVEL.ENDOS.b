* @ValidationCode : Mjo5OTQwNTk1NjA6Q3AxMjUyOjE2MjQ3MTY5NzQxMzg6QU1FTkk6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjBfU1A0LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 26 Jun 2021 15:16:14
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDIAprLevelEndos
*
*
SUBROUTINE ATB.V.RDI.APR.LEVEL.ENDOS

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
    

****RG016  RG013 OUVERTURE  TESTED AND IT WORKS

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.MNTENDOS", POSENDOS)
    Y.L.LMNTENDOS = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)<1,POSENDOS>
    Y.LC.AMOUNT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLcAmount)
    
    fnGpST = "F.EB.H.ATB.GROUPE.STATUS"
    fGpST = ""
    EB.DataAccess.Opf(fnGpST, fGpST)

    Y.PRODUIT = "RDI"
    Y.ACT.AUTH = "AUTHORISE"
*    cmdSelect = "SELECT ":fnGpST:" WITH PRODUIT EQ '":Y.PRODUIT:"' AND ACTION EQ '":Y.ACTION:"'"

    cmdSelect = "SELECT ":fnGpST:" WITH PRODUIT EQ '":Y.PRODUIT:"'"


    EB.DataAccess.Readlist(cmdSelect, listRecs, "", nbrRecs, error)
    
    IF listRecs NE "" THEN
        FOR I = 1 TO nbrRecs
            EB.DataAccess.FRead(fnGpST, listRecs<I>, Rec, fGpST, Er)
            Y.ACTION = Rec<FX.AtbApplicationControl.EbHAtbGroupeStatus.Action>
            Y.MONTANT = Rec<FX.AtbApplicationControl.EbHAtbGroupeStatus.Montant>
            Y.AUTH.LEVEL =  Rec<FX.AtbApplicationControl.EbHAtbGroupeStatus.Groupe>
            
            IF Y.MONTANT EQ Y.LC.AMOUNT AND Y.ACTION EQ Y.ACT.AUTH THEN
                EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.AUT.LEVEL", POSAUTH)
                LocRef = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)
                LocalRef <1, POSAUTH> = Y.AUTH.LEVEL
                EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)
            END
        
        NEXT I
    END

RETURN
