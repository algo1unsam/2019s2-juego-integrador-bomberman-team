import wollok.game.*
import paredes.*
import niveles.*
import bombas.*
import movimientos.*
import bomberman.*

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
	var property position = game.at(13,3)
	
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

	var position = game.at(10, 10)

	method image() = "tabernaMoe.jpg"

	method position() {return position}

	method explotoUnaBomba() {game.say(self,"No destruyas mi taberna!")}

	method nosCruzamos(quien) {quien.llegarATaberna()}

} //Fin tabernaMoe

object burns {
	
	var direccion = moverDer
	
	var property position = game.at(3,6)
	var property limite1 = game.at(1,6)
	var property limite2 = game.at(13,6)
	
	method patrulla(){ direccion.mover(self) }
	
	method image() = "burns.png"
	
	method tocaParedIzq(){}
	method tocaParedDer(){}
	
	method direccionIzq(){return direccion==moverIzq}
	
	method cambioDir(){if (self.direccionIzq()) direccion = moverDer else direccion = moverIzq}
	
	method golpeadoPorPiedra() {game.say(self,"Smithers! Estoy siendo atacado!")}
	
	method nosCruzamos(quien) {
		quien.encontrarBurns()
	}
	
	method explotoUnaBomba() {
		game.say(self,"Intenta matarme? Está despedido!")
		bomberman.perderVida()
	}
} //Fin burns

object moverIzq{method mover(enemigo){if (!(enemigo.position() == enemigo.limite1())) movimientos.move(izquierda,enemigo) else enemigo.cambioDir()}}
object moverDer{method mover(enemigo){if (!(enemigo.position() == enemigo.limite2())) movimientos.move(derecha,enemigo) else enemigo.cambioDir()}}

object bart {
	
	var property position = game.at(9,13)
	
	method image() = "bart.jpg"
	
	method explotoUnaBomba() {}
	
	method nosCruzamos(quien) {}
	
	method disparar() {
		var piedra = new Piedra(position = self.position())
		game.addVisual(piedra)
		game.onCollideDo(piedra, {elemento=>elemento.nosCruzamos(piedra)})
		piedra.serDisparada()
	}
}

class Piedra {
	
	var property position
	
	
	method image() = "piedra.jpg"
	
	method nosCruzamos(quien) {
		quien.golpeadoPorPiedra()
		game.removeVisual(self)
	}
			
	method explotoUnaBomba() {}
	
	method chocarConAlgo() {
	}
	
	method chocarPared() {
		game.removeTickEvent("Explota bomba"+self.identity())
		game.removeVisual(self)
	}
	
	method encontrarRosquilla() {}
	
	method serDisparada() {
		game.onTick(100,"Explota bomba"+self.identity(),{=>movimientos.move(abajo,self)})
	}
} //Fin piedra

