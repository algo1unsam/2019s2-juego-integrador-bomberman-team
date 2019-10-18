import wollok.game.*
import bombas.*
import otrosObjetos.*
import movimientos.*
import paredes.*

/*  METODOS COMUNES
 * 	
 * 	method image()
 * 	method explotoUnaBomba()
 * 	method nosCruzamos()
 * 	
 */
object bomberman {

	var property position = game.at(1, 1)
	var property vidas = 3
	var property rosquillas = 0
	var property bombas = 3

	method image() = "homero.png"

	method explotoUnaBomba() {
		self.perderVida()
		game.say(self, "D'oh! Me quedan " + self.vidas().toString() + " vidas.")
	}
	
	method perderVida() {
		vidas = vidas - 1
		position = game.at(1,1)
	}
	
	method sumarBombas(cantBombas) {
		bombas = bombas + cantBombas
	}

	method colocarBomba() {
		if (bombas == 0) {
			game.say(self, "No tengo bombas!")
		} else {
			var bomba = new Bomba(position = self.position())
			game.addVisualIn(bomba, game.at(self.position().x(), self.position().y()))
			bomba.activarBomba()
			bombas = bombas - 1
		}
	}

	method encontrarRosquilla() {
		rosquillas = rosquillas + 1
		self.vidaExtraPorRosquillas()
	}

	method vidaExtraPorRosquillas() {
		if (rosquillas == 10) {
			vidas = vidas + 1
			game.say(self, "Yajuu! Una vida extra! Tengo " + self.vidas().toString() + " vidas.")
			rosquillas = 0
		}
	}

} //Fin bomberman

object tabernaMoe {

	var position = game.at(10, 10)

	method image() = "tabernaMoe.jpg"

	method position() {
		return position
	}

	method explotoUnaBomba() {
	}

	method nosCruzamos() {
		game.say(self, "Llegaste! Te merecés una cerveza.")
	}

} //Fin tabernaMoe

object burns {
	
	var direccion = moverDer
	
	var property position = game.at(3,6)
	
	var property limite1 = game.at(1,6)
	
	var property limite2 = game.at(13,6)
	
	method patrulla(){ direccion.mover(self) }
	
	method image() = "burns.png"
	
	method tocaParedIzq(){}
	method tocaParedDer(){}
	
	method direccionIzq(){return direccion==moverIzq}
	
	method cambioDir(){if (self.direccionIzq()) direccion = moverDer else direccion = moverIzq}
	
}

object moverIzq{
	
	method mover(enemigo){if (!(enemigo.position() == enemigo.limite1()) ) movimientos.move(izquierda,enemigo) else enemigo.cambioDir()}
	
}

object moverDer{
	
	method mover(enemigo){if (!(enemigo.position() == enemigo.limite2())) movimientos.move(derecha,enemigo) else enemigo.cambioDir()}
	
}

//  (!(enemigo.position() == enemigo.limite1()))
//  (!(enemigo.position() == enemigo.limite2()))