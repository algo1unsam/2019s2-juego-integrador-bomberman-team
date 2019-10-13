import bomberman.*
import wollok.game.*
import movimientos.*
import niveles.*
import paredes.*



class Pared {
	
	var property position
	
	method image() = "pared.jpg"
	
	method nosCruzamos() {
		movimientos.move(movimientos.direccion().rebote(),bomberman)
	}
	
	method explotoUnaBomba() {
		game.removeVisual(self)
	}
}

class HardPared inherits Pared {
	
	override method image() = "hardblock.png"
	
	override method explotoUnaBomba() {}	
}



object moldeadoParedes {
	
	method draw(paredes, posicion) {
		posicion.drawElement(paredes)
	}
	

}