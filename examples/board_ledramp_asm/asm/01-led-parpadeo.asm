;;; Parpadeo (con retardo de aprox 1 seg).

;; para mayor legibiliad del código
; puerto B
.equ    DDRB,   0x04
.equ    PORTB,  0x05

; registros
;.equ   r16,    0x10
;.equ   R1,     0x11
;.equ   R2,     0x12


.text
.global inicio

.org 0x0000     ; directiva “.org” indica una posición de memoria


cli
; oscilador de 16 Mhz (16000000)


inicio:
    nop

; Configuración de puertos:
    ldi     r16, 0xFF
    mov     DDRB, r16
;valores iniciales para el puerto
    ldi     r16, 0x10
    mov     PORTB, r16
    mov     r1, r16             ;value led

alterna_portb:
    ;mov     r1, PORTB
    inc     r1
    out     PORTB, r1
    mov     PORTB, r1

pausa1:
    ;acá va una pausa de 0.5 segundo
    ; ejecutar 8 000 000 de instrucciones
    ; 12 * 456960 (oxFFFF)
    ldi     r16, 0xF4       ; más significativo
    ldi     r17, 0x24
    ldi     r18, 0x00       ; menos significativo


;Inicia el ciclo de decrementos
; ciclo 1 es el más interno (menos significativo).
; Cada ejecución son 5 instrucciones y 7/8 ciclos de reloj.
; 1792 instrucciones, al decrementar el registro R2 de 0xFF a 0x00.
ciclo_1:
    nop
    cpi     r18, 0x00   ; (compare, skip if iqual) si es cero salta la siguiente instrucción
    breq    ciclo_2
    dec     r18
    jmp     ciclo_1     ; 3 ciclos de reloj.

; 5 instrucciones, 7/8 ciclos de reloj que se ejecutan cada 256 ciclos.
; vuelve a cargar el registro 0xFF
; 456960 instrucciones al decrementar el r17 de 0xFF a0x00 (incluye ciclo_1)
ciclo_2:
    cpi     r17, 0x00
    breq    ciclo_3
    dec     r17
    ldi     r18, 0xFF
    jmp     ciclo_1

ciclo_3:
    cpi     r16, 0x00
    breq    ciclo_fin
    dec     r16
    ldi     r17, 0xFF
    ldi     r18, 0xFF
    jmp     ciclo_1

ciclo_fin:
    nop



; vuelve a comenzar desde al cambio de valor de los pines
    rjmp    alterna_portb    ; ciclo eterno.
