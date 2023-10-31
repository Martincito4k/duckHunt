import juegoConfig.*
import personajes.*
import wollok.game.*


const sonidoPato = game.sound("./sounds/cuack.mp3")



class Musica {
	method musicaDeFondo() 
	method sacarMusica()
}


class MusicaDeInicio inherits Musica {
	const musicIntro = game.sound("./sounds/levelStart.mp3")
	
	override method musicaDeFondo() {
		musicIntro.shouldLoop(true)
		game.schedule(200, {musicIntro.play()})
	}
	override method sacarMusica() {musicIntro.stop()}
}


class MusicaDeJuego inherits Musica {
	const musicGame = game.sound("./sounds/intro.mp3")
	
	override method musicaDeFondo() {
		musicGame.shouldLoop(true)
		game.schedule(200, {musicGame.play()})
	}
	override method sacarMusica() {musicGame.stop()}
}


class MusicaFinal inherits Musica {
	const finalMusic = game.sound("./sounds/levelComplete.mp3")
	
	override method musicaDeFondo() {		
		finalMusic.shouldLoop(true)
		game.schedule(200, {finalMusic.play()})
	 }
	override method sacarMusica() {finalMusic.stop()}
}