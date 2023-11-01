import juegoConfig.*
import sonidos.*
import wollok.game.*


object arma {
	var balas = 5
	var property position = game.center()

	method balas() = balas
	method position() = position
	method image() = "./imagesTemp/crosshair1.png"
	method esPato() = false
	method esPatoDorado() = false
	method agregarDosBalas() {balas = 5.min(balas + 2)}
	method sonidoDisparoSiHayBalas() {if (balas > 0) {new SonidoDisparos().ejecutarDisparo()}}
	method disparar() {
		self.sonidoDisparoSiHayBalas()
		if(balas > 0) {			
			game.colliders(self).forEach{pato => pato.matar(10)}
		}
		balas = 0.max(balas - 1)
		perro.avisoBalasTotales()
	}
}


object perro {
	var property position = game.at(1, 1)
	
	method esPato() = false
	method esPatoDorado() = false
	method image() = "./images/dog/clue.png"
	method avisoBalasTotales() {game.say(self, "Te quedan " + arma.balas().toString() + " bala/s!")}
	method avisoBalasExtra() {game.say(self, "Se sumaron 2 balas extra!")}
	method matar(score) {}
	method removerVisual() {}
}


class Patos {
	var position
	const sonidoDePato = game.sound("./sounds/cuack.mp3")
	
	method graznidoPato() {
	 	sonidoDePato.volume(0.5)
		sonidoDePato.play()
	}
	method esPato() = true
	method esPatoDorado() = false
	method position() = position
	method image() = "./images/pato1.png" 
	method removerVisual() {game.removeVisual(self)}
	method matar(score) {
		self.removerVisual()
		puntaje.sumarPuntos(score)		
	}
} 


class PatosDorados inherits Patos {
	override method esPato() = !super()
	override method esPatoDorado() = !super()
	override method image() = "./images/patoDorado1.png" 
	override method matar(score) {
		super(score + 20)
		arma.agregarDosBalas() // ARREGLAR. Nunca llega al total de 5 balas, exceptuando al inicio.
		perro.avisoBalasExtra()	
	}
}