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
	var property position = game.at(10,3)
	
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

	var position = game.at(12, 13)

	method image() = "tabernaMoe.jpg"

	method position() {return position}

	method explotoUnaBomba() {game.say(self,"No destruyas mi taberna!")}

	method nosCruzamos(quien) {quien.llegarATaberna()}

} //Fin tabernaMoe

object burns {
	
	//var direccion = moverIzq
	
	var property direccion = izquierda
	
	var property position = game.at(6,6)
	
	method patrulla() {movimientos.move(direccion,self)}
	
	method image() =  if (self.direccion() == izquierda) "burns-izq.png" else "burns-der.png"
	
	method nosCruzamos(quien) {quien.encontrarBurns()}
	
	//method direccionIzq(){return direccion==moverIzq}
	
	//method cambioDir(){if (self.direccionIzq()) direccion = moverDer else direccion = moverIzq}
	
	method golpeadoPorPiedra() {game.say(self,"Smithers! Estoy siendo atacado!")}
		
	method explotoUnaBomba() {
		game.say(self,"Intenta matarme? Está despedido!")
		bomberman.perderVida()
	}
	
	method encontrarRosquilla() {}
	
	method chocarPared() {
		movimientos.rebotar(self,direccion)
		direccion = direccion.rebote()
	}
	
	method encontrarBart() {}
	method llegarATaberna() {game.say(tabernaMoe, "Largo de aquí!")}
	method llegarAPlantaNuclear() {}

} //Fin burns

object bart {
	
	var property position = game.at(13,13)
	
	method image() = "bart.jpg"
	
	method explotoUnaBomba() {
		game.removeTickEvent("Bart dispara")
		game.removeVisual(self)
		
	}
	
	method nosCruzamos(quien) {}
	
	method disparar() {
		var piedra = new Piedra(position = self.position())
		game.addVisual(piedra)
		game.whenCollideDo(piedra, {elemento=>elemento.nosCruzamos(piedra)})
		piedra.serDisparada()
		game.onTick(5000,"Fuerapiedra",{=>piedra.chocarPared()})
	}
}

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

