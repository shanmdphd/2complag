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
  (0,100);CL
  (0,700);V2
  (0,70) ;Q
  (0,500);V3
  (0,10) ;KA
  (0,1)  ;ALAG1
  0.0001 FIX
  0.2

$OMEGA
  .25 ;CL
  .25 ;V2
  .25 ;Q
  .25 ;V3
  .25 ;KA
  .25 ;ALAG1

$SIGMA
  1 FIX ;ERRCV
 
;$ESTIMATION METHOD=1 POSTHOC MAXEVAL=9999 PRINT=5 
$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 INTER PRINT=10 SIGDIGITS=3

$COVARIANCE PRINT=E

$TABLE ID TIME IPRED IWRES DV NOPRINT ONEHEADER FILE=sdtab4403
$TABLE ID CL V2 Q V3 KA ALAG1 NOPRINT ONEHEADER NOAPPEND FILE=patab4403

