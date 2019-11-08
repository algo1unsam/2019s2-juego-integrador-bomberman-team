import wollok.game.*
import bombas.*
import otrosObjetos.*
import movimientos.*
import paredes.*
import clasegeneral.*
import niveles.*

/*  METODOS COMUNES
 * 	
 * 	method image()
 * 	method explotoUnaBomba()
 * 	method nosCruzamos()
 * 	method chocarConAlgo() {}
 * method encontrarRosquilla() {}
 *  method encontrarBart() ****Para personajes que se mueven****
 * 	method golpeadoPorPiedra()
 *  method llegarAPlantaNuclear() *****Para personajes que se mueven****
 * 	method llegarATaberna() ****Para personajes que se mueven****
 * 	method encontrarRosquilla() ****Para personajes que se mueven****
 */
 
object bomberman inherits General {

	var property position = game.at(1, 1)
	var property vidas = 3
	var property rosquillas = 0
	var property bombas = 10
	var property imagen = "homero-der.png"
	var property direccion 
	var property nivel = nivel1

	method image() = imagen

	method cuantasVidas() {
		game.say(self, "D'oh! Me quedan " + self.vidas().toString() + " vidas.")
	}

	override method explotoUnaBomba() {
		self.perderVida()
		self.cuantasVidas()
	}
	
	method reiniciarContador(){
		vidas = 3
		rosquillas = 0
		bombas = 10
	}
	
	method perderVida() {
			vidas = vidas - 1
		position = game.at(1, 1)
			if(vidas == 0) {
			game.say(self, "No me quedan mas vidas, perdiste!")
			game.schedule(1000, { game.clear(); nivel1.iniciar()})
		}
	}

	method perderTodasLasVidas() {
		vidas = 0
		position = game.at(1, 1)
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

	override method encontrarRosquilla() {
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
		movimientos.rebotar(self, direccion)
	}

	override method encontrarBart() {
		game.say(self, "D'oh! Pequeño demonio!")
		self.perderVida()
	}

	method encontrarBurns() {
		game.say(burns, "Vaya a trabajar!")
		self.perderVida()
	}
	
	method encontrarBarney() {
		game.say(barney, "Traeme otra cerveza!")
		self.perderVida()
	}

	override method llegarATaberna() {
		if( self.rosquillas()==6){
			self.finalJuego()
		}
		else{
			game.say(self, "Traeme mas rosquillas!")
		}


	}
	
	method finalJuego(){
				if(nivel.final()){
			game.say(tabernaMoe, "Ya te emborrachaste mucho! No tenemos mas cervezas")
			game.schedule(2000, {game.stop()})
			}
				 else{			
				nivel = nivel2
				game.say(tabernaMoe, "Llegaste! Toma una Duff! ")
				game.sound("song093.wav")
				game.schedule(2000, { game.clear(); nivel2.iniciar()})
		}
	}

	override method llegarAPlantaNuclear() {
		self.sumarBombas(plantaNuclear.cuantasBombasHay())
		plantaNuclear.restarBombas()
	}

	override method golpeadoPorPiedra() {
		game.say(self, "D'oh! Pequeño demonio!")
		self.perderVida()
	}

} //Fin bomberman

object burns inherits General {


	var property position = game.at(6, 13)
	const direcciones = [ izquierda, derecha, arriba, abajo ]
	var property direccion = izquierda

	method direcciones(num) {
		return direcciones.get(num)
	}

	// method patrulla() {movimientos.move(direccion,self)}
	
	method cambiarDireccion() {
		direccion = direcciones.get(0.randomUpTo(3))
	}

	method patrulla() {
		movimientos.move(direccion, self)
	}

	method image() = if (direccion.soyIzquierda()) "burns-izq.png" else "burns-der.png" 
	
	
	override method nosCruzamosConBomberman(quien) {
		quien.encontrarBurns()
	}

	override method explotoUnaBomba() {
		game.removeTickEvent("Patrulla Burns")
		game.removeVisual(self)
	}



	method chocarPared() {
		movimientos.rebotar(self, direccion)
		direccion = direccion.rebote()
	}





} //Fin burns

object bart inherits General {

	var property position
	
	
	method image() = "bart.jpg"

	override method explotoUnaBomba() {
		game.removeTickEvent("Bart dispara")
		game.removeVisual(self)
	}

	method disparar() {
		var piedra = new Proyectil(position = self.position())
		
		game.addVisual(piedra)
		game.whenCollideDo(piedra, {elemento=>elemento.nosCruzamosConProyectil(piedra)})
		
		piedra.serDisparada()
		game.schedule(1400,{game.removeVisual(piedra)})
	}
	
	override method nosCruzamosConBomberman(quien) {
		quien.encontrarBart()
	}
	

}

object barney inherits General {

	var property position

	method image() = "barney.png"

	override method explotoUnaBomba() {
		//game.removeTickEvent("Barney dispara")
		game.removeVisual(self)
	}
	
	override method nosCruzamosConBomberman(quien) {
		quien.encontrarBarney()
	}

	method disparar() {
		var cerveza = new Proyectil(position = self.position())
		game.addVisual(cerveza)
		game.whenCollideDo(cerveza, {elemento=>elemento.nosCruzamosConEnemigo(cerveza)})
		cerveza.serDisparada()
		//game.onTick(5000, "Fuerapiedra", {=> piedra.chocarPared()})
	}

}

