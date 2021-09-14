* @ValidationCode : MjotNDMyOTU5MTAyOkNwMTI1MjoxNjIzNzkzMDM2NzEwOkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 15 Jun 2021 22:37:16
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
* Implementation of ATB.CDI.SpecifiqueControl.ATBICDIDao
*
*
SUBROUTINE ATB.V.CDI.DAO
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
    
****RG003


    User   = EB.SystemTables.getRUser()
    USERID =  EB.SystemTables.getOperator()

    
    RecUser = EB.Security.User.Read(User, Error)
    
    DeptCode = RecUser<EB.Security.User.UseDepartmentCode>
       

    EB.LocalReferences.GetLocRef("LETTER.OF.CREDIT", "L.DAO.INIT", posDAO)
    LOCREFSET<1, posDAO> = DeptCode
    EB.SystemTables.setRNew(LC.Contract.LetterOfCredit.TfLcLocalRef, LOCREFSET)
    

RETURN
