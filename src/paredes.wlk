import personajes.*
import wollok.game.*
import movimientos.*
import niveles.*
import bombas.*
import clasegeneral.*
import otrosObjetos.*

class Pared inherits General {

	var property position
	var property imagenPared = "softblock.png"

	method image() = imagenPared

	override method nosCruzamosConBomberman(quien) {
		quien.chocarPared()
	}
	
		override method nosCruzamosConEnemigo(quien) {
		quien.chocarPared()
	}
	

	override method explotoUnaBomba() {
		imagenPared = "explosion1.jpg"
		game.onTick(500, "Explosion" + self.toString(), { => self.removerExplosion()})
	}

	override method removerExplosion() {
		game.removeVisual(self)
		game.removeTickEvent("Explosion" + self.toString())
	}
	

	

}

class HardPared inherits Pared {

	override method image() = "hardblock.png"

	override method explotoUnaBomba() {
	}
	

} //Fin HardPared

object moldeadoParedes {

	method draw(paredes, posicion) {
		posicion.drawElement(paredes)
	}

}

object paredesLimites {

	const ancho = game.width() - 1
	const largo = game.height() - 1

	method construirLimites() {
		// Moldeado de paredes SÓLIDAS en los bordes de la pantalla
		(1 .. ancho - 1).forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = z, y = 0))}
		(1 .. ancho - 1).forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = z, y = largo))}
		(0 .. largo).forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = 0, y = z))}
		(0 .. largo).forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = ancho, y = z))}
	}

} //Fin paredesLimites

object paredesNivel1 {

	const ancho = game.width() - 1

	method paredesNivelUno() {
		// Moldeado de paredes en Nivel 1
		// lado derecho bart
		(1 .. ancho - 2).forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = 12, y = z * 2))}
		(2 .. ancho - 1).forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = 11, y = z))}
		(1 .. ancho - 2).forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = 8, y = z))}
		(1 .. ancho - 2).forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = 9, y = z))}
			
			// resto
		
		[4].forEach{ z => moldeadoParedes.draw(new Pared(), new Position(x = z, y = 3))}
		[1,2,3,5,6,7].forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = z, y = 3))}
		[1,3,5,7].forEach{ z => moldeadoParedes.draw(new Pared(), new Position(x = z, y = 5))}
		[1,3,5,7].forEach{ z => moldeadoParedes.draw(new Pared(), new Position(x = z, y = 7))}
		[1,7].forEach{ z => moldeadoParedes.draw(new Pared(), new Position(x = z, y = 8))}
		[2,6].forEach{ z => moldeadoParedes.draw(new Pared(), new Position(x = z, y = 9))}
		[1,3,5,7].forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = z, y = 9))}
		[1,2,5,6,7].forEach{ z => moldeadoParedes.draw(new HardPared(), new Position(x = z, y = 12))}
		[3].forEach{ z => moldeadoParedes.draw(new Pared(), new Position(x = z, y = 13))}
		
		[5].forEach{ z => moldeadoParedes.draw(new Pared(), new Position(x = 13, y = z))}
	}

} //Fin paredesNivel1

object paredesNivel2 {

	const ancho = game.width() - 1

	method paredesNivelDos() {



	}

} //Fin paredesNivel2

