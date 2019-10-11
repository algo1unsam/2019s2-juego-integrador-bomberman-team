import bomberman.*
import wollok.game.*
import movimientos.*
import niveles.*
import paredes.*


object nivel1 {
	
	method configuracion() {
		game.title("Bomberman Springfield")
		game.height(15)
		game.width(15)
		game.ground("bg_green.png")
		
		movimientos.movimiento(bomberman)
		
		game.addVisual(bomberman)
		game.addVisual(tabernaMoe)
		
		
			
		const ancho = game.width() - 1
		const largo = game.height() - 1
		
		
		// Moldeado de paredes en los bordes de la pantalla
		
		(1 .. ancho-1).forEach { z => moldeadoParedes.draw(new Pared(),new Position(x=z, y=0)) } 
		(1 .. ancho-1).forEach { z => moldeadoParedes.draw(new Pared(), new Position(x=z, y=largo)) }  
		(0 .. largo).forEach { z => moldeadoParedes.draw(new Pared(), new Position(x=0, y=z)) } 
		(0 .. largo).forEach { z => moldeadoParedes.draw(new Pared(), new Position(x=ancho, y=z)) } 
	
		
	
	}
}
