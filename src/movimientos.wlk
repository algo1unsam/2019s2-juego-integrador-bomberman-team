import bomberman.*
import wollok.game.*
import niveles.*


object movimientos {

	method movimiento(personaje){
		
		keyboard.left().onPressDo {self.move(izquierda, personaje)}
		keyboard.right().onPressDo {self.move(derecha, personaje)}
		keyboard.up().onPressDo {self.move(arriba, personaje)}
		keyboard.down().onPressDo {self.move(abajo, personaje)}
		
	}


	method move(sentido, personaje) {

		personaje.position(sentido.hacia(personaje.position()))
	}
	
	}

object izquierda { 
	method hacia(position) = position.left(1) 
}

object derecha { 
	method hacia(position) = position.right(1) 
}

object abajo { 
	method hacia(position) = position.down(1) 
}

object arriba { 
	method hacia(position) = position.up(1) 
}