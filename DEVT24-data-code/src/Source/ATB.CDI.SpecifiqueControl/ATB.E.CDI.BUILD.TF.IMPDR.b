* @ValidationCode : Mjo5NDI4NzA1MDI6Q3AxMjUyOjE2MzE1MzY0OTAzMTE6QU1FTkk6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjBfU1A0LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 13 Sep 2021 13:34:50
* @ValidationInfo : Encoding          : Cp1252
* @ValidationInfo : User Name         : AMENI
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : R20_SP4.0
* test build jenkins
$PACKAGE ATB.CDI.SpecifiqueControl
*
* Implementation of ATB.CDI.SpecifiqueControl.AtbECDIBuildTfImpDr
*
* ENQ.DATA(INOUT) :
*
SUBROUTINE ATB.E.CDI.BUILD.TF.IMPDR(ENQ.DATA)

*   This routines is attached to enquiries (TF.IMPACDUE, TF.IMPACDUEDISC, TF.IMPDR.TRUSTREL, TF.IMBILLCOLL) to remove the
*   need for I & J Descriptors. Initially select is made on LC.TYPES to select
*   records based on the condition given in FIXED.SORT (for I & J descriptor fields).
*   Based on these LC.TYPES records, selection is made on DRAWINGS
*-----------------------------------------------------------------------------
* Modification History
*
*
* 09/12/14 - Task   : 1083470
*            LC Componentization and Incorporation
*            Enhancement : 990544
* 21/05/2015 - Task - 1351158
*              When operands less than and greater are input in selection criteria for enquiry TF.IMPACDUE, System fails to fetch the transactions.
*              Defect - 1348143
*
*   30/06/15 - Task : 1394620
*              Operand between is not displayed in the drop down.
*              Ref : 1389820
*
* 29/10/18 - Task : 2831555
*            Componentization II - EB.DataAccess should be used instead of I_DAS.COMMON.
*            EB.DataAccess.DasAllIds should be used instead of DAS$ALL.IDS
*            Strategic Initiative : 2822484
*
*-----------------------------------------------------------------------------
    $INSERT I_DAS.DRAWINGS
    $INSERT I_DAS.LC.TYPES

    $USING EB.Reports
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

* Initialise the variables

    DR.ID = ''
    DR.CURR = ''
    DR.CUST = ''
    ADV.CUST = ''
    ID.OPERAND = ''
    R.DR.REC = ''
    DR.ERR = ''
    DR.TYPE = ''
    MAT.POS=''
RETURN

*--------------------------------------------------------------------
GET.SELECTION.CRITERIA:

* Get selection criteria details

    ENQ.DATA.FIELDS = ENQ.DATA<2>
    E.DATA = ENQ.DATA<4>
    E.OPERAND = ENQ.DATA<3>

    CONVERT @VM TO @FM IN ENQ.DATA.FIELDS
    CONVERT @VM TO @FM IN E.DATA

    LOCATE '@ID' IN ENQ.DATA.FIELDS SETTING ID.POS THEN
        DR.ID = E.DATA<ID.POS>
        ID.OPERAND = E.OPERAND<1,ID.POS>
    END

    LOCATE 'CUSTOMER.LINK' IN ENQ.DATA.FIELDS SETTING POS THEN
        DR.CUST = E.DATA<POS>
    END

    LOCATE 'MATURITY.REVIEW' IN ENQ.DATA.FIELDS SETTING MAT.POS THEN
        MAT.REV = E.DATA<MAT.POS>
    END

    LOCATE 'DRAWING.TYPE' IN ENQ.DATA.FIELDS SETTING POS THEN
        DR.TYPE = E.DATA<POS>
    END

    LOCATE 'DRAW.CURRENCY' IN ENQ.DATA.FIELDS SETTING POS THEN
        DR.CCY = E.DATA<POS>
    END

RETURN

*--------------------------------------------------------------------

PROCESS:



* Select LC.TYPES records based on fixed selection

    SELECTION.FIELDS = 'IMPORT.EXPORT':@VM:'DOC.COLLECTION':@VM:'CLEAN.CREDIT':@VM:'CLEAN.COLLECTION'
    SELECTION.OPERAND = 'EQ':@VM:'NE':@VM:'NE':@VM:'NE'
    SELECTION.VALUES = 'I':@VM:'YES':@VM:'YES':@VM:'YES'
    THE.ARGS<1> = SELECTION.FIELDS
    THE.ARGS<2> = SELECTION.OPERAND
    THE.ARGS<3> = SELECTION.VALUES

    THE.LIST = dasLcTypesImportExport
    EB.DataAccess.Das("LC.TYPES",THE.LIST,THE.ARGS,"")

    LC.TYPE.LIST = THE.LIST
    GOSUB FETCH.DRAWINGS.RECORDS
RETURN

*--------------------------------------------------------------------
FETCH.DRAWINGS.RECORDS:

* Call DAS for DRAWINGS and fetch the necesary records based on the selection criteria
* Return list of DRAWINGS records whose LC.TYPE match the list in LC.TYPE.LIST

    GOSUB CALL.DAS.DRAWINGS
    LOOP
        REMOVE DR.ID FROM THE.LIST SETTING DR.POS
    WHILE DR.ID:DR.POS
        R.DR.REC = LC.Contract.tableDrawings(DR.ID, DR.ERR)
  
        DR.TYPE = R.DR.REC<LC.Contract.Drawings.TfDrLcCreditType>
        LOCATE DR.TYPE IN LC.TYPE.LIST SETTING LC.TYPE.POS THEN
            DR.IDS<1,-1> = DR.ID
        END
    REPEAT

    CONVERT @VM TO ' ' IN DR.IDS
    ENQ.DATA<2,ID.POS> = '@ID'
    ENQ.DATA<3,ID.POS> = 'EQ'
    ENQ.DATA<4,ID.POS> = DR.IDS
RETURN

*--------------------------------------------------------------------

CALL.DAS.DRAWINGS:

* Call DAS for DRAWINGS

    SELECTION.FIELDS = ''
    SELECTION.VALUES = ''
    THE.ARGS = ''
    THE.LIST = ''

    IF DR.ID NE '' THEN
        SELECTION.FIELDS<1,-1> = '@ID'
        SELECTION.VALUES<1,-1> = DR.ID
        SELECTION.OPERANDS<1,-1> = ID.OPERAND
    END

    IF DR.CUST NE '' THEN
        SELECTION.FIELDS<1,-1> = 'CUSTOMER.LINK'
        SELECTION.VALUES<1,-1> = DR.CUST
        SELECTION.OPERANDS<1,-1> = 'EQ'
    END

    IF DR.CURR NE '' THEN
        SELECTION.FIELDS<1,-1> = 'DRAW.CURRENCY'
        SELECTION.VALUES<1,-1> = DR.CURR
        SELECTION.OPERANDS<1,-1> = 'EQ'
    END

    IF MAT.REV NE '' THEN
        IF E.OPERAND<1,MAT.POS> EQ 'RG' THEN      ;* check operand
*If operand is RG then to set AND joins in DAS pass selection fields, selection values and selection operands as below
            SELECTION.FIELDS<1,-1> = 'MATURITY.REVIEW'      ;*Set selection fields
            SELECTION.FIELDS<1,-1> = 'MATURITY.REVIEW'
            SELECTION.VALUES<1,-1> = FIELD(MAT.REV,' ',1) ;*Set selection values
            SELECTION.VALUES<1,-1> = FIELD(MAT.REV,' ',2)
            SELECTION.OPERANDS<1,-1> = 'GT'       ;*Set selection operands
            SELECTION.OPERANDS<1,-1> = 'LT'
        END ELSE
            SELECTION.FIELDS<1,-1> = 'MATURITY.REVIEW'
            SELECTION.VALUES<1,-1> = MAT.REV
            SELECTION.OPERANDS<1,-1> =E.OPERAND<1,MAT.POS>  ;*To use operand LT and GT in Enquiry TF.IMPACDUE
        END
    END

    IF DR.TYPE NE '' THEN
        SELECTION.FIELDS<1,-1> = 'DRAWING.TYPE'
        SELECTION.VALUES<1,-1> = DR.TYPE
        SELECTION.OPERANDS<1,-1> = 'EQ'
    END

    IF SELECTION.FIELDS NE '' THEN

        GOSUB GET.CURRENTVARIBLE.VALUE  ;* Searches for any CURRENT variable that is passed to the selection and
* gets the value by searching in the CURRENT variables that are assigned
* for the USER session

        THE.ARGS<1> = SELECTION.FIELDS
        THE.ARGS<2> = SELECTION.VALUES
        THE.ARGS<3> = SELECTION.OPERANDS
        THE.LIST = dasDrawingsLcTypes
        EB.DataAccess.Das("DRAWINGS",THE.LIST,THE.ARGS,"")

    END ELSE
        THE.LIST = EB.DataAccess.DasAllIds
        EB.DataAccess.Das("DRAWINGS",THE.LIST,THE.ARGS,"")
    END
RETURN



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

