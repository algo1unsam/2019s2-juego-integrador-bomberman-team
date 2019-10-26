import bomberman.*
import wollok.game.*
import movimientos.*
import paredes.*
import otrosObjetos.*
import bombas.*
import paredes.*
import contadores.*


object nivel1 {

	method configuracion() {

		game.title("Bomberman Springfield")
		game.height(15)
		game.width(15)
		game.ground("bg_green.png")
		
		movimientos.movimiento(bomberman)
		paredesNivel1.paredesNivelUno()
		paredesLimites.construirLimites()
		
		//Se agregan los personajes

		self.personajes()

		game.onTick(15000,"Sumar bombas a la planta",{plantaNuclear.fabricarBombas()})
		game.onTick(800,"burns",{burns.patrulla()})
		//game.onTick(2000,"Bart dispara",{bart.disparar()})
		game.onTick(15314,"Agregar pared",{tablero.agregarPared()})
		game.onTick(20314,"Agregar pared",{tablero.agregarHardPared()})
		game.onTick(20000,"Agregar rosquilla",{tablero.agregarRosquilla()})

		}

	method personajes(){
		
		game.addVisual(bomberman)
		game.addVisual(tabernaMoe)	
		game.addVisual(plantaNuclear)
		game.addVisual(burns)
		game.addVisual(bart)
		
	}
}