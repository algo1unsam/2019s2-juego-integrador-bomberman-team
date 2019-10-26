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
	
	method sumarBombas() {
		if (bombas < 3)bombas = bombas + 1
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
	
	method chocarPared() {
		movimientos.move(movimientos.direccion().rebote(),self)
	}
	method encontrarBart() {}
	method encontrarBurns() {
		game.say(burns,"Vaya a trabajar!")
		self.perderVida()
	}
	method llegarATaberna() {
		game.say(tabernaMoe, "Llegaste! Te merecés una cerveza.")
	}
	method llegarAPlantaNuclear() {
		self.sumarBombas()
		plantaNuclear.restarBombas()
	}
	method golpeadoPorPiedra() {
		game.say(self,"D'oh! Pequeño demonio!")
		self.perderVida()
	}
	

} //Fin bomberman

//  (!(enemigo.position() == enemigo.limite1()))
//  (!(enemigo.position() == enemigo.limite2()))