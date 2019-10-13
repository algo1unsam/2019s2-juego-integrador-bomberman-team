import bomberman.*
import wollok.game.*
import movimientos.*
import paredes.*
import otrosObjetos.*


object nivel1 {
	
	method configuracion() {
		game.title("Bomberman Springfield")
		game.height(15)
		game.width(15)
		game.ground("bg_green.png")
		
		movimientos.movimiento(bomberman)

		game.addVisual(bomberman)
		game.addVisual(tabernaMoe)	
		game.addVisual(plantaNuclear)	
		game.addVisualIn(new Pared(),game.at(3,3))
		game.addVisualIn(new Pared(),game.at(2,2))
		game.addVisualIn(new Pared(),game.at(4,2))
		game.addVisualIn(new Pared(),game.at(3,1))
				
		game.onTick(20000,"Agregar rosquilla",{tablero.agregarRosquilla()})
		game.onTick(30000,"Sumar bombas a la planta",{plantaNuclear.bombas(5)})
		
		
		const ancho = game.width() - 1
		const largo = game.height() - 1
		
		
		// Moldeado de paredes en los bordes de la pantalla
		
		(1 .. ancho-1).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=z, y=0)) } 
		(1 .. ancho-1).forEach { z => moldeadoParedes.draw(new HardPared(), new Position(x=z, y=largo)) }  
		(0 .. largo).forEach { z => moldeadoParedes.draw(new HardPared(), new Position(x=0, y=z)) } 
		(0 .. largo).forEach { z => moldeadoParedes.draw(new HardPared(), new Position(x=ancho, y=z)) } 
	
	
	}
}