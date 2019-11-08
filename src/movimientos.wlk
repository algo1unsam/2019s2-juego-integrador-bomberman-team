import personajes.*
import wollok.game.*
import niveles.*
import bombas.*
import otrosObjetos.*
import paredes.*

object movimientos {

	method movimiento(personaje) {
		keyboard.left().onPressDo{ self.move(izquierda, personaje);bomberman.direccion(izquierda);bomberman.imagen("homero-izq.png")	}
		keyboard.right().onPressDo{ self.move(derecha, personaje);bomberman.direccion(derecha);bomberman.imagen("homero-der.png")}
		keyboard.up().onPressDo{ self.move(arriba, personaje); bomberman.direccion(arriba)}
		keyboard.down().onPressDo{ self.move(abajo, personaje);bomberman.direccion(abajo)}
		
	}

	method move(sentido, personaje) {
		personaje.position(sentido.hacia(personaje.position()))
	}

	method rebotar(quien, sentido) {
		self.move(sentido.rebote(), quien)
	}

} //Fin movimientos

object izquierda {

	method hacia(position) = position.left(1)

	method rebote() = derecha

	method soyIzquierda() = true

}

object derecha {

	method hacia(position) = position.right(1)

	method rebote() = izquierda

	method soyIzquierda() = false

}

object abajo {

	method hacia(position) = position.down(1)

	method rebote() = arriba

	method soyIzquierda(){}

}

object arriba {

	method hacia(position) = position.up(1)

	method rebote() = abajo

	method soyIzquierda() {}

}

