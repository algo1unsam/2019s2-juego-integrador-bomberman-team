import bomberman.*
import wollok.game.*

object tablero {

	method agregarRosquilla() {
		var randomPosition = game.at(0.randomUpTo(10), 0.randomUpTo(10))
		if (self.posicionVacia(randomPosition)) {
			game.addVisual(new Rosquilla(position = randomPosition))
		}
	}

	method posicionVacia(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
	}
}


class Rosquilla {

	var property position

	method image() = "rosquilla.jpg"

	method explotoUnaBomba() {}

	method nosCruzamos() {
		bomberman.encontrarRosquilla()
		game.removeVisual(self)
	}
}

object plantaNuclear {
	
	var property bombas = 5.max(5)
	var property position = game.at(13,3)
	
	method image() = "plantaNuclear.jpg"
	
	method explotoUnaBomba() {
		bomberman.vidas(0)
	}
	
	method nosCruzamos() {
		bombas = bombas - 5
		bomberman.sumarBombas(5)
	}
	
	
} //Fin object planta nuclear