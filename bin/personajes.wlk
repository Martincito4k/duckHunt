import juegoConfig.*
import sonidos.*
import wollok.game.*


object arma {
	var property balas = 5
	var property position = game.center()
	const property esPato = false
	const property esPatoDorado = false
	method balas() = balas
	method position() = position
	method image() = "./imagesTemp/crosshair1.png"
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

object balas {
  var property position = game.at(0, 0)
  const property esPato = false
  const property esPatoDorado = false
  method matar() {}

  method image() {
    if (arma.balas() == 5) {
      return "./images/5Balas.png"
    } else if (arma.balas() == 4) {
      return "./images/4Balas.png"
    } else if (arma.balas() == 3) {
      return "./images/3Balas.png"
    } else if (arma.balas() == 2) {
      return "./images/2Balas.png"
    } else if (arma.balas() == 1) {
      return "./images/1Balas.png"
    }else {
      return "./images/0Balas.png"
    }
  }
}

object cuadroPuntos {
  var property position = game.at(5, 0)
  const property esPato = false
  const property esPatoDorado = false
  method matar() {}

  method image() = "./images/score.png"
  }

object perro {
	var property position = game.at(2, 0)
	const property esPato = false
	const property esPatoDorado = false
	
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
	override method esPato() = false
	override method esPatoDorado() = true
	override method image() = "./images/patoDorado1.png" 
	override method matar(score) {
		super(score + 20)
		arma.agregarDosBalas()
		perro.avisoBalasExtra()	
	}
}