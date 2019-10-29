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
	
	method explotoUnaBomba() {
		game.removeVisual(self)
	}
		
	//method explotoLaBomba() {
	//	imagenBomba = "explosion1.jpg"
		//game.onTick(500,"Explosion1",{ => self.removerExplosion()})	
	//	game.schedule(500, )
	//}
	
	method animacion() {
		
		var exp1 = new Explosion()
		var exp2 = new Explosion()
		var exp3 = new Explosion()
		var exp4 = new Explosion()
		var exp5 = new Explosion()
		var x = self.position().x()
		var y = self.position().y()
		
		const explosiones = #{exp1,exp2,exp3,exp4,exp5}
		
		game.addVisualIn(exp1,game.at(x,y))
		game.addVisualIn(exp2,game.at(x+1,y))
		game.addVisualIn(exp3,game.at(x-1,y))
		game.addVisualIn(exp4,game.at(x,y+1))
		game.addVisualIn(exp5,game.at(x,y-1))
		
		game.schedule(500,{explosiones.forEach({explosion=>game.removeVisual(explosion)})})

	}	
	
	//method removerExplosion(){
	//	game.removeVisual(self)
	//	game.removeTickEvent("Explosion1")
	//}
	
	method activarBomba() {
		game.onTick(2000,"Explota bomba",{=>self.estallar()})
	}
	
	method estallar() {
		game.removeTickEvent("Explota bomba")
		//game.getObjectsIn(self.position()).forEach({elemento=>elemento.explotoLaBomba()})
		game.getObjectsIn(self.position()).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().up(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().down(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().left(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().right(1)).forEach({elemento=>elemento.explotoUnaBomba()})
		//self.estallarNull()
		self.animacion()
	
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
	
	//method explotoUnaBomba(position){
	//	if (game.getObjectsIn(position).size()==0){
	//		game.addVisualIn(self, position)
	//		game.onTick(500, self.toString(),{ => self.removerExplosion()})	
	//	}
	//}
	//	method removerExplosion(){
	//	game.removeVisual(self)
	//	game.removeTickEvent(self.toString())
	//}
	
	method nosCruzamos(quien) {}
	
}
