import bomberman.*
import wollok.game.*
import movimientos.*
import niveles.*
import paredes.*



class Pared {
	
	var property position
	
	method image() = "hardblock.png"
}



object moldeadoParedes {
	
	method draw(paredes, posicion) {
		posicion.drawElement(paredes)
	}
	

}