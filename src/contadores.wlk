import paredes.*
import wollok.game.*
import personajes.*
import clasegeneral.*

class Contador inherits HardPared {
	
	override method nosCruzamosConBomberman(quien) {}
	override method nosCruzamosConEnemigo(quien) {}
	override method nosCruzamosConProyectil(quien) {}
	
}

object contadorVidas inherits Contador {
	override method image() = "HardBlockHomero.jpg"
}

object contadorRosquillas inherits Contador {
	override method image() = "HardBlockRosquillas.png"
}

object contadorBombas inherits Contador {
	override method image() = "HardBlockBombas.png"
}

class Numero inherits Contador {
	
	method vidasBomberman0a9() =  bomberman.vidas().between(0,9)
	method rosqBomberman0a9() =  bomberman.rosquillas().between(0,9)
	method bombasBomberman0a9() =  bomberman.bombas().between(0,9)
	
	method vidasString() =  bomberman.vidas().toString()
	method rosqString() =  bomberman.rosquillas().toString()
	method bombString() =  bomberman.bombas().toString()
	
	method subString(algo,num1,num2) {return algo.substring(num1,num2)}
}

object decenaVidas inherits Numero {
	
	override method image() = if (self.vidasBomberman0a9()) return "0.jpg" 
		else 
		return self.subString(self.vidasString(),0,1) + ".jpg"
}

object unidadesVidas inherits Numero {	

	override method image() = if (self.vidasBomberman0a9()) return self.vidasString() + ".jpg" 
		else
		return self.subString(self.vidasString(),1,2) + ".jpg"
}

object decenaRosquillas inherits Numero {	

	override method image() = if (self.rosqBomberman0a9()) return "0.jpg" 
		else 
		return self.subString(self.rosqString(),0,1) + ".jpg"
}

object unidadesRosquillas inherits Numero {	

	override method image() = if (self.rosqBomberman0a9()) return self.rosqString() + ".jpg" 
		else
		return self.subString(self.rosqString(),1,2) + ".jpg"
}

object decenaBombas inherits Numero {

	override method image() = if (self.bombasBomberman0a9()) return "0.jpg" 
		else
		return self.subString(self.bombString(),0,1) + ".jpg"
}

object unidadesBombas inherits Numero {
	
	override method image() = if (self.bombasBomberman0a9()) return self.bombString() + ".jpg"
		else
		return self.subString(self.bombString(),1,2) + ".jpg"
}

