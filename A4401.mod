$PROBLEM TWO COMPARTMENT ORAL

$DATA pk_oral2_30_90.csv IGNORE=#

$INPUT ID TIME	AMT	DV	MDV	 


$SUBROUTINE ADVAN4 TRANS4
$PK
  CL = THETA(1) * EXP(ETA(1))
  V2 = THETA(2) * EXP(ETA(2))
  V3 = THETA(3) * EXP(ETA(3))
  Q = THETA(4) * EXP(ETA(4))
  KA = THETA(5) * EXP(ETA(5))
  
  KE = CL/V2
  K12 = Q/V2
  K21 = Q/V3

$ERROR
  IPRED = F
  W = SQRT(THETA(6)**2 + THETA(7)**2 * IPRED**2)
  IRES = DV - IPRED
  IWRES = IRES / W
  Y = IPRED + W * EPS(1)

$THETA
  (0, 2.3 , 30)
  (0, 2.2, 100)
  (0, 2.4, 300)
  (0, 2.7, 20)
  (0, 2.13, 5)
  0.001 FIX
  (0, 0.3, 1)
$OMEGA
  0.04
  0.04
  0 FIX
  0 FIX
  0 FIX
$SIGMA
  1 FIX

 
;$ESTIMATION METHOD=0 POSTHOC MAXEVAL=9999 PRINT=5 
$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 INTER PRINT=10 SIGDIGITS=3

$COVARIANCE PRINT=E

$TABLE ID TIME IPRED IWRES DV NOPRINT ONEHEADER FILE=sdtab4401
$TABLE ID CL V2 Q V3 KA NOPRINT ONEHEADER FILE=patab4401

