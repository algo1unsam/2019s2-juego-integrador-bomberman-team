import wollok.game.*
import paredes.*
import niveles.*
import bombas.*
import movimientos.*
import bomberman.*

object tablero {

	method agregarRosquilla() {
		var randomPosition = game.at(0.randomUpTo(10), 0.randomUpTo(10))
		if (self.posicionVacia(randomPosition)) {
			game.addVisual(new Rosquilla(position = randomPosition))
		}
	}
	
	method posicionVacia(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
	}
}


class Rosquilla {

	var property position

	method image() = "rosquilla.jpg"

	method explotoUnaBomba() {}

	method nosCruzamos() {
		bomberman.encontrarRosquilla()
		game.removeVisual(self)
	}
}

object plantaNuclear {
	
	var bombas = 5
	var property position = game.at(13,3)
	
	method image() = "plantaNuclear.jpg"
	
	method cuantasBombasHay() {
		return bombas
	}
	
	method explotoUnaBomba() {
		bomberman.vidas(0)
	}
	
	method nosCruzamos() {
		bomberman.sumarBombas(bombas)
		bombas = bombas - bombas
	}

	method fabricarBombas() {
		if (self.cuantasBombasHay() == 0) {
			bombas = bombas + 1
		}
	}	
} //Fin object planta nuclear

object bart {
	
	var property position = game.at(9,13)
	
	method image() = "bart.jpg"
	
	method explotoUnaBomba() {}
	
	method nosCruzamos() {}
	
	method disparar() {}
}

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
	
	method nosCruzamos() {
		game.say(self,"Vaya a trabajar!")
		bomberman.perderVida()
	}
	
	method explotoUnaBomba() {
		game.say(self,"Intenta matarme? Está despedido!")
		bomberman.perderVida()
	}
}

object moverIzq{
	
	method mover(enemigo){if (!(enemigo.position() == enemigo.limite1()) ) movimientos.move(izquierda,enemigo) else enemigo.cambioDir()}
	
}

object moverDer{
	
	method mover(enemigo){if (!(enemigo.position() == enemigo.limite2())) movimientos.move(derecha,enemigo) else enemigo.cambioDir()}
	
}