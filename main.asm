;*******************************************************************************
;    Nombre del archivo - main.asm                                             *
;    Autor:                                                                    *
;    Descripción:                                                              *
;        Este programa espera que se presione una tecla y luego enciende       *
;        un led.                                                               *
;*******************************************************************************
#include <p16f887.inc>
	
; Definición de constantes *****************************************************
#define PIN_LED1    PORTE,2
#define TRIS_LED1   TRISE,2
	
#define PIN_TEC1    PORTB,0
#define TRIS_TEC1   TRISB,0

; Bits de configuración ********************************************************
        __config _CONFIG1, 0x20F1       ; FOSC = XT, WDTE = OFF, MCLRE = ON
        __config _CONFIG2, 0x3FFF

; Definición de variables ******************************************************
        cblock   0x20                   ; Dirección de almacenamiento de datos
        delay_cont1
        delay_cont2
        endc
	
;*******************************************************************************
;    Inicio del programa                                                       *
;*******************************************************************************
        org     0x00                    ; Vector de reset
        nop
        goto    main

; Rutina principal - main ******************************************************	
main    call    gpio_config             ; Inicializo las entradas y salidas

        bcf     PIN_LED1                ; Apago el LED1
        btfsc   PIN_TEC1                ; Espero que se presione la TEC1
        goto    $-1
        bsf     PIN_LED1                ; Prendo el LED1

main_loop
        call    delay_10ms
        goto    main_loop               ; Super loop

; Subrutina - gpio_config ******************************************************
gpio_config
        banksel ANSEL                   ; Paso al banco 3
        clrf    ANSEL                   ; Configuro todos los pines
        clrf    ANSELH                  ;   como digitales

        banksel TRISB                   ; Paso al banco 1
        bsf     TRIS_TEC1               ; Configuro la TEC1 como entrada
        bcf     TRIS_LED1               ; Configuro el LED1 como salida

        banksel PORTB                   ; Paso al banco 0
        return
	
; Subrutina - delay 10 ms ******************************************************
;    tiempo = 1280 * (cont2 - 1) + 5 * (cont1 - 1) + 10
delay_10ms
        movlw   d'207'
        movwf   delay_cont1
        movlw   d'8'
        movwf   delay_cont2

delay_10ms_loop
        decfsz  delay_cont1,f
        goto    $+2
        decfsz  delay_cont2,f
        goto    delay_10ms_loop
        return
	
;*******************************************************************************
;    Fin del programa                                                          *
;*******************************************************************************
        end


