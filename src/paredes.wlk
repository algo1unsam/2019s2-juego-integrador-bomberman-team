import bomberman.*
import wollok.game.*
import movimientos.*
import niveles.*
import bombas.*
import otrosObjetos.*

class Pared {
	
	var property position
	var property imagenPared = "softblock.png"
	
	method image() = imagenPared 
	
	method nosCruzamos() {
		movimientos.move(movimientos.direccion().rebote(),bomberman)
	}
	
	method explotoUnaBomba() {
		imagenPared = "explosion1.jpg"
		game.onTick(500,"Explosion"+self,{ => self.removerExplosion()})	
		
		
	}
	
	method removerExplosion(){
		game.removeVisual(self)
		game.removeTickEvent("Explosion"+self)
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