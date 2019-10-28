import personajes.*
import wollok.game.*
import movimientos.*
import niveles.*
import bombas.*
import otrosObjetos.*

class Pared {
	
	var property position
	var property imagenPared = "softblock.png"
	
	method image() = imagenPared 
	
	method nosCruzamos(quien) {
		quien.chocarPared()
	}
	
	method explotoUnaBomba() {
		imagenPared = "explosion1.jpg"
		game.onTick(500,"Explosion"+self.toString(),{ => self.removerExplosion()})	
	}
	
	method removerExplosion(){
		game.removeVisual(self)
		game.removeTickEvent("Explosion"+self.toString())
	}
}

class HardPared inherits Pared {
	
	override method image() = "hardblock.png"
	
	override method explotoUnaBomba() {}
	
} //Fin HardPared

object moldeadoParedes {
	
	method draw(paredes, posicion) {
		posicion.drawElement(paredes)
	}
}

object paredesLimites{

	const ancho = game.width() - 1
	const largo = game.height() - 1

	method construirLimites(){
		// Moldeado de paredes SÓLIDAS en los bordes de la pantalla

		(1 .. ancho-1).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=z, y=0)) } 
		(1 .. ancho-1).forEach { z => moldeadoParedes.draw(new HardPared(), new Position(x=z, y=largo)) }  
		(0 .. largo).forEach { z => moldeadoParedes.draw(new HardPared(), new Position(x=0, y=z)) } 
		(0 .. largo).forEach { z => moldeadoParedes.draw(new HardPared(), new Position(x=ancho, y=z)) } 
	}
	
} //Fin paredesLimites

object paredesNivel1 {

	const ancho = game.width() - 1

	method paredesNivelUno(){
	// Moldeado de paredes en Nivel 1
			//lado derecho bart
		(1 .. ancho-2).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=12, y=z*2)) } 
		(2 .. ancho-1).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=11, y=z)) }
		
		(1 .. ancho-2).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=8, y=z)) }
		(1 .. ancho-2).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=9, y=z)) }
		
		// resto
		
		(1 .. 5).forEach { z => moldeadoParedes.draw(new Pared(),new Position(x=1, y=(z*2)+1)) }
		(1 .. 5).forEach { z => moldeadoParedes.draw(new Pared(),new Position(x=3, y=(z*2)+1)) }
		(1 .. 5).forEach { z => moldeadoParedes.draw(new Pared(),new Position(x=5, y=(z*2)+1)) }
		(1 .. 5).forEach { z => moldeadoParedes.draw(new Pared(),new Position(x=7, y=(z*2)+1)) }
		
		
		(1 .. ancho-2).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=2, y=z*2)) }
		(1 .. ancho-2).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=4, y=z*2)) }
		(1 .. ancho-2).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=6, y=z*2)) }
		
		(0 .. 5).forEach { z => moldeadoParedes.draw(new HardPared(),new Position(x=z, y=2)) }

	}
	
} //Fin paredesNivel1