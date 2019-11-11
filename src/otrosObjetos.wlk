import wollok.game.*
import paredes.*
import niveles.*
import bombas.*
import movimientos.*
import personajes.*
import contadores.*
import clasegeneral.*

 object seleccionador {		
	 
	var property position = game.at(2,7)
	
	var comenzar = game.at(2,7)
	var salir = game.at(2,6)
	
	method image() = "rosquilla.png"
	
	method arriba(){if (salir == position) self.move(arriba,self)}
	
	method abajo(){if (comenzar == position)self.move(abajo,self)}
	
	method move(sentido, personaje) { personaje.position(sentido.hacia(personaje.position())) }
	
	method comenzarJuego(){
		if (position == comenzar) {
			game.schedule(0, { nivel1.iniciar()})
			}
		 else game.stop()
	}
} 

object fondo {
	
	var property position = game.at(0,0)
	
	method image() = "fondoInicio0.png"
	
}

object fondo2 {
	
	var property position = game.at(0,0)
	
	method image() = "fondo2.png"
	
}

object fondo3 {
	
	var property position = game.at(0,0)
	
	method image() = "fondo3.png"
	
}



object tablero {

	method posicionVacia(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
	}

	method agregarRosquilla() {
		var randomPosition = game.at(0.randomUpTo(10), 0.randomUpTo(10))
		if (self.posicionVacia(randomPosition)) {
			game.addVisual(new Rosquilla(position = randomPosition))
		}
	}

	method agregarPared() {
		var randomPosition = game.at(0.randomUpTo(10), 0.randomUpTo(10))
		if (self.posicionVacia(randomPosition)) {
			game.addVisual(new Pared(position = randomPosition))
		}
	}

	method agregarHardPared() {
		var randomPosition = game.at(0.randomUpTo(10), 0.randomUpTo(10))
		if (self.posicionVacia(randomPosition)) {
			game.addVisual(new HardPared(position = randomPosition))
		}
	}

	method contadores() {
		game.addVisualIn(contadorVidas, game.at(1, 14))
		game.addVisualIn(decenaVidas, game.at(2, 14))
		game.addVisualIn(unidadesVidas, game.at(3, 14))
		game.addVisualIn(contadorRosquillas, game.at(4, 14))
		game.addVisualIn(decenaRosquillas, game.at(5, 14))
		game.addVisualIn(unidadesRosquillas, game.at(6, 14))
		game.addVisualIn(contadorBombas, game.at(7, 14))
		game.addVisualIn(decenaBombas, game.at(8, 14))
		game.addVisualIn(unidadesBombas, game.at(9, 14))
	}

}

class Rosquilla inherits General {

	var property position

	method image() = "rosquilla.png"

	override method nosCruzamosConBomberman(quien) {
		quien.encontrarRosquilla()
		game.removeVisual(self)
	}

}

object plantaNuclear inherits General {

	var bombas = 5

	method image() = "plantaNuclear.png"

	method cuantasBombasHay() {
		return bombas
	}

	method restarBombas() {
		bombas = bombas - bombas
	}

	override method explotoUnaBomba() {
		bomberman.perderTodasLasVidas()
		bomberman.cuantasVidas()
	}

	override method nosCruzamosConBomberman(quien) {
		quien.llegarAPlantaNuclear()
	}

	method fabricarBombas() {
		bombas = 5
		}

} //Fin object planta nuclear

object tabernaMoe inherits General {

	method image() = "tabernaMoe.jpg"

	override method nosCruzamosConBomberman(quien) {
		quien.llegarATaberna()
	}

} //Fin tabernaMoe

class Proyectil inherits General {

	var property position

	method image() = "piedra2.png"

	override method nosCruzamosConBomberman(quien) {
		quien.golpeadoPorPiedra()
	}


	method serDisparada() {
		game.onTick(100, "Lanzar", {=> movimientos.move(abajo, self)})

	}
	
	
	method chocarPared(){
		game.removeVisual(self)
		//game.removeTickEvent("Lanzar")
	}


} //Fin piedra

class Vomito inherits General {

	method image() = "vomito.png"

}

object trigger inherits General{
	var property position
	
	var property trigger = 0
	
	method image() = "transparencia.png"
	
	override method nosCruzamosConBomberman(quien){
		if (trigger == 0){
		game.onTick(2000,"Bart dispara",{bart.disparar()})
		trigger++
		}
		
	}
}
