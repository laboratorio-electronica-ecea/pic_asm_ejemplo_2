;*******************************************************************************
;    Nombre del archivo - main.asm                                             *
;    Autor:                                                                    *
;    Descripción:                                                              *
;        Este programa utiliza una subrutina para togglear el bit 7 de una     *
;        variable llamada "dato".                                              *
;    Consigna:                                                                 *
;        Escribir nombre y apellido en este encabezado.                        *
;        Compilar y simular el programa.                                       *
;*******************************************************************************
#include <p16f887.inc>

; Bits de configuración ********************************************************
        __config _CONFIG1, 0x20F1       ; FOSC = XT, WDTE = OFF, MCLRE = ON
        __config _CONFIG2, 0x3FFF

; Definición de variables ******************************************************
        cblock   0x20                   ; Dirección de almacenamiento de datos
        dato
        endc
	
;*******************************************************************************
;    Inicio del programa                                                       *
;*******************************************************************************
        org     0x00                    ; Vector de reset
        nop
        goto    main

; Rutina principal - main ******************************************************	
main    nop                             ; No hay nada que inicializar

main_loop
        call    toggle_bit              ; Llamo a una subrutina
        goto    main_loop               ; Super loop

; Subrutina - toggle_bit *******************************************************
toggle_bit
        movlw   b'00100000'             ; Pongo 1 en la posición a togglear
        xorwf   dato,f                  ; dato = dato .XOR. W
        return                          ; Vuelvo al programa principal
	
;*******************************************************************************
;    Fin del programa                                                          *
;*******************************************************************************
        end


