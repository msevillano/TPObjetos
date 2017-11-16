object joaquin {
	var solista = true
	var habilidad = 20
	/*Setter */
	method solista(unValor) {
		solista = unValor
	}
	/*Getter */
	method solista() {
		return solista
	}

	method habilidad() {
		if(solista) {
			return habilidad
		} else {
			return (habilidad + 5)
		}
	}
	
	method interpretaBien(unaCancion) {
		return (unaCancion.duracion() > 300)
	}
	
	method cobra(unaPresentacion) {
		if(unaPresentacion.tocaSolo()){
			return 100 * unaPresentacion.duracion()
		} else {
			return 50
		}		
	}

}

object lucia {
	var solista = true
	var habilidad = 70
	/*Setter */
	method solista(unValor) {
		solista = unValor
	}
	/*Getter */
	method solista() {
		return solista
	}
	
	method habilidad() {
		if(solista) {
			return habilidad
		} else {
			return (habilidad - 20)
		}
	}
	
	method interpretaBien(unaCancion) {
		return (unaCancion.tienePalabra("familia"))
	}
	
	method cobra(unaPresentacion) {
		if(self.lugarConcurrido(unaPresentacion)){
			return 500
		} else {
			return 400
		}		
	}
	
	method lugarConcurrido(unaPresentacion) {
		return unaPresentacion.capacidad() > 5000	
	}
	
}

object luisAlberto {
	var guitarraToca
	/*Setter */
	method guitarraToca(unaGuitarra) {
		guitarraToca = unaGuitarra
	}
	/*Getters */
	method guitarraToca() {
		return guitarraToca
	}
	
	method habilidad() {
		if(self.multiplicarPrecioGuitarraPor(8) > 100) {
			return 100
		} else {
			return self.multiplicarPrecioGuitarraPor(8)
		}
	}
	
	method interpretaBien () = true
		
	method cobra(unaPresentacion) {
		if(self.anterior(unaPresentacion)) {
			return 1000
		} else {
			return 1200
		}
	}
	
	method anterior(unaPresentacion) {
		return unaPresentacion.fecha().year() <= 2017 && unaPresentacion.fecha().month() < 9
	}
	
	method multiplicarPrecioGuitarraPor(unNum) {
		return guitarraToca.precio()*unNum
	}
}

object fender {
	var precio = 10
	/*Setter */
	method precio(unPrecio) {
		precio = unPrecio
	}
	/*Getter */
	method precio () {
		return precio
	}
}

object gibson {
	var estaSana = true
	/*Setter */
	method estaSana(unValor) {
		estaSana = unValor
	}
	/*Getter */
	method estaSana() {
		return estaSana
	}
	
	method precio() {
		if(estaSana) {
			return 15
		} else {
			return 5
		}
	}
}

class Cancion {
	var duracion
	var letra = []
	/*Setters */
	method duracion(unaDuracion) {
		duracion = unaDuracion
	}
	method letra(listaDePalabras) {
		letra.addAll(listaDePalabras)
	}
	/*Getters */
	method duracion() {
		return duracion
	}
	
	method tienePalabra(unaPalabra) {
		return (letra.contains(unaPalabra))
	}
	
}

class Presentacion {
	var fecha
	var lugar
	var cantantes = []
	var duracion
	/*Setters */
	method fecha(unaFecha) {
		fecha = unaFecha
	}
	method lugar(unLugar) {
		lugar = unLugar
	}
	method duracion(unaDuracion) {
		duracion = unaDuracion
	}
	/*Getters */
	method fecha() {
		return fecha
	}
	method lugar() {
		return lugar
	}
	method duracion() {
		return duracion
	}

	method capacidad() {
		return lugar.capacidad()
	}	
	method agregarCantante(unCantante) {
		cantantes.add(unCantante)	
	}
	method tocaSolo() {
		return (cantantes.size() == 1)
	}
	method calcularCosto() {
		return cantantes.sum({cantante => cantante.cobra(self)})
	}
}

class Lugar {
	var capacidad
	var nombre
	/*Setter */
	method capacidad(unaPresentacion) {
		if(nombre.contains("Luna Park")) {
			capacidad = 9290
		} else {
			self.calcularCapacidad(unaPresentacion)
		}
	}
	method nombre(unNombre) {
		nombre = unNombre
	}
	/*Getter */
	method capacidad() {
		return capacidad
	}
	method nombre() {
		return nombre
	}
	
	method calcularCapacidad(unaPresentacion) {
		if(unaPresentacion.fecha().dayOfWeek() == 6) {
			capacidad =  700
		} else {
			capacidad = 400
		}	
	}
	
}