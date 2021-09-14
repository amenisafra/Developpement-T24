* @ValidationCode : MjoxMDY3MzA1OTUwOkNwMTI1MjoxNjI5OTg4NTc5MTE5OkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 26 Aug 2021 15:36:19
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
* Implementation of LC.AtbRDISpecifiqueControl.AtbIntDao
*
* ENQ.DATA(INOUT) :
*
SUBROUTINE ATB.E.INT.DAO(ENQ.DATA)

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
    
    
    GOSUB INITIALISE
    GOSUB PROCESS
    
RETURN
 
INITIALISE:
  
    rUser = EB.SystemTables.getRUser()
    dao = rUser<EB.Security.User.UseDepartmentCode>
  
RETURN
 
PROCESS:
     
    ENQ.DATA<2,-1> = "L.DAO.INIT"
    ENQ.DATA<3,-1> = "EQ"
    ENQ.DATA<4,-1> = dao

RETURN
