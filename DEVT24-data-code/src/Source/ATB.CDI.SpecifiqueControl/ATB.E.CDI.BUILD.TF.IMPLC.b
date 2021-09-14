* @ValidationCode : MjoxOTc2MjQ3NTc1OkNwMTI1MjoxNjMxNTM2MjQ4MTkxOkFNRU5JOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIwX1NQNC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 13 Sep 2021 13:30:48
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
* Implementation of ATB.CDI.SpecifiqueControl.AtbECDIBuildTfImpLc
*
* ENQ.DATA(INOUT) :
*
SUBROUTINE ATB.E.CDI.BUILD.TF.IMPLC(ENQ.DATA)

*   This routines is attached to enquiry TF.IMPLCEXPD to remove the
*   need for I & J Descriptors. Initially select is made on LC.TYPES to select
*   records based on the condition given in FIXED.SORT (for I & J descriptor fields).
*   Based on these LC.TYPES records, selection is made on LETTER.OF.CREDIT
*-----------------------------------------------------------------------------
* Modification History:
* 08/05/09 - BG_100023555
*            Replaced SELECT statement with DAS
*
* 15/06/09 - BG_100024133
*            Added a condition such that the CURRENT variable CURRENT.CUSTOMER is passed to the SELECT command
*
* 09/12/14 - Task   : 1182776
*            LC Componentization and Incorporation
*            Enhancement : 990544
*
* 29/10/18 - Task : 2831555
*            Componentization II - EB.DataAccess should be used instead of I_DAS.COMMON.
*            EB.DataAccess.DasAllIds should be used instead of DAS$ALL.IDS
*            Strategic Initiative : 2822484
*
*-----------------------------------------------------------------------------
    $INSERT I_DAS.LETTER.OF.CREDIT
    $INSERT I_DAS.LC.TYPES

    $USING LC.ModelBank
    $USING LC.Contract
    $USING EB.DataAccess


    COMMON/SYSTEM.VARIABLE.COMMON/System.variableNames, System.variableValues

    GOSUB INIT
    GOSUB GET.SELECTION.CRITERIA
    GOSUB PROCESS
RETURN

*--------------------------------------------------------------------
INIT:

*Initialise the variables


    LC.ID = ''
    LC.CURR = ''
    LC.CUST = ''
    ADV.BK.CUSTNO = ''
    ID.OPERAND = ''
    R.LC.REC = ''
    LC.ERR = ''
RETURN

*--------------------------------------------------------------------
GET.SELECTION.CRITERIA:

* Get selection criteria details

    ENQ.DATA.FIELDS = ENQ.DATA<2>
    E.DATA = ENQ.DATA<4>
    E.OPERAND = ENQ.DATA<3>

    CONVERT @VM TO @FM IN ENQ.DATA.FIELDS
    CONVERT @VM TO @FM IN E.DATA

    LOCATE '@ID' IN ENQ.DATA.FIELDS SETTING POS THEN
        LC.ID = E.DATA<POS>
        ID.OPERAND = E.OPERAND<POS>
    END

    LOCATE 'APPLICANT.CUSTNO' IN ENQ.DATA.FIELDS SETTING POS THEN
        LC.CUST = E.DATA<POS>
    END

    LOCATE 'LC.CURRENCY' IN ENQ.DATA.FIELDS SETTING POS THEN
        LC.CURR = E.DATA<POS>
    END

    LOCATE 'ADVISING.BK.CUSTNO' IN ENQ.DATA.FIELDS SETTING POS THEN
        ADV.BK.CUSTNO = E.DATA<POS>
    END
RETURN

*--------------------------------------------------------------------
PROCESS:

* Select records from LC.TYPES with the selection conditions given below in the select statement

    SELECTION.FIELDS = 'IMPORT.EXPORT':@VM:'DOC.COLLECTION':@VM:'CLEAN.CREDIT':@VM:'CLEAN.COLLECTION'
    SELECTION.OPERAND = 'EQ':@VM:'NE':@VM:'NE':@VM:'NE'
    SELECTION.VALUES = 'I':@VM:'YES':@VM:'YES':@VM:'YES'
    THE.ARGS<1> = SELECTION.FIELDS
    THE.ARGS<2> = SELECTION.OPERAND
    THE.ARGS<3> = SELECTION.VALUES
    THE.LIST = dasLcTypesImportExport
    EB.DataAccess.Das("LC.TYPES",THE.LIST,THE.ARGS,"")
    LC.TYPE.LIST = THE.LIST
    GOSUB FETCH.LC.RECORDS
RETURN

*--------------------------------------------------------------------
FETCH.LC.RECORDS:

* Call DAS for LC and fetch the necesary records based on the selection criteria
* Return list of LC records whose LC.TYPE match the list in LC.TYPE.LIST

    GOSUB CALL.DAS.LETTER.OF.CREDIT
    LOOP
        REMOVE LC.ID FROM THE.LIST SETTING LC.POS
    WHILE LC.ID:LC.POS

        R.LC.REC = LC.Contract.tableLetterOfCredit(LC.ID,LC.ERR)
        LC.TYPE = R.LC.REC<LC.Contract.LetterOfCredit.TfLcLcType>
        LOCATE LC.TYPE IN LC.TYPE.LIST SETTING LC.TYPE.POS THEN
            LC.IDS<1,-1> = LC.ID
        END
    REPEAT

    CONVERT @VM TO ' ' IN LC.IDS
    ENQ.DATA<2,1> = '@ID'
    ENQ.DATA<3,1> = 'EQ'
    ENQ.DATA<4,1> = LC.IDS
RETURN

*--------------------------------------------------------------------
CALL.DAS.LETTER.OF.CREDIT:

* Call DAS for LC

    SELECTION.FIELDS = ''
    SELECTION.VALUES = ''
    THE.ARGS = ''
    THE.LIST = ''
    IF LC.ID NE '' THEN
        SELECTION.FIELDS<1,-1> = '@ID'
        SELECTION.VALUES<1,-1> = LC.ID
        SELECTION.OPERANDS<1,-1> = ID.OPERAND
    END

    IF LC.CUST NE '' THEN
        SELECTION.FIELDS<1,-1> = 'APPLICANT.CUSTNO'
        SELECTION.VALUES<1,-1> = LC.CUST
        SELECTION.OPERANDS<1,-1> = 'EQ'
    END

    IF ADV.BK.CUSTNO NE '' THEN
        SELECTION.FIELDS<1,-1> = 'ADVISING.BK.CUSTNO'
        SELECTION.VALUES<1,-1> = ADV.BK.CUSTNO
        SELECTION.OPERANDS<1,-1> = 'EQ'
    END

    IF LC.CURR NE '' THEN
        SELECTION.FIELDS<1,-1> = 'LC.CURRENCY'
        SELECTION.VALUES<1,-1> = LC.CURR
        SELECTION.OPERANDS<1,-1> = 'EQ'
    END

    IF SELECTION.FIELDS NE '' THEN

        GOSUB GET.CURRENTVARIBLE.VALUE      ;* Searches for any CURRENT variable that is passed to the selection and
* gets the value by searching in the CURRENT variables that are assingned
* for the USER session

        THE.ARGS<1> = SELECTION.FIELDS
        THE.ARGS<2> = SELECTION.VALUES
        THE.ARGS<3> = SELECTION.OPERANDS
        THE.LIST = dasLetterOfCreditLcTypes
        EB.DataAccess.Das("LETTER.OF.CREDIT",THE.LIST,THE.ARGS,"")
    END ELSE
        THE.LIST = EB.DataAccess.DasAllIds
        EB.DataAccess.Das("LETTER.OF.CREDIT",THE.LIST,THE.ARGS,"")
    END
RETURN

*--------------------------------------------------------------------


************************
GET.CURRENTVARIBLE.VALUE:
************************

    Y.CURR.COUNT = DCOUNT(SELECTION.VALUES, @VM)

    FOR Y.COUNT = 1 TO Y.CURR.COUNT

        Y.CURR = LEFT(SELECTION.VALUES<Y.COUNT>,8)

        IF Y.CURR EQ '!CURRENT' THEN

            Y.CURR.VARIABLE = SELECTION.VALUES<Y.COUNT>

            Y.CURR.VARIABLE = FIELD(Y.CURR.VARIABLE, "!",2,1)

            LOCATE Y.CURR.VARIABLE IN System.variableNames SETTING CURR.POS THEN

                Y.CURR.VAL = System.variableValues<CURR.POS>

            END

            SELECTION.VALUES<Y.COUNT> = Y.CURR.VAL

        END

    NEXT Y.COUNT

RETURN

END

