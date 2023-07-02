ConvertirNumeroCadena MACRO val1, val2 
        LOCAL L_DIV, L_ALM, L_CERO, L_FIN
        ;;inicializar registros
        mov AX, val1 
        lea SI, val2 
        mov DX, 0000
        mov CX, 0000
        mov BX, 000a ;base 10

        ;verificar val1
        cmp AX, 0000
        je L_CERO

        L_DIV: 
            cmp AX, 00
            je L_ALM
            div BX 
            push DX 
            inc CX 
            xor DX, DX
            jmp L_DIV
        L_ALM:
            pop DX
            add DX, 30 ;;SUMAMOS 30 PARA CONVERTIR EL NUMERO
            mov [SI], DL 
            inc SI
            loop L_ALM
            jmp L_FIN
        L_CERO:
            mov DL, 30
            mov [SI], DL
        L_FIN:

   ENDM
NADA        equ      00
JUGADOR     equ      01
PARED       equ      02
CAJA        equ      03
OBJETIVO    equ      04
SUELO       equ      05 
.model small
.radix 16
.stack
.data
dim_sprite_jug    db   08, 08
data_sprite_jug   db   02, 02, 04, 04, 04, 02, 02, 02
                  db   02, 02, 04, 04, 04, 04, 02, 02
                  db   02, 02, 42, 42, 42, 00, 02, 02
                  db   02, 02, 42, 42, 42, 42, 42, 02
                  db   02, 04, 20, 04, 04, 20, 04, 02
                  db   02, 04, 0e, 20, 20, 0e, 04, 02
                  db   02, 42, 20, 02, 02, 20, 42, 02
                  db   02, 06, 06, 02, 02, 06, 06, 02

dim_sprite_suelo  db   08, 08
data_sprite_suelo db   02, 02, 02, 02, 02, 02, 02, 02
                  db   02, 02, 02, 02, 02, 02, 02, 02
                  db   02, 02, 02, 02, 02, 02, 02, 02
                  db   02, 02, 02, 02, 02, 02, 02, 02
                  db   02, 02, 02, 02, 02, 02, 02, 02
                  db   02, 02, 02, 02, 02, 02, 02, 02
                  db   02, 02, 02, 02, 02, 02, 02, 02
                  db   02, 02, 02, 02, 02, 02, 02, 02

dim_sprite_pared  db   08, 08
data_sprite_pared db   35, 35, 0f, 0f, 35, 35, 0f, 0f
                  db   35, 0f, 0f, 35, 35, 0f, 0f, 35
                  db   0f, 0f, 35, 35, 0f, 0f, 35, 35
                  db   0f, 35, 35, 0f, 0f, 35, 35, 0f
                  db   35, 35, 0f, 0f, 35, 35, 0f, 0f
                  db   35, 0f, 0f, 35, 35, 0f, 0f, 35
                  db   0f, 0f, 35, 35, 0f, 0f, 35, 35
                  db   0f, 35, 35, 0f, 0f, 35, 35, 0f

dim_sprite_obj   db   08, 08
data_sprite_obj   db  02,02,00,0e,02,02,02,02
                  db  02,02,00,0e,0e,02,02,02
                  db  02,02,00,0e,0e,0e,02,02
                  db  02,02,00,0e,0e,0e,0e,02
                  db  02,02,00,0e,0e,0e,0e,0e
                  db  02,02,00,02,02,02,02,02
                  db  02,02,00,02,02,02,02,02
                  db  02,02,00,02,02,02,02,02

dim_sprite_caja   db   08, 08
data_sprite_caja  db  02,02,02,06,06,02,02,02
                  db  02,06,06,06,06,06,06,02
                  db  06,06,00,42,42,00,06,06
                  db  06,06,06,42,42,06,06,06
                  db  06,06,06,06,06,06,06,06
                  db  02,06,42,42,42,42,06,02
                  db  02,00,00,02,02,00,00,02
                  db  02,00,00,02,02,00,00,02

dim_sprite_vacio  db   08, 08
data_sprite_vacio db   00, 00, 00, 00, 00, 00, 00, 00
                  db   00, 00, 00, 00, 00, 00, 00, 00
                  db   00, 00, 00, 00, 00, 00, 00, 00
                  db   00, 00, 00, 00, 00, 00, 00, 00
                  db   00, 00, 00, 00, 00, 00, 00, 00
                  db   00, 00, 00, 00, 00, 00, 00, 00
                  db   00, 00, 00, 00, 00, 00, 00, 00
                  db   00, 00, 00, 00, 00, 00, 00, 00

dim_sprite_flcha  db   08, 08
data_sprite_flcha   db   00, 00, 28, 00, 00, 00, 00, 00
                    db   00, 00, 28, 28, 00, 00, 00, 00
                    db   28, 28, 28, 28, 28, 00, 00, 00
                    db   28, 28, 28, 28, 28, 28, 00, 00
                    db   28, 28, 28, 28, 28, 28, 00, 00
                    db   28, 28, 28, 28, 28, 00, 00, 00
                    db   00, 00, 28, 28, 00, 00, 00, 00
                    db   00, 00, 28, 00, 00, 00, 00, 00

mapa              db   3e8 dup (0)

;Definir datos
iniciar_juego db "INICIAR JUEGO$"
cargar_nivel  db "CARGAR NIVEL$"
configuracion db "CONFIGURACION$"
puntajes      db "PUNTAJES ALTOS$"
salir         db "SALIR$"
iniciales     db "CJMP - 201709282$"
;; JUEGO
xJugador      db 0
yJugador      db 0
puntos        dw 0
;; MENÚS
opcion3       db 0
opcion2       db 0
opcion        db 0
maximo        db 0
xFlecha       dw 0
yFlecha       dw 0
;; CONTROLES
control_arriba    db  48
control_abajo     db  50
control_izquierda db  4b
control_derecha   db  4d
control_f2        db  3c
;; NIVELES
nivel_1           db  "vacas/pro2/NIV.00",00
nivel_x           db  "vacas/pro2/NIV.TXT",00
handle_nivel      dw  0000
linea             db  100 dup (0)
elemento_actual   db  0
xElemento         db  0
yElemento         db  0
;; TOKENS
tk_pared      db  05,"pared"
tk_suelo      db  05,"suelo"
tk_jugador    db  07,"jugador"
tk_caja       db  04,"caja"
tk_objetivo   db  08,"objetivo"
tk_coma       db  01,","
;;
numero        db  5 dup (30)

;;MENU DE CONFIGURACION
tit_configuracion db "Controles actuales$"
tit_up db "Arriba: $"
tit_dw db "Abajo: $"
tit_lf db "Izquierda: $"
tit_rt db "Derecha: $"
val_up db "FLECHA ARRIBA   $"
val_dw db "FLECHA ABAJO    $"
val_lf db "FLECHA IZQUIERDA$"
val_rt db "FLECHA DERECHA  $"

;;TECLAS DEL TECLADO PARA LOS CONTROLES
arrow_up db "FLECHA ARRIBA   $"
arrow_dw db "FLECHA ABAJO    $"
arrow_lf db "FLECHA IZQUIERDA$"
arrow_rt db "FLECHA DERECHA  $"


caracter_teclado db 0
caracter_teclado_aux db 0

promp_up db "INGRESA EL NUEVO CONTROL ARRIBA: $"
promp_dw db "INGRESA EL NUEVO CONTROL ABAJO: $"
promp_lf db "INGRESA EL NUEVO CONTROL IZQUIERDA: $"
promp_rt db "INGRESA EL NUEVO CONTROL DERECHA: $"

opt_controles db "Cambiar controles$"
opt_regresar db "Regresar$"

;;MENU DE PAUSA
menu_pausa_tit db "PAUSA$"
continuar_juego db "CONTINUAR$"
salir_menu db "REGRESAR AL MENU$"

finalizacion db "                $"

.code
;;definir seccion de codigo
    main proc 
        mov AX, @data
        mov DS, AX
        inicio:
        int 03
            ;; MODO VIDEO ;;
            mov AH, 00
            mov AL, 13
            int 10
            jmp menu_inicial
    main endp
    menu_inicial proc
            ;;;;;;;;;;;;;;;;
            call menu_principal
            mov AL, [opcion]
            ;; > INICIAR JUEGO
            cmp AL, 0
            je ciclo_juego
            ;; > CARGAR NIVEL
            cmp AL, 1
            je cargar_un_nivel
            ;; > CONFIGURACION
            cmp AL, 2
            je opciones_menu_configuracion
            ;; > PUNTAJES ALTOS
            ;; > SALIR
            cmp AL, 4
            je fin
            ;;;;;;;;;;;;;;;;
    menu_inicial endp

    ;;Ciclo infinito que permite el desarrollo del juego
    ciclo_juego proc
        call pintar_mapa
		call entrada_juego
		jmp ciclo_juego
    ciclo_juego endp

        ;; menu_principal - menu principal
    ;; ..
    ;; SALIDA
    ;;    - [opcion] -> código numérico de la opción elegida
    menu_principal proc 
        call clear_pantalla
        mov AL, 0
        mov [opcion], AL      ;; reinicio de la variable de salida
        mov AL, 5
        mov [maximo], AL
        mov AX, 50
        mov BX, 28
        mov [xFlecha], AX
        mov [yFlecha], BX
        ;; IMPRIMIR OPCIONES ;;
        ;;;; INICIAR JUEGO
        mov DL, 0c
        mov DH, 05
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset iniciar_juego
        mov AH, 09
        int 21
        pop DX
        ;;
        ;;;; CARGAR NIVEL
        add DH, 02
        mov BH, 00
        mov AH, 02
        int 10
        push DX
        mov DX, offset cargar_nivel
        mov AH, 09
        int 21
        pop DX
        ;;
        ;;;; CONFIGURACION
        add DH, 02
        mov BH, 00
        mov AH, 02
        int 10
        push DX
        mov DX, offset configuracion
        mov AH, 09
        int 21
        pop DX
        ;;
        ;;;; PUNTAJES ALTOS
        add DH, 02
        mov BH, 00
        mov AH, 02
        int 10
        push DX
        mov DX, offset puntajes
        mov AH, 09
        int 21
        pop DX
        ;;
        
        ;;;; SALIR
        add DH, 02
        mov BH, 00
        mov AH, 02
        int 10
        push DX
        mov DX, offset salir
        mov AH, 09
        int 21
        pop DX
        ;;;;
        call pintar_flecha
        ;;;;
        ;; LEER TECLA
        ;;;;
        entrada_menu_principal:
                mov AH, 00
                int 16
                cmp AH, 48
                je restar_opcion_menu_principal
                cmp AH, 50
                je sumar_opcion_menu_principal
                cmp AH, 3b  ;; le doy F1
                je fin_menu_principal
                jmp entrada_menu_principal
        restar_opcion_menu_principal:
                mov AL, [opcion]
                dec AL
                cmp AL, 0ff
                je volver_a_cero
                mov [opcion], AL
                jmp mover_flecha_menu_principal
        sumar_opcion_menu_principal:
                mov AL, [opcion]
                mov AH, [maximo]
                inc AL
                cmp AL, AH
                je volver_a_maximo
                mov [opcion], AL
                jmp mover_flecha_menu_principal
        volver_a_cero:
                mov AL, 0
                mov [opcion], AL
                jmp mover_flecha_menu_principal
        volver_a_maximo:
                mov AL, [maximo]
                dec AL
                mov [opcion], AL
                jmp mover_flecha_menu_principal
        mover_flecha_menu_principal:
                mov AX, [xFlecha]
                mov BX, [yFlecha]
                mov SI, offset dim_sprite_vacio
                mov DI, offset data_sprite_vacio
                call pintar_sprite
                mov AX, 50
                mov BX, 28
                mov CL, [opcion]
        ciclo_ubicar_flecha_menu_principal:
                cmp CL, 0
                je pintar_flecha_menu_principal
                dec CL
                add BX, 10
                jmp ciclo_ubicar_flecha_menu_principal
        pintar_flecha_menu_principal:
                mov [xFlecha], AX
                mov [yFlecha], BX
                call pintar_flecha
                jmp entrada_menu_principal
                ;;
        fin_menu_principal:
                ret
    menu_principal endp

    cambio_controles proc
        call clear_pantalla
        ;; INGRESAR NUEVOS CONTROLES ;;
        ;;;; SOLICITAR CONTROL DE LA DERECHA
        mov DL, 02
        mov DH, 05
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset promp_rt 
        mov AH, 09
        int 21
        pop DX

        ;;CONFIGURAR CONTROL DE LA DERECHA
        ;;LEER INGRESO DE TECLADO
        mov AH, 00
        int 16
        PUSH AX
        call validar_nuevo_control

        POP AX
        cmp AH, 48
        jne no_finalizacion_derecha 
        cmp AH, 4b
        jne no_finalizacion_derecha
        cmp AH, 50
        jne no_finalizacion_derecha
        cmp AH, 4d
        jne no_finalizacion_derecha
        jmp si_fin_derecha
        no_finalizacion_derecha:
            mov CX, 10
            mov DI, offset val_rt
            call memset
            mov SI, offset val_rt
            mov DI, offset finalizacion
            mov DL, [DI]
            mov [SI], DL
        si_fin_derecha:
        ;;cambiar el control
        mov control_derecha, AH


        call clear_pantalla
         ;; INGRESAR NUEVOS CONTROLES ;;
        ;;;; SOLICITAR CONTROL DE ABAJO
        mov DL, 02
        mov DH, 05
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset promp_dw
        mov AH, 09
        int 21
        pop DX

        ;;CONFIGURAR CONTROL DE ABAJO
        ;;LEER INGRESO DE TECLADO 
        mov AH, 00
        int 16
        push AX
        call validar_nuevo_control
        POP AX
        cmp AH, 48
        jne no_finalizacion_abajo 
        cmp AH, 4b
        jne no_finalizacion_abajo
        cmp AH, 50
        jne no_finalizacion_abajo
        cmp AH, 4d
        jne no_finalizacion_abajo
        jmp si_fin_abajo
        no_finalizacion_abajo:
            mov CX, 10
            mov DI, offset val_dw
            call memset
            mov SI, offset val_dw
            mov DI, offset finalizacion
            mov DL, [DI]
            mov [SI], DL
            
        si_fin_abajo:
        ;;cambiar control
        mov control_abajo, AH

        call clear_pantalla
         ;; INGRESAR NUEVOS CONTROLES ;;
        ;;;; SOLICITAR CONTROL DE ARRIBA
        mov DL, 02
        mov DH, 05
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset promp_up 
        mov AH, 09
        int 21
        pop DX
        ;;CONFIGURAR CONTROL DE ARRIBA
        ;;LEER INGRESO DE TECLADO
        mov AH, 00
        int 16
        push AX
        call validar_nuevo_control
        pop AX
        cmp AH, 48
        jne no_finalizacion_arriba 
        cmp AH, 4b
        jne no_finalizacion_arriba
        cmp AH, 50
        jne no_finalizacion_arriba
        cmp AH, 4d
        jne no_finalizacion_arriba
        jmp si_fin_arriba
        no_finalizacion_arriba:
            mov CX, 10
            mov DI, offset val_up
            call memset
            mov SI, offset val_up 
            mov DI, offset finalizacion
            mov DL, [DI]
            mov [SI], DL
        si_fin_arriba:
        ;;cambiar control
        mov control_arriba, AH

        call clear_pantalla
         ;; INGRESAR NUEVOS CONTROLES ;;
        ;;;; SOLICITAR CONTROL DE LA IZQUIERDA
        mov DL, 02
        mov DH, 05
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset promp_lf 
        mov AH, 09
        int 21
        pop DX

        ;;CONFIGURAR CONTROL DE LA IZQUIERDA
        ;;LEER INGRESO DE TECLADO
        mov AH, 00
        int 16
        PUSH AX
        call validar_nuevo_control
        POP AX
        cmp AH, 48
        jne no_finalizacion_izquierda 
        cmp AH, 4b
        jne no_finalizacion_izquierda
        cmp AH, 50
        jne no_finalizacion_izquierda
        cmp AH, 4d
        jne no_finalizacion_izquierda
        jmp si_fin_izquierda
        no_finalizacion_izquierda:
            mov CX, 10
            mov DI, offset val_lf
            call memset
            mov SI, offset val_lf
            mov DI, offset finalizacion
            mov DL, [DI]
            mov [SI], DL
        si_fin_izquierda:
        ;;cambiar control
        mov control_izquierda, AH 

        jmp menu_inicial
        ;;
    cambio_controles endp

    opciones_menu_configuracion proc
        call menu_configuracion
        mov DL, [opcion2]
            cmp DL, 0
            ;;realizar cambio de configuracion
            je cambio_controles
            ;;regresar al menu principal
            cmp DL, 1
            je menu_inicial
    opciones_menu_configuracion endp


    menu_configuracion proc
        call clear_pantalla
        mov AL, 0
        mov [opcion2], AL      ;; reinicio de la variable de salida
        mov AL, 2
        mov [maximo], AL
        mov AX, 01
        mov BX, 14b
        mov [xFlecha], AX
        mov [yFlecha], BX
                ;; IMPRIMIR OPCIONES ;;
        ;;;; TITULO
        mov DL, 09
        mov DH, 03
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset tit_configuracion
        mov AH, 09
        int 21
        pop DX
        ;;TITULO DERECHA
        mov DL, 06
        mov DH, 06
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset tit_rt
        mov AH, 09
        int 21
        pop DX

        ;;VALOR DERECHA
        mov DL, 15
        mov DH, 06
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset val_rt
        mov AH, 09
        int 21
        pop DX

        ;;TITULO ABAJO
        mov DL, 06
        mov DH, 08
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset tit_dw
        mov AH, 09
        int 21
        pop DX

        ;;VALOR ABAJO
        mov DL, 15
        mov DH, 08
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset val_dw
        mov AH, 09
        int 21
        pop DX
        
        ;;TITULO ARRIBA
        mov DL, 06
        mov DH, 0a
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset tit_up
        mov AH, 09
        int 21
        pop DX

        ;;VALOR ARRIBA
        mov DL, 15
        mov DH, 0a
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset val_up
        mov AH, 09
        int 21
        pop DX

        ;;TITULO IZQUIERDA
        mov DL, 06
        mov DH, 0c
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset tit_lf
        mov AH, 09
        int 21
        pop DX

        ;;VALOR IZQUIERDA
        mov DL, 15
        mov DH, 0c
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset val_dw
        mov AH, 09
        int 21
        pop DX

        ;;OPCION 1 "CAMBIAR CONTROLES"
        mov DL, 0b
        mov DH, 10
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset opt_controles
        mov AH, 09
        int 21
        pop DX

        ;;OPCION 2 "REGRESAR"
        mov DL, 0b
        mov DH, 12
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset opt_regresar
        mov AH, 09
        int 21
        pop DX
        
        ;;;;
        call pintar_flecha
        ;;;;
        ;; LEER TECLA
        ;;;;
        entrada_menu_configuracion:
                mov AH, 00
                int 16
                cmp AH, 48
                je restar_opcion_menu_configuracion
                cmp AH, 50
                je sumar_opcion_menu_configuracion
                cmp AH, 3b  ;; le doy F1
                je fin_menu_configuracion
                jmp entrada_menu_configuracion
        restar_opcion_menu_configuracion:
                mov AL, [opcion2]
                dec AL
                cmp AL, 0ff
                je volver_a_cero_conf
                mov [opcion2], AL
                jmp mover_flecha_menu_configuracion
        sumar_opcion_menu_configuracion:
                mov AL, [opcion2]
                mov AH, [maximo]
                inc AL
                cmp AL, AH
                je volver_a_maximo_conf
                mov [opcion2], AL
                jmp mover_flecha_menu_configuracion
        volver_a_cero_conf:
                mov AL, 0
                mov [opcion2], AL
                jmp mover_flecha_menu_configuracion
        volver_a_maximo_conf:
                mov AL, [maximo]
                dec AL
                mov [opcion2], AL
                jmp mover_flecha_menu_configuracion
        mover_flecha_menu_configuracion:
                mov AX, [xFlecha]
                mov BX, [yFlecha]
                mov SI, offset dim_sprite_vacio
                mov DI, offset data_sprite_vacio
                call pintar_sprite
                mov AX, 01
                mov BX, 14b
                mov CL, [opcion2]
        ciclo_ubicar_flecha_menu_configuracion:
                cmp CL, 0
                je pintar_flecha_menu_configuracion
                dec CL
                add BX, 10
                jmp ciclo_ubicar_flecha_menu_configuracion
        pintar_flecha_menu_configuracion:
                mov [xFlecha], AX
                mov [yFlecha], BX
                call pintar_flecha
                jmp entrada_menu_configuracion
                ;;
        fin_menu_configuracion:
                ret
    menu_configuracion endp

    ;;Menu de pausa
    menu_pausa proc
        call menu_pausa_seleccion
        mov DL, [opcion3]
            cmp DL, 0
            ;;realizar cambio de configuracion
            je ciclo_juego
            ;;regresar al menu principal
            cmp DL, 1
            je menu_inicial
    menu_pausa endp

   
    
    ;;SUBRUTINA QUE RETORNA LA OPCION SELECCIONADA EN EL MENU DE PAUSA
    menu_pausa_seleccion proc
        call clear_pantalla
        mov AL, 0
        mov [opcion3], AL      ;; reinicio de la variable de salida
        mov AL, 2
        mov [maximo], AL
        mov AX, 07
        mov BX, 0fc
        mov [xFlecha], AX
        mov [yFlecha], BX
                ;; IMPRIMIR OPCIONES ;;
        ;;;; TITULO
        mov DL, 10
        mov DH, 03
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset menu_pausa_tit
        mov AH, 09
        int 21
        pop DX

         ;;OPCION 1 "REGRESAR AL JUEGO"
        mov DL, 0b
        mov DH, 06
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset continuar_juego
        mov AH, 09
        int 21
        pop DX

        ;;OPCION 2 "REGRESAR AL MENU PRINCIPAL"
        mov DL, 0b
        mov DH, 08
        mov BH, 00
        mov AH, 02
        int 10
        ;; <<-- posicionar el cursor
        push DX
        mov DX, offset salir_menu
        mov AH, 09
        int 21
        pop DX

         ;;;;
        call pintar_flecha
            ;;;;
            ;; LEER TECLA
            ;;;;
            entrada_menu_pausa:
                    mov AH, 00
                    int 16
                    cmp AH, 48
                    je restar_opcion_menu_pausa
                    cmp AH, 50
                    je sumar_opcion_menu_pausa
                    cmp AH, 3b  ;; le doy F1
                    je fin_menu_pausa
                    jmp entrada_menu_pausa
            restar_opcion_menu_pausa:
                    mov AL, [opcion3]
                    dec AL
                    cmp AL, 0ff
                    je volver_a_cero_pausa
                    mov [opcion3], AL
                    jmp mover_flecha_menu_pausa
            sumar_opcion_menu_pausa:
                    mov AL, [opcion3]
                    mov AH, [maximo]
                    inc AL
                    cmp AL, AH
                    je volver_a_maximo_pausa
                    mov [opcion3], AL
                    jmp mover_flecha_menu_pausa
            volver_a_cero_pausa:
                    mov AL, 0
                    mov [opcion3], AL
                    jmp mover_flecha_menu_pausa
            volver_a_maximo_pausa:
                    mov AL, [maximo]
                    dec AL
                    mov [opcion3], AL
                    jmp mover_flecha_menu_pausa
            mover_flecha_menu_pausa:
                    mov AX, [xFlecha]
                    mov BX, [yFlecha]
                    mov SI, offset dim_sprite_vacio
                    mov DI, offset data_sprite_vacio
                    call pintar_sprite
                    mov AX, 07
                    mov BX, 0fc
                    mov CL, [opcion3]
            ciclo_ubicar_flecha_menu_pausa:
                    cmp CL, 0
                    je pintar_flecha_menu_pausa
                    dec CL
                    add BX, 10
                    jmp ciclo_ubicar_flecha_menu_pausa
            pintar_flecha_menu_pausa:
                    mov [xFlecha], AX
                    mov [yFlecha], BX
                    call pintar_flecha
                    jmp entrada_menu_pausa
                    ;;
            fin_menu_pausa:
                    ret
    menu_pausa_seleccion endp

    ;;CARGAR UN NIVEL ADICIONAL POR MEDIO DE UN ARCHIVO
    cargar_un_nivel proc
		mov AL, 00
		mov DX, offset nivel_x
		mov AH, 3d
		int 21
		jc main 
		mov [handle_nivel], AX
                ;;
        ciclo_lineas:
            mov BX, [handle_nivel]
            call siguiente_linea
            cmp DL, 0ff      ;; fin-del-archivo?
            je fin_parseo
            cmp DH, 00      ;; línea-con-algo?
            je ciclo_lineas
            ;;;;;;;;;;;;;;;;;;;;;;;
            ;; lógica del parseo ;;
            ;;;;;;;;;;;;;;;;;;;;;;;
            ;; al principio del buffer de la línea está: pared, caja, jugador, suelo, objetivo
            mov DI, offset linea
            push DI
            mov SI, offset tk_pared
            call cadena_igual
            cmp DL, 0ff               ;; cadenas iguales
            je es_pared
            pop DI
            push DI
            mov SI, offset tk_caja
            call cadena_igual
            cmp DL, 0ff               ;; cadenas iguales
            je es_caja
            pop DI
            push DI
            mov SI, offset tk_suelo
            call cadena_igual
            cmp DL, 0ff               ;; cadenas iguales
            je es_suelo
            pop DI
            push DI
            mov SI, offset tk_objetivo
            call cadena_igual
            cmp DL, 0ff               ;; cadenas iguales
            je es_objetivo
            pop DI
            push DI
            mov SI, offset tk_jugador
            call cadena_igual
            cmp DL, 0ff               ;; cadenas iguales
            je es_jugador
            pop DI
            jmp ciclo_lineas
        es_pared:
            mov AL, PARED
            mov [elemento_actual], AL
            jmp continuar_parseo0
        es_caja:
            mov AL, CAJA
            mov [elemento_actual], AL
            jmp continuar_parseo0
        es_suelo:
            mov AL, SUELO
            mov [elemento_actual], AL
            jmp continuar_parseo0
        es_objetivo:
            mov AL, OBJETIVO
            mov [elemento_actual], AL
            jmp continuar_parseo0
        es_jugador:
            mov AL, JUGADOR
            mov [elemento_actual], AL
            jmp continuar_parseo0
            ;; ignorar espacios
        continuar_parseo0:
            pop SI         ; ignorara valor inicial de DI
            mov AL, [DI]
            cmp AL, 20
            jne ciclo_lineas
            call ignorar_espacios
            ;; obtener una cadena numérica
            call leer_cadena_numerica
            push DI
            mov DI, offset numero
            call cadenaAnum
            mov [xElemento], AL
            pop DI
            ;; ignorar espacios
            mov AL, [DI]
            cmp AL, 20
            je continuar_parseo1
            cmp AL, ','
            je continuar_parseo2
            jmp ciclo_lineas
        continuar_parseo1:
            ;; ignorar espacios
            call ignorar_espacios
        continuar_parseo2:
            ;; obtener una coma
            mov SI, offset tk_coma
            call cadena_igual
            cmp DL, 0ff
            jne ciclo_lineas
            ;; ignorar espacios
            mov AL, [DI]
            cmp AL, 20
            jne ciclo_lineas
            call ignorar_espacios
            ;; obtener una cadena numérica
            call leer_cadena_numerica
            push DI
            mov DI, offset numero
            call cadenaAnum
            mov [yElemento], AL
            pop DI
            ;; ignorar_espacios
            mov AL, [DI]
            cmp AL, 20
            jne ver_final_de_linea
            call ignorar_espacios
            ;; ver si es el final de la cadena
        ver_final_de_linea:
            mov AL, [DI]
            cmp AL, 00
            jne ciclo_lineas
            ;; usar la información
            ;;
            mov DL, [elemento_actual]
            mov AH, [xElemento]
            mov AL, [yElemento]
            call colocar_en_mapa
            mov AL, JUGADOR
            cmp AL, [elemento_actual]
            je guardar_coordenadas_jugador
            jmp ciclo_lineas
        guardar_coordenadas_jugador:
            mov AH, [xElemento]
            mov AL, [yElemento]
            mov [xJugador], AH
            mov [yJugador], AL
            jmp ciclo_lineas
            ;;;;;;;;;;;;;;;;;;;;;;;
        fin_parseo:
            ;; cerrar archivo
            mov AH, 3e
            mov BX, [handle_nivel]
            int 21
            ;;
            int 03
            jmp ciclo_juego
            jmp fin
    cargar_un_nivel endp
    ;;VALIDAR CARACTERES DE ENTRADA DE LOS CONTROLES
    ;;ENTRADA:
    ;;  AH --> codigo de la tecla escaneada
    ;;  AL --> caracter en hexadecimal
    ;;SALIDA:
    ;;  [finalizacion] --> caracter parseado a cadena
    validar_nuevo_control:
        mov CX, 10
        mov DI, offset finalizacion
        call memset
        mov CX, 11
        ;;VALIDAR LAS TECLAS CON NOMBRE COMPUESTO
        cmp AH, 48 
        je init_es_arriba
        cmp AH, 4b
        je init_es_izquierda 
        cmp AH, 50 
        je init_es_abajo 
        cmp AH, 4d 
        je init_es_derecha
        jmp es_cualquiera 

        init_es_arriba:
          mov SI, offset val_up
          mov DI, offset arrow_up
          jmp es_arriba
        init_es_izquierda:
          mov SI, offset val_lf
          mov DI, offset arrow_lf
          jmp es_izquierda
        init_es_abajo:
          mov SI, offset val_dw
          mov DI, offset arrow_dw
          jmp es_abajo
        init_es_derecha:
          mov SI, offset val_rt
          mov DI, offset arrow_rt
          jmp es_derecha
        es_arriba:   
          mov DL, [DI]
          mov [SI], DL
          inc SI
          inc DI
          loop es_arriba
          jmp fin_conversion  
        es_abajo:  
          mov DL, [DI]
          mov [SI], DL
          inc SI
          inc DI
          loop es_abajo
          jmp fin_conversion
        es_izquierda:
          mov DL, [DI]
          mov [SI], DL
          inc SI
          inc DI
          loop es_izquierda
          jmp fin_conversion  
        es_derecha:
          mov DL, [DI]
          mov [SI], DL
          inc SI
          inc DI 
          loop es_derecha
          jmp fin_conversion
        es_cualquiera:
            ; mov caracter_teclado, AL
            mov SI, offset finalizacion
            mov [SI], AL  
            jmp fin_conversion 
        fin_conversion:
            ret

    ;; entrada_juego - manejo de las entradas del juego
    entrada_juego:
            mov AH, 01
            int 16
            jz fin_entrada_juego  ;; nada en el buffer de entrada
            mov AH, 00
            int 16
            ;; AH <- scan code
            cmp AH, [control_arriba]
            je mover_jugador_arr
            cmp AH, [control_abajo]
            je mover_jugador_aba
            cmp AH, [control_izquierda]
            je mover_jugador_izq
            cmp AH, [control_derecha]
            je mover_jugador_der
            cmp AH, [control_f2]
            je menu_pausa
            ret
            mover_jugador_arr:
                mov AH, [xJugador]
                mov AL, [yJugador]
                dec AL
                push AX
                call obtener_de_mapa
                pop AX
                ;; DL <- elemento en mapa
                cmp DL, PARED
                je hay_pared_arriba
                mov [yJugador], AL
                ;;
                mov DL, JUGADOR
                push AX
                call colocar_en_mapa
                pop AX
                ;;
                mov DL, SUELO
                inc AL
                call colocar_en_mapa
                ret
            hay_pared_arriba:
                ret
            mover_jugador_aba:
                mov AH, [xJugador]
                mov AL, [yJugador]
                inc AL
                push AX
                call obtener_de_mapa
                pop AX
                ;; DL <- elemento en mapa
                cmp DL, PARED
                je hay_pared_abajo
                mov [yJugador], AL
                ;;
                mov DL, JUGADOR
                push AX
                call colocar_en_mapa
                pop AX
                ;;
                mov DL, SUELO
                dec AL
                call colocar_en_mapa
                ret
            hay_pared_abajo:
                ret
            mover_jugador_izq:
                mov AH, [xJugador]
                mov AL, [yJugador]
                dec AH
                push AX
                call obtener_de_mapa
                pop AX
                ;; DL <- elemento en mapa
                cmp DL, PARED
                je hay_pared_izquierda
                mov [xJugador], AH
                ;;
                mov DL, JUGADOR
                push AX
                call colocar_en_mapa
                pop AX
                ;;
                mov DL, SUELO
                inc AH
                call colocar_en_mapa
                ret
            hay_pared_izquierda:
                ret
            mover_jugador_der:
                mov AH, [xJugador]
                mov AL, [yJugador]
                inc AH
                push AX
                call obtener_de_mapa
                pop AX
                ;; DL <- elemento en mapa
                cmp DL, PARED
                je hay_pared_derecha
                mov [xJugador], AH
                ;;
                mov DL, JUGADOR
                push AX
                call colocar_en_mapa
                pop AX
                ;;
                mov DL, SUELO
                dec AH
                call colocar_en_mapa
                ret
            hay_pared_derecha:
                ret
            fin_entrada_juego:
                ret


    ;; colocar_en_mapa - coloca un elemento en el mapa
    ;; ENTRADA:
    ;;    - DL -> código numérico del elemento
    ;;    - AH -> x
    ;;    - AL -> y
    ;; ...
    colocar_en_mapa:
            mov CX, AX     ;;;   AH -> x -> CH
            mov BL, 28
            mul BL   ;; AL * BL  = AX
            mov CL, CH
            mov CH, 00     ;;; CX el valor de X completo
            add AX, CX
            mov DI, offset mapa
            add DI, AX
            mov [DI], DL
            ret


    ;; obtener_de_mapa - obtiene un elemento en el mapa
    ;; ENTRADA:
    ;;    - AH -> x
    ;;    - AL -> y
    ;; SALIDA:
    ;;    - DL -> código numérico del elemento
    obtener_de_mapa:
            mov CX, AX
            mov BL, 28
            mul BL
            mov CL, CH
            mov CH, 00
            add AX, CX
            mov DI, offset mapa
            add DI, AX
            mov DL, [DI]
            ret


    ;; pintar_mapa - pinta los elementos del mapa
    ;; ENTRADA:
    ;; SALIDA:
    pintar_mapa:
		mov AL, 00   ;; fila
		;;
        ciclo_v:
            cmp AL, 19
            je fin_pintar_mapa
            mov AH, 00   ;; columna
                    ;;
            ciclo_h:
                cmp AH, 28
                je continuar_v
                push AX
                call obtener_de_mapa
                pop AX
                ;;
                        cmp DL, NADA
                je pintar_vacio_mapa
                ;;
                        cmp DL, JUGADOR
                je pintar_jugador_mapa
                ;;
                        cmp DL, PARED
                je pintar_pared_mapa
                ;;
                        cmp DL, CAJA
                je pintar_caja_mapa
                ;;
                        cmp DL, OBJETIVO
                je pintar_objetivo_mapa
                ;;
                        cmp DL, SUELO
                je pintar_suelo_mapa
                ;;
                jmp continuar_h
        pintar_vacio_mapa:
                push AX
                call adaptar_coordenada
                mov SI, offset dim_sprite_vacio
                mov DI, offset data_sprite_vacio
                call pintar_sprite
                pop AX
                jmp continuar_h
        pintar_suelo_mapa:
                push AX
                call adaptar_coordenada
                mov SI, offset dim_sprite_suelo
                mov DI, offset data_sprite_suelo
                call pintar_sprite
                pop AX
                jmp continuar_h
        pintar_jugador_mapa:
                push AX
                call adaptar_coordenada
                mov SI, offset dim_sprite_jug
                mov DI, offset data_sprite_jug
                call pintar_sprite
                pop AX
                jmp continuar_h
        pintar_pared_mapa:
                push AX
                call adaptar_coordenada
                mov SI, offset dim_sprite_pared
                mov DI, offset data_sprite_pared
                call pintar_sprite
                pop AX
                jmp continuar_h
        pintar_caja_mapa:
                push AX
                call adaptar_coordenada
                mov SI, offset dim_sprite_caja
                mov DI, offset data_sprite_caja
                call pintar_sprite
                pop AX
                jmp continuar_h
        pintar_objetivo_mapa:
                push AX
                call adaptar_coordenada
                mov SI, offset dim_sprite_obj
                mov DI, offset data_sprite_obj
                call pintar_sprite
                pop AX
                jmp continuar_h
        continuar_h:
                inc AH
                jmp ciclo_h
        continuar_v:
                inc AL
                jmp ciclo_v
        fin_pintar_mapa:
                ret



    ;;;;;;;;;;
    ;; pintar_pixel - pintar un pixel
    ;; ENTRADA:
    ;;     AX --> x pixel
    ;;     BX --> y pixel
    ;;     CL --> color
    ;; SALIDA: pintar pixel
    ;; AX + 320*BX
    pintar_pixel:
		push AX
		push BX
		push CX
		push DX
		push DI
		push SI
		push DS
		mov DX, 0a000
		mov DS, DX
		;; (
		;; 	posicionarse en X
		mov SI, AX
		mov AX, 140
		mul BX
		add AX, SI
		mov DI, AX
		;;
		mov [DI], CL  ;; pintar
		;; )
		pop DS
		pop SI
		pop DI
		pop DX
		pop CX
		pop BX
		pop AX
		ret

    ;; pintar_sprite - pinta un sprite
    ;; Entrada:
    ;;    - DI: offset del sprite
    ;;    - SI: offset de las dimensiones
    ;;    - AX: x sprite 320x200
    ;;    - BX: y sprite 320x200
    pintar_sprite:
        push DI
        push SI
        push AX
        push BX
        push CX
        inc SI
        mov DH, [SI]  ;; vertical
        dec SI        ;; dirección de tam horizontal
            ;;
        inicio_pintar_fila:
            cmp DH, 00
            je fin_pintar_sprite
            push AX
            mov DL, [SI]
        pintar_fila:
            cmp DL, 00
            je pintar_siguiente_fila
            mov CL, [DI]
            call pintar_pixel
            inc AX
            inc DI
            dec DL
            jmp pintar_fila
        pintar_siguiente_fila:
            pop AX
            inc BX
            dec DH
            jmp inicio_pintar_fila
        fin_pintar_sprite:
            pop CX
            pop BX
            pop AX
            pop SI
            pop DI
            ret



        ;; delay - subrutina de retardo
    delay:
        push SI
        push DI
        mov SI, 0200
        cicloA:
            mov DI, 0130
            dec SI
            cmp SI, 0000
            je fin_delay
        cicloB:
            dec DI
            cmp DI, 0000
            je cicloA
            jmp cicloB
        fin_delay:
            pop DI
            pop SI
            ret

    ;; clear_pantalla - limpia la pantalla
    ;; ..
    ;; ..
    clear_pantalla:
		mov CX, 19  ;; 25
		mov BX, 00
        clear_v:
            push CX
            mov CX, 28  ;; 40
            mov AX, 00
        clear_h:
            mov SI, offset dim_sprite_vacio
            mov DI, offset data_sprite_vacio
            call pintar_sprite
            add AX, 08
            loop clear_h
            add BX, 08
            pop CX
            loop clear_v
            ret

    ;; pintar_flecha - pinta una flecha
    pintar_flecha:
		mov AX, [xFlecha]
		mov BX, [yFlecha]
		mov SI, offset dim_sprite_flcha
		mov DI, offset data_sprite_flcha
		call pintar_sprite
		ret

    ;; adaptar_coordenada - 40x25->320x200
    ;; ENTRADA:
    ;;    AH -> x 40x25
    ;;    AL -> y 40x25
    ;; SALIDA:
    ;;    AX -> x 320x200
    ;;    BX -> y 320x200
    adaptar_coordenada:
        mov DL, 08
        mov CX, AX
        mul DL
        mov BX, AX
        ;;
        mov AL, CH
        mul DL
        ret

    ;; siguiente_linea - extrae la siguiente línea del archivo referenciado por el handle en BX
    ;; ENTRADA:
    ;;    - BX: handle
    ;; SALIDA:
    ;;    - [linea]: contenido de la línea que se extrajo, finalizada en 00 (nul0)
    ;;    - DL: si el archivo llegó a su fin
    ;;    - DH: la cantidad de caracteres en la línea
    siguiente_linea:
		mov SI, 0000
		mov DI, offset linea
		;;
        ciclo_sig_linea:
                mov AH, 3f
                mov CX, 0001
                mov DX, DI
                int 21
                cmp AX, 0000
                je fin_siguiente_linea
                mov AL, [DI]
                cmp AL, 0a
                je quitar_nl_y_fin
                inc SI
                inc DI
                jmp ciclo_sig_linea
        quitar_nl_y_fin:
                mov AL, 00
                mov [DI], AL
                mov DX, SI
                mov DH, DL
                mov DL, 00    ;; no ha finalizado el archivo
                ret
        fin_siguiente_linea:
                mov DL, 0ff   ;; ya finalizó el archivo
                ret

    ;; cadena_igual - verifica que dos cadenas sean iguales
    ;; ENTRADA:
    ;;    - SI: cadena 1, con su tamaño en el primer byte
    ;;    - DI: cadena 2
    ;; SALIDA:
    ;;    - DL: 0ff si son iguales, 00 si no lo son
    cadena_igual:
        mov CH, 00
        mov CL, [SI]
        inc SI
        ciclo_cadena_igual:
            mov AL, [SI]
            cmp AL, [DI]
            jne fin_cadena_igual
            inc SI
            inc DI
            loop ciclo_cadena_igual
        cadenas_son_iguales:
                mov DL, 0ff
                ret
        fin_cadena_igual:
                mov DL, 00
                ret

    ;; ignorar_espacios - ignora una sucesión de espacios
    ;; ENTRADA:
    ;;    - DI: offset de una cadena cuyo primer byte se supone es un espacio
    ;; ...
    ignorar_espacios:
        ciclo_ignorar:
                mov AL, [DI]
                cmp AL, 20
                jne fin_ignorar
                inc DI
                jmp ciclo_ignorar
        fin_ignorar:
                ret

        ;; cadenaAnum
        ;; ENTRADA:
        ;;    DI -> dirección a una cadena numérica
        ;; SALIDA:
        ;;    AX -> número convertido
        ;;;;
    cadenaAnum:
        mov AX, 0000    ; inicializar la salida
        mov CX, 0005    ; inicializar contador
        ;;
        seguir_convirtiendo:
                mov BL, [DI]
                cmp BL, 00
                je retorno_cadenaAnum
                sub BL, 30      ; BL es el valor numérico del caracter
                mov DX, 000a
                mul DX          ; AX * DX -> DX:AX
                mov BH, 00
                add AX, BX 
                inc DI          ; puntero en la cadena
                loop seguir_convirtiendo
        retorno_cadenaAnum:
                ret


            ;; leer_cadena_numerica - lee una cadena que debería estar compuesta solo de números
        ;; ENTRADA:
        ;;    - DI: offset del inicio de la cadena numérica
        ;; SALIDA:
        ;;    - [numero]: el contenido de la cadena numérica
        leer_cadena_numerica:
                mov SI, DI
                ;;
                mov DI, offset numero
                mov CX, 0005
                mov AL, 30
                call memset
                ;;
                mov DI, SI
                mov CX, 0000
            ciclo_ubicar_ultimo:
                    mov AL, [DI]
                    cmp AL, 30
                    jb copiar_cadena_numerica
                    cmp AL, 39
                    ja copiar_cadena_numerica
                    inc DI
                    inc CX
                    jmp ciclo_ubicar_ultimo
            copiar_cadena_numerica:
                    push DI   ;;   <----
                    dec DI
                    ;;
                    mov SI, offset numero
                    add SI, 0004
            ciclo_copiar_num:
                    mov AL, [DI]
                    mov [SI], AL
                    dec DI
                    dec SI
                    loop ciclo_copiar_num
                    pop DI
                    ret

    ;; memset - memset
    ;; ENTRADA:
    ;;    - DI: offset del inicio de la cadena de bytes
    ;;    - CX: cantidad de bytes
    ;;    - AL: valor que se pondrá en cada byte
    memset:
        push DI
        ciclo_memset:
            mov [DI], AL
            inc DI
            loop ciclo_memset
            pop DI
            ret

    fin:
        ;;interrupcion de finalizacion del programa
        mov ah, 4c 
        int 21
END main 