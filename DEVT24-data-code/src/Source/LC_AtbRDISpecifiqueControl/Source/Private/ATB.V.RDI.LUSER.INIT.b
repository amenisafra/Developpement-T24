* @ValidationCode : MjotMTY3Nzk5NTY2NTpDcDEyNTI6MTYyNDcxOTQ2MjE1OTpBTUVOSTotMTotMTowOjA6ZmFsc2U6Ti9BOlIyMF9TUDQuMDotMTotMQ==
* @ValidationInfo : Timestamp         : 26 Jun 2021 15:57:42
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
* Implementation of LC.AtbRDISpecifiqueControl.ATBIRDILUserInit
*
*
SUBROUTINE ATB.V.RDI.LUSER.INIT

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
    
****RG006 VALIDATION

    User = EB.SystemTables.getRUser()
    RecUser = EB.Security.User.Read(User, Error)

    USER.ID = RecUser<EB.Security.User.UseUserName>
    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.USER.INIT", POSUSER)
 
    LocalRef <1, POSUSER> = USER.ID
    EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LocalRef)
       

RETURN
