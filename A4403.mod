$PROBLEM TWO COMPARTMENT ORAL

$DATA pk_oral2_30_90.csv IGNORE=#

$INPUT ID TIME AMT DV MDV  

$SUBROUTINE ADVAN4 TRANS4

$PK
  CL    = THETA(1)*EXP(ETA(1)) ;CL/F
  V2    = THETA(2)*EXP(ETA(2)) ;V2/F
  Q     = THETA(3)*EXP(ETA(3)) ;Q/F
  V3    = THETA(4)*EXP(ETA(4)) ;V3/F
  KA    = THETA(5)*EXP(ETA(5)) ;Absorption rate constant
  ALAG1 = THETA(6)*EXP(ETA(6)) ;Lag time

$ERROR
  IPRED   = F
  W       = SQRT(THETA(7)**2 + THETA(8)**2 * IPRED**2); additive plus proportional error model
  IRES    = DV - IPRED
  IWRES   = IRES / W
  Y       = IPRED + W * EPS(1)

$THETA
  (0,100);POPCL/F
  (0,700);POPV/F
  (0,70) ;POPQ/F
  (0,500);POPV3/F
  (0,10) ;POPKA
  (0,1)  ;POPALAG1
  10
  0.5

$OMEGA
  .25 ;CL
  .25 ;V2
  .25 ;Q
  .25 ;V3
  0 FIX ;KA
  0 FIX ;ALAG1

$SIGMA
  1 FIX ;ERRCV
 
;$ESTIMATION METHOD=1 POSTHOC MAXEVAL=9999 PRINT=5 
$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 INTER PRINT=10 SIGDIGITS=3

$COVARIANCE PRINT=E

$TABLE ID TIME IPRED IWRES DV NOPRINT ONEHEADER FILE=sdtab4403
$TABLE ID CL V2 Q V3 KA ALAG1 NOPRINT ONEHEADER NOAPPEND FILE=patab4403

