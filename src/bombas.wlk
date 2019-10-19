import bomberman.*
import wollok.game.*
import paredes.*
import movimientos.*
import niveles.*
import otrosObjetos.*


class Bomba {
	
	const property elementosAlrededor = []
	
	var property position
	
	var property imagenBomba = "bomba.png"
	
	method nosCruzamos() {}
	
	method explotoUnaBomba() {
		imagenBomba = "explosion1.jpg"
		game.onTick(500,"Explosion1",{ => self.removerExplosion()})	
	}
	
	method removerExplosion(){
		game.removeVisual(self)
		game.removeTickEvent("Explosion1")
	}
	

	method image() = imagenBomba
	
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
