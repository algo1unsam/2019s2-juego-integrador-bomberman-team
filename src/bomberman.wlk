import wollok.game.*


object bomberman {

	var property position = game.at(0,0)
	
	method image() = "homero.png"	

	method move(nuevaPosicion) {self.position(nuevaPosicion)}	
	
} //Fin bomberman

object tabernaMoe {
	
	var position = game.at(14,9)
	
	method image() = "tabernaMoe.jpg"
	
	method position() {return position}
	
}

class Pared {
	
	var property position
	
	method image() = "pared.jpg"
}