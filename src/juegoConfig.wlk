import personajes.*
import sonidos.*
import wollok.game.*

	
object juego {
	method inicio() {
        game.clear()
        game.title("Duck Hunt")
        game.cellSize(200)
        game.height(4)
        game.width(6)
        game.addVisual(fondoReglas)
        musicaDeInicio.musicaDeFondo(musicaDeInicio.musicIntro())
        keyboard.enter().onPressDo{self.iniciarJuego()}
	}
	method iniciarJuego() {
		musicaDeInicio.sacarMusica(musicaDeInicio.musicIntro())
    	game.clear()
    	musicaDeJuego.musicaDeFondo(musicaDeJuego.musicGame())
        game.cellSize(200)
        game.height(4)
        game.width(6)
        game.title("Duck Hunt")
        self.configurarTeclas()
        self.agregarVisualesJuego()
		self.spawnPatos()
		self.desaparecerPatos()
    }
	method configurarTeclas() {
		keyboard.space().onPressDo{arma.disparar()}
	}
	method agregarVisualPato() {
		const generacionPato = new Patos(position = self.posicionAleatoria())
		game.addVisual(generacionPato)
		generacionPato.graznidoPato()
	}
	method agregarVisualPatoDorado() {
		const generacionPatoDorado = new PatosDorados(position = self.posicionAleatoria())
		game.addVisual(generacionPatoDorado)
		generacionPatoDorado.graznidoPato()
		// POSIBLE IDEA de agregar un removerVisual ya con la constante de la instancia en este metodo, para cada uno (Sin necesidad del metodo desaparecerPatos)
	}
	method agregarVisualesJuego() {
		game.addVisual(fondoJuego)
		game.addVisual(puntaje)
		game.addVisual(perro)
		game.addVisualCharacter(arma)
		// AGREGAR HUD
	}
	method posicionAleatoria() {
        const posicionRandom =  game.at(0.randomUpTo(game.width()), 2.randomUpTo(game.height()))
        return 
        	if(game.getObjectsIn(posicionRandom).isEmpty()) {posicionRandom}
       		else {self.posicionAleatoria()}
	} 
 	method spawnPatos() {
		game.onTick(5000, "pato",{self.agregarVisualPato()})
		game.onTick(13000, "patoDorado",{self.agregarVisualPatoDorado()})
	}
	method desaparecerPatos() { 
		game.onTick([4500, 5500].anyOne(), "eliminar pato",{game.allVisuals().findOrDefault({visual => visual.esPato()}, perro).removerVisual()})
		game.onTick(14000, "eliminar patoDorado",{game.allVisuals().findOrDefault({visual => visual.esPatoDorado()}, perro).removerVisual()})
	}
}


object puntaje {
	var puntos = 0
	const property esPato = false
	const property esPatoDorado = false
	
	method puntos() = puntos
	method position() = game.at(game.width() - 1, game.height() - 4)
	method text() = self.puntos().toString()
	method matar(score) {}
	method sumarPuntos(cantidad) {puntos += cantidad}
}


object fondoReglas {
	const property esPato = false
	const property esPatoDorado = false
	const property image = "./images/pantallaReglas.jpg"
	const property position = game.at(0,0)
	
	method matar(score) {}
}


object fondoJuego {
	const property esPato = false
	const property esPatoDorado = false
	const property image = "./images/background.jpeg"
	const property position = game.at(0,0)
	
	method matar(score) {}
}