import bomberman.*
import wollok.game.*
import paredes.*
import niveles.*
import bombas.*
import movimientos.*

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
	
	var bombas = 5
	var property position = game.at(13,3)
	
	method image() = "plantaNuclear.jpg"
	
	method cuantasBombasHay() {
		return bombas
	}
	
	method explotoUnaBomba() {
		bomberman.vidas(0)
	}
	
	method nosCruzamos() {
		bomberman.sumarBombas(bombas)
		bombas = bombas - bombas
	}

	method fabricarBombas() {
		if (self.cuantasBombasHay() == 0) {
			bombas = bombas + 1
		}
	}	
	
} //Fin object planta nuclear