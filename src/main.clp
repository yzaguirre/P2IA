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
(defglobal ?*rival* = "")
(defglobal ?*EstrategiaRival* = "Defensiva")
(defglobal ?*EstrategiaBolivia* = "Defensiva")
(defglobal ?*Defensa* = "Bien")
(defglobal ?*Ataque* = "Bien")
(deftemplate tiene-goles
	(slot equipo (type STRING))
	(slot goles (type INTEGER))
)
(defrule menu-o9
	?f <- (menu-oficial 8)
=>
	(retract ?f)
)
(defrule menu-o8
	?f <- (menu-oficial 7)
=>
	(printout t "se recomienda" crlf)
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o7
	?f <- (menu-oficial 6)
=>
	(printout t "Bolivia esta atacando actualmente: " ?*Ataque* crlf "La nueva es [Bien|Mal]: ")
	(bind ?*Ataque* (readline))
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o6
	?f <- (menu-oficial 5)
=>
	(printout t "Bolivia se esta defendiendo actualmente: " ?*Defensa* crlf "La nueva es [Bien|Mal]: ")
	(bind ?*Defensa* (readline))
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o5
	?f <- (menu-oficial 4)
=>
	(printout t "Bolivia tiene estrategia actual: " ?*EstrategiaBolivia* crlf "La nueva es [Ofensiva|Defensiva]: ")
	(bind ?*EstrategiaBolivia* (readline))
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o4
	?f <- (menu-oficial 3)
=>
	(printout t ?*rival* " tiene estrategia actual: " ?*EstrategiaRival* crlf "La nueva es [Ofensiva|Defensiva]: ")
	(bind ?*EstrategiaRival* (readline))
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o3
	?f <- (menu-oficial 2)
	?tg <- (tiene-goles (equipo ?r) (goles ?goles))
	(test (eq ?r ?*rival*))
=>
	(bind ?g (+ ?goles 1))
	(modify ?tg (goles ?g))
	(printout t "Marcador" ?*rival* ": " ?g)
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o2
	?f <- (menu-oficial 1)
	?tg <- (tiene-goles (equipo "Bolivia") (goles ?goles))
=>
	(bind ?g (+ ?goles 1))
	(modify ?tg (goles ?g))
	(printout t "Marcador Bolivia: " ?g)
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-oficial1
	?f <- (menu-oficial 0)
=>
	(printout t crlf crlf "Opciones de ingreso para estado del partido:" crlf "1.) Nuestro Equipo anotó gol" crlf "2.) Equipo Rival anotó gol" crlf "3.) Equipo Rival tiene estrategia..." crlf "4.) Equipo Bolivia tiene estrategia..." crlf "5.) Nuestra defensa cambio para..." crlf "6.) Nuestro ataque cambio para..." crlf "7.) Solicitar Recomendacion" crlf "8.) Salir" crlf) 
	(printout t "Elija opcion [1-7]: ")
	(bind ?opcion (read))
	(retract ?f)
	(assert (menu-oficial ?opcion))
	(printout t crlf)
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
	(assert (menu-oficial 0))
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
	(bind ?*rival* (readline))
	(assert (tiene-goles (equipo ?*rival*) (goles 0)))
	(assert (tiene-goles (equipo "Bolivia") (goles 0)))
	;(assert (rival =(readline)))
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
