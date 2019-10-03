import wollok.game.*


object bomberman {

	var property position = game.at(0,0)
	
	method image() = "homero.png"	

	method move(nuevaPosicion) {self.position(nuevaPosicion)}
	
	method hayObjetoArriba(){return game.getObjectsIn(self.position().up(1)).isEmpty() }
	
	method hayObjetoAbajo(){return game.getObjectsIn(self.position().down(1)).isEmpty() }
	
	method hayObjetoDerecha(){return game.getObjectsIn(self.position().right(1)).isEmpty() }
	
	method hayObjetoIzquierda(){return game.getObjectsIn(self.position().left(1)).isEmpty() }
	
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