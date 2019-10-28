import wollok.game.*
import paredes.*
import niveles.*
import bombas.*
import movimientos.*
import personajes.*
import contadores.*

object tablero {
	
	method posicionVacia(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
	}
	
	method agregarRosquilla() {
		var randomPosition = game.at(0.randomUpTo(10), 0.randomUpTo(10))
		if (self.posicionVacia(randomPosition)) {
			game.addVisual(new Rosquilla(position = randomPosition))
		}
	}
	
	method agregarPared() {
		var randomPosition = game.at(0.randomUpTo(10), 0.randomUpTo(10))
		if (self.posicionVacia(randomPosition)) {
			game.addVisual(new Pared(position = randomPosition))
		}
	}
	
	method agregarHardPared() {
		var randomPosition = game.at(0.randomUpTo(10), 0.randomUpTo(10))
		if (self.posicionVacia(randomPosition)) {
			game.addVisual(new HardPared(position = randomPosition))
		}
	}
	
	method contadores() {
	game.addVisualIn(contadorVidas,game.at(1,14))
	game.addVisualIn(decenaVidas,game.at(2,14))
	game.addVisualIn(unidadesVidas,game.at(3,14))
	game.addVisualIn(contadorRosquillas,game.at(4,14))
	game.addVisualIn(decenaRosquillas,game.at(5,14))
	game.addVisualIn(unidadesRosquillas,game.at(6,14))
	game.addVisualIn(contadorBombas,game.at(7,14))
	game.addVisualIn(decenaBombas,game.at(8,14))
	game.addVisualIn(unidadesBombas,game.at(9,14))
	}
}


class Rosquilla {

	var property position

	method image() = "rosquilla.jpg"

	method explotoUnaBomba() {}

	method nosCruzamos(quien) {
		quien.encontrarRosquilla()
		game.removeVisual(self)
	}
	
	method golpeadoPorPiedra() {}
}

object plantaNuclear {
	
	var bombas = 5
	var property position
	
	method image() = "plantaNuclear.jpg"
	
	method cuantasBombasHay() {return bombas}
	
	method restarBombas() {
		bombas = bombas - bombas
	}
	
	method explotoUnaBomba() {
		bomberman.perderTodasLasVidas()
		bomberman.cuantasVidas()
	}
	
	method nosCruzamos(quien) {
		quien.llegarAPlantaNuclear()
	}

	method fabricarBombas() {
		if (self.cuantasBombasHay() == 0) {
			bombas = bombas + 1
		}
	}	
} //Fin object planta nuclear

object tabernaMoe {


	method image() = "tabernaMoe.jpg"


	method explotoUnaBomba() {game.say(self,"No destruyas mi taberna!")}

	method nosCruzamos(quien) {quien.llegarATaberna()}

} //Fin tabernaMoe



class Piedra {
	
	var property position
	
	method image() = "piedra.jpg"
	
	method nosCruzamos(quien) {
		quien.golpeadoPorPiedra()
		game.removeVisual(self)
		game.removeTickEvent("Tirapiedra")
	}


			
	method chocarConAlgo() {
		game.whenCollideDo(self, {alguien=>self.nosCruzamos(alguien)})
	}
	
	method chocarPared() {
		game.removeTickEvent("Explota bomba"+self.identity())
		game.removeVisual(self)
		game.removeTickEvent("Tirapiedra")
		game.removeTickEvent("Fuerapiedra")
	}
	method serDisparada() {
		game.onTick(100,"Explota bomba"+self.identity(),{=>movimientos.move(abajo,self)})
		game.onTick(100,"Tirapiedra",{=>movimientos.move(abajo,self)})
	}
	

	method encontrarRosquilla() {}
	method explotoUnaBomba() {}
} //Fin piedra

