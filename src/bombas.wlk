import personajes.*
import wollok.game.*
import paredes.*
import movimientos.*
import niveles.*
import otrosObjetos.*
import clasegeneral.*

class Bomba inherits General {

	var property position
	var property imagenBomba = "bomba.png"

	method image() = imagenBomba

	override method explotoUnaBomba() {
		game.removeVisual(self)
	}
	
	override method nosCruzamosConEnemigo(quien){
		quien.chocarPared()
	}

	method animacion() {
		var exp1 = new Explosion()
		var exp2 = new Explosion()
		var exp3 = new Explosion()
		var exp4 = new Explosion()
		var exp5 = new Explosion()
		var x = self.position().x()
		var y = self.position().y()
		const explosiones = #{ exp1, exp2, exp3, exp4, exp5 }
		
		game.addVisualIn(exp1, game.at(x, y))
		game.addVisualIn(exp2, game.at(x + 1, y))
		game.addVisualIn(exp3, game.at(x - 1, y))
		game.addVisualIn(exp4, game.at(x, y + 1))
		game.addVisualIn(exp5, game.at(x, y - 1))
		game.schedule(500, { explosiones.forEach({ explosion => game.removeVisual(explosion)})})
	}

	method activarBomba() {
		game.onTick(2000, "Explota bomba", {=> self.estallar()})
	}

	method estallar() {
		game.removeTickEvent("Explota bomba")
		game.getObjectsIn(self.position()).forEach({ elemento => elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().up(1)).forEach({ elemento => elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().down(1)).forEach({ elemento => elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().left(1)).forEach({ elemento => elemento.explotoUnaBomba()})
		game.getObjectsIn(self.position().right(1)).forEach({ elemento => elemento.explotoUnaBomba()})
		game.sound("song052.wav")
		self.animacion()
	}

}

// Fin clase Bomba
class Explosion inherits General {

	method image() = "explosion.png"

}

