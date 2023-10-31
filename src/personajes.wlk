import wollok.game.*
import juegoConfig.*

object mira {
	var property position = game.center()
	var balas = 5
	const property esPato = false
	const property esPatoDorado = false
	
	method balas() = balas
	
	method agregarDosBalas() {
		balas += 2
	}
	
	method position(){
		return position}
	
	method image() = "./imagesTemp/crosshair1.png"
	
	method disparar(){
		if(balas > 0) {			
			game.colliders(self).forEach{x => x.matar(10)}
		}
		balas = 0.max(balas - 1)
		perro.avisoBalasTotales()
	}
}
	

class Patos {
	var position
	
	method position() = position
	
	method esPato() = true
	
	method esPatoDorado() = false
	
	method image() = "./images/bicho1.png" 
	
	method removerVisual(){
		game.removeVisual(self)
	}
	
	method matar(puntos) {
		self.removerVisual()
		puntaje.sumarPuntos(puntos)		
	}
} 


class PatosDorados inherits Patos {
	override method esPato() = false
	override method esPatoDorado() = true
	override method image() = "./images/bicho2.png" 
	override method matar(puntos) {
		super(puntos + 20)
		mira.agregarDosBalas()
		perro.avisoBalasExtra()	
	}
}


object perro {
	var property position = game.at(1, 1)
	const property esPato = false
	const property esPatoDorado = false
	method image() = "./images/dog/clue.png"
	method avisoBalasTotales() {game.say(self, "Te quedan " + mira.balas() + " balas!")}
	method avisoBalasExtra() {game.say(self, "Se sumaron 2 balas extra!")}
	method matar() {}
	method removerVisual() {}
}
