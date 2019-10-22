import bomberman.*
import wollok.game.*
import movimientos.*
import paredes.*
import otrosObjetos.*
import bombas.*
import paredes.*

object nivel1 {
	
	method configuracion() {

		
		movimientos.movimiento(bomberman)
		paredesLimites.construirLimites()
		self.personajes()

		
		game.addVisualIn(new Pared(),game.at(3,3))
		game.addVisualIn(new Pared(),game.at(2,2))
		game.addVisualIn(new Pared(),game.at(4,2))
		game.addVisualIn(new Pared(),game.at(9,8))
				
		game.onTick(20000,"Agregar rosquilla",{tablero.agregarRosquilla()})
		game.onTick(15000,"Sumar bombas a la planta",{plantaNuclear.fabricarBombas()})
		game.onTick(800,"burns",{burns.patrulla()})
		game.onTick(1500,"Bart dispara",{bart.disparar()})

	}
	
	method personajes(){
		game.addVisual(bomberman)
		game.addVisual(tabernaMoe)	
		game.addVisual(plantaNuclear)
		game.addVisual(burns)
		game.addVisual(bart)
	}
}
