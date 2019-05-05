
/***************************************************************************/
/*       Autor: Pablo Sao                                                  */
/*       Fecha: 22 de abril de 2018                                        */
/* Descripción: Promedio de dos valores de punto flotante                  */
/***************************************************************************/

.global main
.func main
main:
	LDR            R1, drFactor	@ Dirección del primer valor
	VLDR           S14, [R1]	@ Cargando valor
	VCVT.F64.F32   D8, S14		@ Convirtiendolo a 64 bits

	LDR            R1, drVal1	@ Dirección del primer valor
	VLDR           S14, [R1]	@ Cargando valor
	VCVT.F64.F32   D4, S14		@ Convirtiendolo a 64 bits

	LDR            R1, drVal2	@ Dirección del primer valor
	VLDR           S14, [R1]	@ Cargando valor
	VCVT.F64.F32   D5, S14		@ Convirtiendolo a 64 bits

	LDR            R1, drVal3	@ Dirección del primer valor
	VLDR           S14, [R1]	@ Cargando valor
	VCVT.F64.F32   D6, S14		@ Convirtiendolo a 64 bits

	LDR            R1, drVal4	@ Dirección del primer valor
	VLDR           S14, [R1]	@ Cargando valor
	VCVT.F64.F32   D7, S14		@ Convirtiendolo a 64 bits


	VADD.F64       D1,D4,D5		@ Se suma valor 1 y 2
	VADD.F64       D1,D1,D6		@ Se suma a la respuesta el valor 3
	VADD.F64       D1,D1,D7		@ Se suma a la respuesta el valor 4
	VDIV.F64       D0,D1,D8		@ dividimos el valor entre 4

	LDR            R0, =display	@ Dirección de formato de impresión
	VMOV           R2, R3, D0	@ cargamos el valor flotante
	BL             printf		@ imprimimos en pantalla

	MOV            R7, #1		@ Código para salida de assembler
	SWI            0

drVal1:
	.word val1
drVal2:
	.word val2
drVal3:
	.word val3
drVal4:
	.word val4

drFactor:
	.word factor


@****   Area de datos
.data
factor:
	.float 4.0

val1:
	.float 5.82734
val2:
	.float 2.03458
val3:
	.float 3.323412
val4:
	.float 4.02845


display:
	.asciz "Promedio: %f\n"
