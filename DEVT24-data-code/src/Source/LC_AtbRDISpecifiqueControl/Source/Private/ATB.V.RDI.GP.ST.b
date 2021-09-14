* @ValidationCode : MjoxMjE4MTAwODgzOkNwMTI1MjoxNjI2NzE4NTg4MjQwOkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 19 Jul 2021 19:16:28
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDIGpSt
*
*
SUBROUTINE ATB.V.RDI.GP.ST

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

****RG007 RG016

*STILL NOT TESTED



    Y.LIAB.P.AMT = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLiabPortAmt)

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
            
            IF Y.MONTANT EQ Y.LIAB.P.AMT AND Y.ACTION EQ Y.ACT.AUTH THEN
                EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.AUT.LEVEL", POSAUTH)
                LocalRef = EB.SystemTables.getRNew(LC.Contract.LetterOfCredit.TfLcLocalRef)
                LocalRef <1, POSAUTH> = Y.AUTH.LEVEL
                EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)
            END
        
        NEXT I
    END

RETURN
