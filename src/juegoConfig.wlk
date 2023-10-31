import personajes.*
import wollok.game.*


object puntaje {
	var puntos = 0
	const property esPato = false
	const property esPatoDorado = false
	
	method puntos() = puntos
	
	method sumarPuntos(cantidad) {puntos += cantidad}
	
	method position() = game.at(game.width() - 1, game.height() - 4)
	
	method text() = self.puntos().toString()
	
	method matar() {}
	
	method id() = 0
}
	
	
object juego {
	//const musicaFondo = game.sound("sonido.mp3")
	
	method reinicio() {
		self.agregarVisualesJuego()
		self.configurarTeclas()
		self.spawnPatos()
		self.desaparecerPatos()
	//	musicaFondo.shouldLoop(true)
	}
	
	method iniciar(){
		game.cellSize(200)
		game.height(4)
		game.width(6)
		game.title("Duck Hunt")
		game.addVisualCharacter(mira)
		self.reinicio()
	}
	
	method sonidoPato() {
		return game.sound("./sounds/cuack.mp3")
	}
	
	method posicionAleatoria() = game.at(0.randomUpTo(game.width()), 2.randomUpTo(game.height())) 
	
	method agregarVisualPato(){
		game.addVisual(new Patos(position = self.posicionAleatoria()))
		//self.sonidoPato()
	}
	
	method agregarVisualPatoDorado(){
		game.addVisual(new PatosDorados(position = self.posicionAleatoria()))
	}
	
 	method spawnPatos(){
		game.onTick(4000, "pato",{self.agregarVisualPato()})
		game.onTick(13000, "patoDorado",{self.agregarVisualPatoDorado()})
	}

	method desaparecerPatos() { 
		game.onTick(5500, "eliminar pato",{game.allVisuals().findOrDefault({v => v.esPato()}, perro).removerVisual()})
		game.onTick(14500, "eliminar patoDorado",{game.allVisuals().findOrDefault({visual => visual.esPatoDorado()}, perro).removerVisual()})
	}

	method agregarVisualesJuego(){
		game.boardGround("./images/background.jpeg")
		game.addVisual(puntaje)
		game.addVisual(perro)
		// AGREGAR HUD
	}
	
	method configurarTeclas(){
		keyboard.space().onPressDo{mira.disparar()}
	}
}

// Tengo que cambiar el personaje para implementarlo directamente con addVisualCharacter y que
// lo interprete directamente como pj para asi al utilizar el removeVisual solo puede eliminar al
// pato, no estaria mal que guarde la posicion de cada pato como una lista y que ese elemento no puede
// ser repetido, ademas necesito implementar lo mismo con el pj para reconocer dnd esta para disparar