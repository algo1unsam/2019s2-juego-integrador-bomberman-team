import bomberman.*
import wollok.game.*
import niveles.*
import bombas.*
import otrosObjetos.*
import paredes.*


object movimientos {

	method movimiento(personaje){
		
		keyboard.left().onPressDo {self.move(izquierda, personaje)}
		keyboard.right().onPressDo {self.move(derecha, personaje)}
		keyboard.up().onPressDo {self.move(arriba, personaje)}
		keyboard.down().onPressDo {self.move(abajo, personaje)}
		keyboard.left().onPressDo {bomberman.direccion(izquierda)}
		keyboard.right().onPressDo {bomberman.direccion(derecha)}
		keyboard.up().onPressDo {bomberman.direccion(arriba)}
		keyboard.down().onPressDo {bomberman.direccion(abajo)}
		keyboard.left().onPressDo {bomberman.imagen("homero-izq.png")}
		keyboard.right().onPressDo {bomberman.imagen("homero-der.png")}
		
	}

	method move(sentido, personaje) {
		personaje.position(sentido.hacia(personaje.position()))
	}
	
	method rebotar(quien,sentido) {
		self.move(sentido.rebote(),quien)
	}
	
} //Fin movimientos

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