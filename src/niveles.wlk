import personajes.*
import wollok.game.*
import movimientos.*
import paredes.*
import otrosObjetos.*
import bombas.*
import paredes.*
import contadores.*
import clasegeneral.*


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
		game.onTick(400,"Patrulla Burns",{burns.patrulla()})
		//game.onTick(6333,"Cambio de dirección Burns",{burns.cambiarDireccion()})
		//game.onTick(20000,"Agregar rosquilla",{tablero.agregarRosquilla()})
		//game.onTick(2000,"Bart dispara",{bart.disparar()})
		//game.onTick(15314,"Agregar pared",{tablero.agregarPared()})
		//game.onTick(20314,"Agregar pared",{tablero.agregarHardPared()})
		
		

		}

	method personajes(){
		
		game.addVisual(bomberman)
		game.addVisualIn(tabernaMoe,game.at(12,13))	
		game.addVisualIn(plantaNuclear,game.at(10,3))
		game.addVisual(burns)
		game.addVisualIn(bart,game.at(13,13))
		
	}
}