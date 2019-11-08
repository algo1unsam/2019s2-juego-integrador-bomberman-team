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
		bomberman.reiniciarContador()
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
		
		game.whenCollideDo(bomberman,{elemento=>elemento.nosCruzamosConBomberman(bomberman)})
		game.whenCollideDo(burns,{elemento=>elemento.nosCruzamosConEnemigo(burns)})
		
		
		game.onTick(400,"Patrulla Burns",{burns.patrulla()})
		game.onTick(2000,"Bart dispara",{bart.disparar()})
		
		

		}

	override method personajes(){
	
		game.addVisual(bomberman)
		game.addVisualIn(tabernaMoe,game.at(12,13))	
		game.addVisualIn(plantaNuclear,game.at(10,3))
		game.addVisual(burns)
		game.addVisualIn(bart, game.at(13,13))
		bart.position(game.at(13,13))
		game.addVisualIn(barney,game.at(4,8))
		game.addVisualIn(new Rosquilla(), game.at(2,8))
		game.addVisualIn(new Rosquilla(), game.at(6,8))
		game.addVisualIn(new Rosquilla(), game.at(4,10))
		game.addVisualIn(new Rosquilla(), game.at(1,13))
		game.addVisualIn(new Rosquilla(), game.at(12,5))
		game.addVisualIn(new Rosquilla(), game.at(12,9))
		
	}
}


object nivel2 inherits Nivel{
	
	override method final() = true
	
	override method configuracion() {
		super()
		paredesNivel2.paredesNivelDos()
		game.whenCollideDo(bomberman,{elemento=>elemento.nosCruzamosConBomberman(bomberman)})
		game.whenCollideDo(burns,{elemento=>elemento.nosCruzamosConEnemigo(burns)})
		
		

		}

	override method personajes(){
		bomberman.position(game.at(1,1))
		game.addVisual(bomberman)
		game.addVisualIn(tabernaMoe,game.at(1,2))
		game.addVisualIn(plantaNuclear,game.at(10,3))
		game.addVisual(burns)
		game.addVisualIn(bart,game.at(13,13))
		
	}
}