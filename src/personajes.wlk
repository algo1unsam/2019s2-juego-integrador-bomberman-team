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
 * 	method chocarConAlgo() {}
 *	method encontrarRosquilla() {}
 *  method encontrarBart() ****Para personajes que se mueven****
 * 	method golpeadoPorPiedra()
 *  method llegarAPlantaNuclear() *****Para personajes que se mueven****
 * 	method llegarATaberna() ****Para personajes que se mueven****
 * 	method encontrarRosquilla() ****Para personajes que se mueven****
 */
object bomberman {

	var property position = game.at(1,1)
	var property vidas = 3
	var property rosquillas = 0
	var property bombas = 10
	
	var property imagen = "homero-der.png"
	var property direccion

	method image() = imagen  //if (direccion == izquierda) "homero-izq.png" else "homero-der.png"
	
	method cuantasVidas() {
		game.say(self, "D'oh! Me quedan " + self.vidas().toString() + " vidas.")
	}

	method explotoUnaBomba() {
		self.perderVida()
		self.cuantasVidas()
	}
	
	method perderVida() {
		vidas = vidas - 1
		position = game.at(1,1)
	}
	
	method perderTodasLasVidas() {
		vidas = 0
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
	
	method chocarPared() {
		movimientos.rebotar(self,direccion)
	}

	method encontrarBart() {}

	method encontrarBurns() {
		game.say(burns,"Vaya a trabajar!")
		self.perderVida()
	}

	method llegarATaberna() {
		game.say(tabernaMoe,"Llegaste! Toma una Duff! ")
		game.schedule(2000,{game.clear()})
		// iniciamos nivel 2
	}

	method llegarAPlantaNuclear() {
		self.sumarBombas(plantaNuclear.cuantasBombasHay())
		plantaNuclear.restarBombas()
	}

	method golpeadoPorPiedra() {
		game.say(self,"D'oh! Pequeño demonio!")
		self.perderVida()
	}

} //Fin bomberman

object burns {
	
	//var direccion = moverIzq
	
	var property position = game.at(6,13)
	
	const direcciones = [izquierda,derecha,arriba,abajo]
	
	var property direccion = izquierda
	
	method direcciones(num) {
		return direcciones.get(num)
	}
	
	//method patrulla() {movimientos.move(direccion,self)}
	
	method cambiarDireccion() {
		direccion = direcciones.get(0.randomUpTo(3))
	}
	
	method patrulla() {
		movimientos.move(direccion,self)
	}
	
	method image() =  if (self.direccion() == izquierda) "burns-izq.png" else "burns-der.png"
	
	method nosCruzamos(quien) {quien.encontrarBurns()}
	
	method golpeadoPorPiedra() {game.say(self,"Smithers! Estoy siendo atacado!")}
		
	method explotoUnaBomba() {
		game.say(self,"Intenta matarme? Está despedido!")
		bomberman.perderVida()
	}
	
	method encontrarRosquilla() {}
	
	method chocarPared() {
		movimientos.rebotar(self,direccion)
		direccion = direccion.rebote()
	}
	
	method encontrarBart() {}
	method llegarATaberna() {game.say(tabernaMoe, "Largo de aquí!")}
	method llegarAPlantaNuclear() {}

} //Fin burns

object bart {
	
	var property position
	
	method image() = "bart.jpg"
	
	method explotoUnaBomba() {
		game.removeTickEvent("Bart dispara")
		game.removeVisual(self)
	}
	
	method nosCruzamos(quien) {}
	
	method disparar() {
		var piedra = new Piedra(position = self.position())
		game.addVisual(piedra)
		game.whenCollideDo(piedra, {elemento=>elemento.nosCruzamos(piedra)})
		piedra.serDisparada()
		game.onTick(5000,"Fuerapiedra",{=>piedra.chocarPared()})
	}
}