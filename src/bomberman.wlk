import wollok.game.*


object bomberman {

	var property position = game.at(1,1)
	
	method image() = "homero.png"	

	
	method colocaBomba(){
		
		
	}
	
} //Fin bomberman

object tabernaMoe {
	
	var position = game.at(10,10)
	
	method image() = "tabernaMoe.jpg"
	
	method position() {return position}
	
}

