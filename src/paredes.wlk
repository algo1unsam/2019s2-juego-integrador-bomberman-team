import bomberman.*
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
		game.onTick(500,"Explosion"+self,{ => self.removerExplosion()})	
	}
	
	method removerExplosion(){
		game.removeVisual(self)
		game.removeTickEvent("Explosion"+self)
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
	const largo = game.height() - 1

	method paredesNivelUno(){
	// Moldeado de paredes en Nivel 1

		(1 .. ancho-1).forEach { z => moldeadoParedes.draw(new Pared(),new Position(x=z*2, y=z*2)) } 
	//	(1 .. ancho-1).forEach { z => moldeadoParedes.draw(new HardPared(), new Position(x=z, y=largo)) }  
		(0 .. largo).forEach { z => moldeadoParedes.draw(new Pared(), new Position(x=(z*2), y=largo-(z*2)) ) } 
	//	(0 .. largo).forEach { z => moldeadoParedes.draw(new HardPared(), new Position(x=ancho, y=z)) } 

	}
	
} //Fin paredesNivel1




