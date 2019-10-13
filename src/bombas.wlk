import bomberman.*
import wollok.game.*
import paredes.*


class Bomba {
	
	const property elementosAlrededor = []
	
	var property position
	
	method nosCruzamos() {}
	
	method explotoUnaBomba() {
		game.removeVisual(self)
	}
	
	method image() = "bomba.jpg"
	
	method activarBomba() {
		game.onTick(2000,"Explota bomba",{=>self.estallar()})
	}
	
	method estallar() {
		game.removeTickEvent("Explota bomba")
		game.getObjectsIn(self.position()).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().up(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().down(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().left(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().right(1)).forEach({elemento=>elemento.explotoUnaBomba()})
	}
} // Fin clase Bomba
