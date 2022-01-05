$PROBLEM TWO COMPARTMENT ORAL

$DATA pk_oral2.CSV IGNORE=#

$INPUT ID TIME	AMT	DV	MDV	 

$SUBROUTINE ADVAN4 TRANS4

$PK
  CL    = THETA(1)*EXP(ETA(1)) ;CL/F
  V2    = THETA(2)*EXP(ETA(2)) ;V2/F
  Q     = THETA(3)*EXP(ETA(3)) ;Q/F
  V3    = THETA(4)*EXP(ETA(4)) ;V3/F
  KA    = THETA(5)*EXP(ETA(5)) ;Absorption rate constant
  ALAG1 = THETA(6)*EXP(ETA(6)) ;Lag time
  S2    = V2/1000  ;Scaling factor
  S3    = V3/1000  ;Scaling factor

$ERROR
  IPRED   = F
  W       = SQRT(THETA(7)**2 + THETA(8)**2 * F**2); SIGMA 1 FIX (additive plus proportional error model)
  IRES    = DV - IPRED
  IWRES   = IRES / W
  Y       = IPRED + W * EPS(1)

$THETA
  (0,100) ;POPCL/F
  (0,700) ;POPV/F
  (0,70) ;POPQ/F
  (0,500) ;POPV3/F
  (0,1) ;POPKA
  (0,1) ;POPALAG1
  10
  .5

$OMEGA
  .25 ;BSVCL/F
  .25 ;BSVV/F
  0 FIX ;BSVQ/F
  .25 ;BSVV3/F
  .25 ;BSVKA
  .25 ;BSVALAG1

$SIGMA
  1 FIX ;ERRCV
 
$ESTIMATION METHOD=0 POSTHOC MAXEVAL=9999 PRINT=5 

$COVARIANCE PRINT=E

$TABLE ID TIME IPRED IWRES DV
       FILE=sdtab4402 NOPRINT ONEHEADER

