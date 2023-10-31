import wollok.game.*
import juegoConfig.*


object arma {
	var balas = 5
	var property position = game.center()
	const property sonidoDisparo = game.sound("./sounds/shot.mp3")
	const property esPato = false
	const property esPatoDorado = false
	
	method balas() = balas
	method position() = position
	method image() = "./imagesTemp/crosshair1.png"
	method agregarDosBalas() {balas = 5.min(balas + 2)}
	method disparar() {
		sonidoDisparo.play()
		balas = 0.max(balas - 1)
		if(balas > 0) {			
			game.colliders(self).forEach{x => x.matar(10)}
		}
		perro.avisoBalasTotales()
	}
}


object perro {
	var property position = game.at(1, 1)
	const property esPato = false
	const property esPatoDorado = false
	
	method image() = "./images/dog/clue.png"
	method avisoBalasTotales() {game.say(self, "Te quedan " + arma.balas().toString() + " balas!")}
	method avisoBalasExtra() {game.say(self, "Se sumaron 2 balas extra!")}
	method matar(score) {}
	method removerVisual() {}
}


class Patos {
	var position
	
	method esPato() = true
	method esPatoDorado() = false
	method position() = position
	method image() = "./images/bicho1.png" 
	method removerVisual() {game.removeVisual(self)}
	method matar(score) {
		self.removerVisual()
		puntaje.sumarPuntos(score)		
	}
} 


class PatosDorados inherits Patos {
	override method esPato() = false
	override method esPatoDorado() = true
	override method image() = "./images/bicho2.png" 
	override method matar(score) {
		super(score + 20)
		arma.agregarDosBalas()
		perro.avisoBalasExtra()	
	}
}