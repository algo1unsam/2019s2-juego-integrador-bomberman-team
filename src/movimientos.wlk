import bomberman.*
import wollok.game.*
import niveles.*


object movimientos {

	var property direccion

	method movimiento(personaje){
		

		keyboard.left().onPressDo {self.move(izquierda, personaje)}
		keyboard.left().onPressDo {direccion = izquierda}
		keyboard.right().onPressDo {self.move(derecha, personaje)}
		keyboard.right().onPressDo {direccion = derecha}
		keyboard.up().onPressDo {self.move(arriba, personaje)}
		keyboard.up().onPressDo {direccion = arriba}
		keyboard.down().onPressDo {self.move(abajo, personaje)}
		keyboard.down().onPressDo {direccion = abajo}
		
	}


	method move(sentido, personaje) {
		personaje.position(sentido.hacia(personaje.position()))
	}
	
	}

object izquierda { 
	method hacia(position) = position.left(1) 
	method rebote() = derecha
}

object derecha { 
	method hacia(position) = position.right(1) 
	method rebote() = izquierda
}

object abajo { 
	method hacia(position) = position.down(1) 
	method rebote() = arriba
}

object arriba { 
	method hacia(position) = position.up(1) 
	method rebote() = abajo
}