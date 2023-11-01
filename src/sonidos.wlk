import juegoConfig.*
import personajes.*
import wollok.game.*


class SonidoDisparos {
	const empezarDisparo = game.sound("./sounds/shot2.mp3")
	
	method ejecutarDisparo() {
		empezarDisparo.volume(0.5)
		empezarDisparo.play()
	}
}


class Musica {
	method musicaDeFondo(musica) {
		musica.shouldLoop(true)
		musica.volume(0.5)
		game.schedule(200, {musica.play()})
	}	
	method sacarMusica(musica) {musica.stop()}
}


object musicaDeInicio inherits Musica {
	const property musicIntro = game.sound("./sounds/levelStart.mp3")
}


object musicaDeJuego inherits Musica {
	const property musicGame = game.sound("./sounds/intro.mp3")
}


object musicaFinal inherits Musica {
	const property finalMusic = game.sound("./sounds/levelComplete.mp3")
}