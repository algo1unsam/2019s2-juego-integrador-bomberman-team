import personajes.*
import wollok.game.*
import movimientos.*
import paredes.*
import otrosObjetos.*
import bombas.*
import paredes.*
import contadores.*
import clasegeneral.*


class Nivel{
	
	method final() = false
	
	method iniciar(){
		game.schedule(1000, { self.configuracion()}) 
		}
		
	method keyboard(){
	keyboard.space().onPressDo {bomberman.colocarBomba()}
	keyboard.v().onPressDo{game.say(bomberman,"Me quedan " + bomberman.vidas().toString() + " vidas, baboso.")}
	keyboard.b().onPressDo{game.say(bomberman,"Me quedan " + bomberman.bombas().toString() + " bombas, baboso.")}
	keyboard.b().onPressDo{game.say(plantaNuclear,"Me quedan " + plantaNuclear.cuantasBombasHay().toString() + " bombas, baboso.")}
	}
	
	method configuracion() {
		
		movimientos.movimiento(bomberman)
		paredesLimites.construirLimites()

		self.personajes()
		self.keyboard()
		game.schedule(1000,{tablero.contadores()})
		}
	
	method personajes(){}
	
}

object inicio inherits Nivel {	
	
	override method configuracion(){
	
		game.addVisual(fondo)
		
		game.addVisual(seleccionador)		
		
		self.keyboard()
		}
		
		override method keyboard(){

		keyboard.up().onPressDo {seleccionador.arriba()}
		keyboard.down().onPressDo {seleccionador.abajo()}
		keyboard.enter().onPressDo {seleccionador.comenzarJuego()} 
		}
	
}


object nivel1 inherits Nivel {
	
	override method configuracion() {
		
		super()
		
		paredesNivel1.paredesNivelUno()
		
		game.whenCollideDo(bomberman,{elemento=>elemento.nosCruzamos(bomberman)})
		game.whenCollideDo(burns,{elemento=>elemento.nosCruzamos(burns)})
		game.onTick(15000,"Sumar bombas a la planta",{plantaNuclear.fabricarBombas()})
		game.onTick(400,"Patrulla Burns",{burns.patrulla()})
		//game.onTick(6333,"Cambio de dirección Burns",{burns.cambiarDireccion()})
		//game.onTick(20000,"Agregar rosquilla",{tablero.agregarRosquilla()})
		//game.onTick(2000,"Bart dispara",{bart.disparar()})
		//game.onTick(15314,"Agregar pared",{tablero.agregarPared()})
		//game.onTick(20314,"Agregar pared",{tablero.agregarHardPared()})
		
		

		}

	override method personajes(){
		
		game.addVisual(bomberman)
		game.addVisualIn(tabernaMoe,game.at(12,13))	
		game.addVisualIn(plantaNuclear,game.at(10,3))
		game.addVisual(burns)
		game.addVisualIn(bart,game.at(13,13))
		
	}
}


object nivel2 inherits Nivel{
	
	override method final() = true
	
	override method configuracion() {
		super()
		paredesNivel2.paredesNivelDos()
		
		

		}

	override method personajes(){
		
		game.addVisual(bomberman)
		game.addVisualIn(tabernaMoe,game.at(1,2))
		game.addVisualIn(plantaNuclear,game.at(10,3))
		game.addVisual(burns)
		game.addVisualIn(bart,game.at(13,13))
		
	}
}