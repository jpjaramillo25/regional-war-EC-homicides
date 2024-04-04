use "C:\Users\jpjar\OneDrive\Desktop\Asamblea MP\violencia.dta", clear

tsset codprov ao

gen lnhomicidios = ln(tasa_homicidios)

generate lnrural = ln(rural*100)

generate lnpobreza = ln(pobrezacenso*100)

xtline lnhomicidios

sum lnhomicidios c.lndis_puer1##c.lndroga lnpobreza lnrural lnpoblacion l.labs_droga l.plantaciones

corr lnhomicidios lndis_puer1 lndroga lnpobreza lnrural lnpoblacion l.labs_droga l.plantaciones

reg lnhomicidios lndroga lndis_puer1 lnpobreza lnrural lnpoblacion, vce (cluster codprov)

vif

***tabla modelo 1 a 6

xtreg lnhomicidios lndroga lndis_puer1, re vce (cluster codprov)
outreg2 using lapss.doc, replace ctitle(LnHomicides) keep(lndroga lndis_puer1 i.distancia3  lnpobreza lnrural lnpoblacion)

xtivreg lnhomicidios i.distancia3 (lndroga = l.labs_droga l.plantaciones tendencia), re vce (cluster codprov)
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(lndroga lndis_puer1 i.distancia3  lnpobreza lnrural lnpoblacion)


xtreg lnhomicidios lndroga lndis_puer1, re vce (cluster codprov) 
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(lndroga lndis_puer1 i.distancia3  lnpobreza lnrural lnpoblacion)

xtivreg lnhomicidios i.distancia3 (lndroga = l.labs_droga l.plantaciones tendencia), re vce (cluster codprov)
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(lndroga lndis_puer1 i.distancia3  lnpobreza lnrural lnpoblacion)

xtreg lnhomicidios lndroga lndis_puer1 lnpobreza lnrural lnpoblacion, re vce (cluster codprov) 
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(lndroga lndis_puer1 i.distancia3  lnpobreza lnrural lnpoblacion)

xtivreg lnhomicidios i.distancia3 lnpobreza lnrural lnpoblacion (lndroga = l.labs_droga l.plantaciones tendencia), re vce (cluster codprov)
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(lndroga lndis_puer1 i.distancia3  lnpobreza lnrural lnpoblacion)



*modelos con instrumento 

*modelo 1 y 2

*modelo 1
xtreg lnhomicidios lndroga lndis_puer1, re vce (cluster codprov)
outreg2 using lapss.doc, replace ctitle(LnHomicides) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion)



estimates store M1XT

xtreg lnhomicidios lndis_puer1 lndroga, re 
xttest0

*es con random effects

*modelo 2
xtivreg lnhomicidios lndis_puer1 (lndroga = l.labs_droga l.plantaciones tendencia), re vce (cluster codprov)
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion)



test lndroga
test lndroga = 0.3929925


estimates store M1IV
ivregress 2sls lnhomicidios lndis_puer1 (lndroga = l.labs_droga l.plantaciones tendencia)

test lndroga
test lndroga = 0.3929925

estat firststage
estat endogenous
estat overid




*hausman

xtreg lnhomicidios lndroga lndis_puer1 

estimates store M1XT_

xtivreg lnhomicidios lndis_puer1 (lndroga = l.labs_droga l.plantaciones tendencia)

estimates store M1IV_


hausman M1IV_ M1XT_


*modelo 3 y 4
xtivreg lnhomicidios i.distancia3 (lndroga = l.labs_droga l.plantaciones tendencia), re vce (cluster codprov)
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion)



test lndroga
test lndroga =  0.3929925

estimates store M2IV


ivregress 2sls lnhomicidios i.distancia3 (lndroga = l.labs_droga l.plantaciones tendencia)


estat firststage
estat endogenous
estat overid


xtreg lnhomicidios lndroga i.distancia3, re vce (cluster codprov)
estimates store M2XT


*hausman 

xtreg lnhomicidios lndroga i.distancia3

estimates store M2XT_

xtivreg lnhomicidios i.distancia3 (lndroga = l.labs_droga l.plantaciones tendencia)

estimates store M2IV_

hausman M2IV_ M2XT_


*modelo 5 y 6
xtivreg lnhomicidios c.lndis_puer1 lnpobreza lnrural lnpoblacion (lndroga = l.labs_droga l.plantaciones tendencia), re vce (cluster codprov)
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion)


test lndroga
test lndroga =   0.382435 


estimates store M3IV

ivregress 2sls lnhomicidios c.lndis_puer1 lnpobreza lnrural lnpoblacion (lndroga = l.labs_droga l.plantaciones tendencia)
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion)


estat firststage
estat endogenous
estat overid


xtreg lnhomicidios lndroga c.lndis_puer1 lnpobreza lnrural lnpoblacion, re vce (cluster codprov)

estimates store M3XT



*prueba de hausman
xtreg lnhomicidios lndroga c.lndis_puer1 lnpobreza lnrural lnpoblacion

estimates store M3XT_

predict predichos3
gen res3 = predichos - lnhomicidios
sfrancia res3
twoway scatter predichos3 res3
swilk res3

drop res3 predichos3

*Prueba de hausman

xtivreg lnhomicidios c.lndis_puer1 lnpobreza lnrural lnpoblacion (lndroga = l.labs_droga l.plantaciones tendencia)

estimates store M3IV_

test lndroga =  0.382435 

hausman M3IV_ M3XT_

*modelo 7 y 8
*********

*errores robustos
xtreg lnhomicidios c.lndis_puer1##c.lndroga lnpobreza lnrural lnpoblacion, re vce (cluster codprov)

outreg2 using lapss.doc, replace ctitle(LnHomicides) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion)



estimates store M4XT

predict predichos4
gen res4 = predichos4 - lnhomicidios
sfrancia res4
twoway scatter predichos4 res4
swilk res4

drop res4 predichos4

*variable instrumental y errores robustos

xtreg lndroga l.labs_droga l.plantaciones tendencia

outreg2 using lapss.doc, replace ctitle(lndroga) keep(l.labs_droga l.plantaciones tendencia)


predict lndroga_est

xtreg lnhomicidios c.lndis_puer1##c.lndroga_est lnpobreza lnrural lnpoblacion, re vce (cluster codprov)
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion)



estimates store M4IV


*grafico con variables continuas

qui margins, at( lndis_puer1 =(0(3)6) lndroga=(4(1)6)) atmeans

marginsplot


*hausman 

xtreg lnhomicidios c.lndis_puer1##c.lndroga lnpobreza lnrural lnpoblacion
estimates store M4XT_


xtreg lnhomicidios c.lndis_puer1##c.lndroga_est lnpobreza lnrural lnpoblacion
estimate store M4IV_


hausman M4IV_ M4XT_


*modelo 9 y 10
***********

*errores robustos xt

xtreg lnhomicidios i.distancia3##c.lndroga lnpobreza lnrural lnpoblacion, re vce (cluster codprov)
outreg2 using lapss.doc, append ctitle(LnHomicides) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion)



estimates store M5XT

margins i.distancia3, dydx(lndroga)


*instrumental
 
xtreg lnhomicidios i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion, re vce (cluster codprov)
xttest0 

outreg2 using lapss.doc, append ctitle(LnHomicides) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion)


estimate store M5IV

margins i.distancia3, dydx(lndroga)


*grafico con categoricas

interactplot, byplot cme bars(10) subplot(hist) level(95) scheme(s1mono)


xtreg lnhomicidios i.distancia3##c.lndroga lnpobreza lnrural lnpoblacion, re vce (cluster codprov)
estimates store M5XT



*prueba de hausman

xtreg lnhomicidios i.distancia3##c.lndroga lnpobreza lnrural lnpoblacion
estimates store M5XT_


xtreg lnhomicidios i.distancia3##c.lndroga_est lnpobreza lnrural lnpoblacion 
estimates store M5IV_

hausman M5IV_ M5XT_


*Modelos 1 a 6 sin instrumento y con instrumento con errores robustos

esttab M1XT M1IV M2XT M2IV M3XT M3IV, starlevels(* 0.10 ** 0.05 *** 0.01) stats(r2 N, fmt(%9.3f %9.0g)) b(%9.4f) se title (Determinantes de la tasa de homicidios) replace


*modelos 7 y 10 sin instrumento y con instrumento con errores robustos

esttab M4XT M4IV M5XT M5IV, starlevels(* 0.10 ** 0.05 *** 0.01) stats(r2 N, fmt(%9.3f %9.0g)) b(%9.4f) se title (Determinantes de la tasa de homicidios) replace


tsset codprov ao


******* robustes en diferencias en diferencias, dummy por cada region y por cada año

*modelo 11 y 12
*********

*errores robustos
xtreg lnhomicidios c.lndis_puer1##c.lndroga i.ao i.codprov lnpobreza lnrural lnpoblacion, re vce (cluster codprov)

outreg2 using lapss.doc, replace ctitle(LnHomicide_rate) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est)


estimates store M11

predict predichos4
gen res4 = predichos4 - lnhomicidios
sfrancia res4
twoway scatter predichos4 res4
swilk res4

drop res4 predichos4

*variable instrumental y errores robustos

xtreg lndroga l.labs_droga l.plantaciones tendencia


xtreg lnhomicidios c.lndis_puer1##c.lndroga_est i.ao i.codprov lnpobreza lnrural lnpoblacion, re vce (cluster codprov)

outreg2 using lapss.doc, append ctitle(LnHomicide_rate) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est)


estimates store M12


*grafico con variables continuas

qui margins, at( lndis_puer1 =(0(3)6) lndroga=(4(1)6)) atmeans

marginsplot


*hausman 

xtreg lnhomicidios c.lndis_puer1##c.lndroga i.ao i.codprov lnpobreza lnrural lnpoblacion
estimates store M11_


xtreg lnhomicidios c.lndis_puer1##c.lndroga_est i.ao i.codprov lnpobreza lnrural lnpoblacion
estimate store M12_


hausman M12_ M11_


*modelo 13 y 14
***********

*errores robustos xt

xtreg lnhomicidios i.distancia3##c.lndroga i.ao i.codprov lnpobreza lnrural lnpoblacion, re vce (cluster codprov)

outreg2 using lapss.doc, append ctitle(LnHomicide_rate) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est)


estimates store M13

margins i.distancia3, dydx(lndroga)


*instrumental
 
xtreg lnhomicidios i.distancia3##c.lndroga_est i.ao i.codprov lnpobreza lnrural lnpoblacion, re vce (cluster codprov)
xttest0 

outreg2 using lapss.doc, append ctitle(LnHomicide_rate) keep(c.lndis_puer1##c.lndroga c.lndis_puer1##c.lndroga_est i.distancia3##c.lndroga i.distancia3##c.lndroga_est)


estimate store M14

margins i.distancia3, dydx(lndroga)


*grafico con categoricas

interactplot, byplot cme bars(10) subplot(hist) level(95) scheme(s1mono)


xtreg lnhomicidios i.distancia3##c.lndroga i.ao i.codprov lnpobreza lnrural lnpoblacion, re vce (cluster codprov)
estimates store M13



*prueba de hausman

xtreg lnhomicidios i.distancia3##c.lndroga i.ao i.codprov lnpobreza lnrural lnpoblacion
estimates store M13_


xtreg lnhomicidios i.distancia3##c.lndroga_est i.ao i.codprov lnpobreza lnrural lnpoblacion
estimates store M14_

hausman M14_ M13_


*modelos 11 a 14 sin instrumento y con instrumento con errores robustos

esttab M11 M12 M13 M14, starlevels(* 0.10 ** 0.05 *** 0.01) stats(r2 N, fmt(%9.3f %9.0g)) b(%9.4f) se title (Determinantes de la tasa de homicidios) replace
