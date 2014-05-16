; David Yzaguirre Gonzalez
; 200819312
(deftemplate Seleccion
	(slot nombre (type STRING))
	(slot ata (type INTEGER))
	(slot med (type INTEGER))
	(slot def (type INTEGER))
	(slot ip (type INTEGER))
)
(deftemplate Jugador
	(slot nombre (type STRING))
	(slot Seleccion (type STRING))
	(slot Media (type INTEGER))
	(slot Dorsal (type INTEGER))

	(slot centros (type INTEGER)) ; ATAQUE
	(slot definicion (type INTEGER)) ; ATAQUE
	(slot precision_cabeza (type INTEGER)) ; ATAQUE
	(slot pases_cortos (type INTEGER)) ; ATAQUE
	(slot voleas (type INTEGER)) ; ATAQUE
	(slot regates (type INTEGER)) ; HABILIDAD
	(slot efecto (type INTEGER)) ; HABILIDAD
	(slot precision_falta (type INTEGER)) ; HABILIDAD
	(slot pases_largos (type INTEGER)) ; HABILIDAD
	(slot control_balon (type INTEGER)) ; HABILIDAD
	(slot aceleracion (type INTEGER)) ; MOVIMIENTO
	(slot velocidad_sprint (type INTEGER)) ; MOVIMIENTO
	(slot agilidad (type INTEGER)) ; MOVIMIENTO
	(slot mreflejos (type INTEGER)) ; MOVIMIENTO
	(slot equilibrio (type INTEGER)) ; MOVIMIENTO
	(slot potencia_disparo (type INTEGER)) ; POTENCIA
	(slot saldo (type INTEGER)) ; POTENCIA
	(slot resistencia (type INTEGER)) ; POTENCIA
	(slot fuerza (type INTEGER)) ; POTENCIA
	(slot disparos_lejanos (type INTEGER)) ; POTENCIA
	(slot agresividad (type INTEGER)) ; MENTALIDAD
	(slot tactico (type INTEGER)) ; MENTALIDAD
	(slot mposicionamiento (type INTEGER)) ; MENTALIDAD
	(slot vision (type INTEGER)) ; MENTALIDAD
	(slot penaltis (type INTEGER)) ; MENTALIDAD
	(slot marcaje (type INTEGER)) ; DEFENSA
	(slot entrada (type INTEGER)) ; DEFENSA
	(slot entrada_agresiva (type INTEGER)) ; DEFENSA
	(slot estirada (type INTEGER)) ; PORTEROS
	(slot parada (type INTEGER)) ; PORTEROS
	(slot saque_puerta (type INTEGER)) ; PORTEROS
	(slot posicionamiento (type INTEGER)) ; PORTEROS
	(slot reflejos (type INTEGER)) ; PORTEROS
)
(defrule seleccion-jugador
	(declare (salience 201))
	(initial-fact)
=>
	(printout t crlf "Ingrese dorsal de jugador 1: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 1))
	(printout t crlf "Ingrese dorsal de jugador 2: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 2))
	(printout t crlf "Ingrese dorsal de jugador 3: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 3))
	(printout t crlf "Ingrese dorsal de jugador 4: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 4))
	(printout t crlf "Ingrese dorsal de jugador 5: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 5))
	(printout t crlf "Ingrese dorsal de jugador 6: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 6))
	(printout t crlf "Ingrese dorsal de jugador 7: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 7))
	(printout t crlf "Ingrese dorsal de jugador 8: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 8))
	(printout t crlf "Ingrese dorsal de jugador 9: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 9))
	(printout t crlf "Ingrese dorsal de jugador 10: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 10))
	(printout t crlf "Ingrese dorsal de jugador 11: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos ?dorsal 11))
)
(defrule jugadores
	(declare (salience 202))
	(initial-fact)
	(Jugador (nombre ?nombre) (Media ?media) (Dorsal ?dorsal))
=>
	(printout t ?dorsal ": " ?nombre ", tiene media " ?media "." crlf)
)
(defrule seleccion-rival
	(declare (salience 203))
	(initial-fact)
=>
	(printout t crlf "Seleccione Pais Rival: ")
	(assert (rival =(readline)))
	(printout t crlf "JUGADORES SELECCION BOLIVIA" crlf)
)
(defrule mostrar-paises
	(declare (salience 204))
	(initial-fact)
	(Seleccion (nombre ?nombre))
=>
	(printout t ?nombre crlf)
)
(defrule inicio
	(declare (salience 205))
	(initial-fact)
=>
	(load-facts main_facts.clp)
	;(printout t " Exito!!, Se cargaron los datos correctamente" crlf crlf )
	(printout t "Paises: " crlf)
)
