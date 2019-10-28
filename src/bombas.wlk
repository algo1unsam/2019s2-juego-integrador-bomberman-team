import personajes.*
import wollok.game.*
import paredes.*
import movimientos.*
import niveles.*
import otrosObjetos.*


class Bomba {
	
	var property position
	
	var property imagenBomba = "bomba.png"
	
	method image() = imagenBomba
	
	method nosCruzamos(quien) {}
	
	method explotoUnaBomba() {}
		
	method explotoLaBomba() {
		imagenBomba = "explosion1.jpg"
		game.onTick(500,"Explosion1",{ => self.removerExplosion()})	
	}
		
	
	method removerExplosion(){
		game.removeVisual(self)
		game.removeTickEvent("Explosion1")
	}
	
	method activarBomba() {
		game.onTick(2000,"Explota bomba",{=>self.estallar()})
			
	}
	
	method estallar() {
		game.removeTickEvent("Explota bomba")
		game.getObjectsIn(self.position()).forEach({elemento=>elemento.explotoLaBomba()})
		game.getObjectsIn(self.position().up(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().down(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().left(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().right(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		self.estallarNull()

	
	}
	
	method estallarNull(){
		var explosionDerecha = new Explosion()
		var explosionIzquierda = new Explosion()
		var explosionArriba = new Explosion()
		var explosionAbajo = new Explosion()
		
		explosionDerecha.explotoUnaBomba(self.position().right(1))
		explosionIzquierda.explotoUnaBomba(self.position().left(1))
		explosionArriba.explotoUnaBomba(self.position().up(1))
		explosionAbajo.explotoUnaBomba(self.position().down(1))
	}
} 


// Fin clase Bomba

class Explosion{
	
	method image() = "explosion1.jpg"
	
	method explotoUnaBomba(position){
		if (game.getObjectsIn(position).size()==0){
			game.addVisualIn(self, position)
			game.onTick(500, self.toString(),{ => self.removerExplosion()})	
		}
	}
		method removerExplosion(){
		game.removeVisual(self)
		game.removeTickEvent(self.toString())
	}
	
}

