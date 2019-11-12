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
	keyboard.r().onPressDo {bomberman.nivel().iniciar()}

	}
	
	method configuracion() {
		game.clear()
		bomberman.reiniciarContador()
		movimientos.movimiento(bomberman)
		paredesLimites.construirLimites()
		plantaNuclear.fabricarBombas()
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
		plantaNuclear.fabricarBombas()
		paredesNivel1.paredesNivelUno()
		plantaNuclear.fabricarBombas()
		trigger.trigger(0)
		game.whenCollideDo(bomberman,{elemento=>elemento.nosCruzamosConBomberman(bomberman)})
		game.whenCollideDo(burns,{elemento=>elemento.nosCruzamosConEnemigo(burns)})
		
		
		game.onTick(400,"Patrulla Burns",{burns.patrulla()})
		game.onTick(1500,"Vomitar",{barney.vomitar()})
		
		

		}

	override method personajes(){
		bomberman.position(game.at(1,1))
		game.addVisual(bomberman)
		game.addVisualIn(tabernaMoe,game.at(12,13))		
		game.addVisualIn(plantaNuclear,game.at(10,3))
		game.addVisual(burns)
		burns.position(game.at(6, 13))
		game.addVisualIn(bart, game.at(13,13))
		bart.position(game.at(13,13))
		game.addVisualIn(barney,game.at(4,8))
		barney.position(game.at(4,8))
		game.addVisualIn(new Rosquilla(), game.at(3,8))
		game.addVisualIn(new Rosquilla(), game.at(5,8))
		game.addVisualIn(new Rosquilla(), game.at(4,10))
		game.addVisualIn(new Rosquilla(), game.at(1,13))
		game.addVisualIn(new Rosquilla(), game.at(12,5))
		game.addVisualIn(new Rosquilla(), game.at(12,9))
		game.addVisualIn(trigger, game.at(10,1))
	}
}


object nivel2 inherits Nivel{
	
	override method final() = true
	
	override method configuracion() {
		super()
		trigger.trigger(0)
		bomberman.nivel(self)
		paredesNivel2.paredesNivelDos()
		plantaNuclear.fabricarBombas()
		game.whenCollideDo(bomberman,{elemento=>elemento.nosCruzamosConBomberman(bomberman)})
		game.whenCollideDo(burns,{elemento=>elemento.nosCruzamosConEnemigo(burns)})
		
		game.onTick(400,"Patrulla Burns",{burns.patrulla()})
		game.onTick(1500,"Vomitar",{barney.vomitar()})
		

		}

	override method personajes(){
		bomberman.position(game.at(1,1))
		game.addVisual(bomberman)
		game.addVisualIn(tabernaMoe,game.at(11,13))
		game.addVisualIn(plantaNuclear,game.at(5,13))
		game.addVisual(burns)
		burns.position(game.at(8,9))
		game.addVisualIn(bart,game.at(13,13))
		bart.position(game.at(13,13))
		game.addVisualIn(trigger,game.at(10,6))
		game.addVisualIn(barney,game.at(4,9))
		barney.position(game.at(4,9))
		game.addVisualIn(new Rosquilla(), game.at(1,3))
		game.addVisualIn(new Rosquilla(), game.at(8,13))
		game.addVisualIn(new Rosquilla(), game.at(12,10))
		game.addVisualIn(new Rosquilla(), game.at(12,1))
		game.addVisualIn(new Rosquilla(), game.at(13,1))
		game.addVisualIn(new Rosquilla(), game.at(10,1))
		
	}
}

object creditos inherits Nivel {	
	
	override method configuracion(){
		
		game.clear()
		game.addVisual(fondo3)
		game.schedule(5000,{game.stop()})
	
}
}