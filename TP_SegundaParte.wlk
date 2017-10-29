class Musico 
{
	var habilidad
	var solista
	var albumes = []
	/**************************Set & Get**********************************/
	method habilidad(cant)
	{
		habilidad = cant
	}	
	method solista(val){
		solista = val
	}
	method agregarAlbum(album)
	{
		albumes.add(album)
	}
	method agregarAlbumes(listAlbumes)
	{
		albumes.addAll(listAlbumes)
	}
	
	
	method habilidad()
	{
		return habilidad
	}
	method solista()
	{
		return solista
	}
	method albumesPublicados()
	{
		return albumes
	}
	
	
	/***************************Funcionalidades*********************/
	method esMinimalista()
	{
		return albumes.all({album => album.cancionesCortas()})
	}
	
	method cancionesConPalabra(word)
	{
		/*Esta opcion comentada, wollow me dice que la intente anidar como si fuese un oneliner
		 * para nosotros es lo mas prolijo, pero dejamos ambas opciones.
		 *var listaCanciones = (albumes.map({album => album.cancionesConPalabra(unaPalabra.toLowerCase())})).flatten()
		 *return listaCanciones.map({cancion => cancion.titulo()})
		 */
		 
		// Opcion segun wollok
		return ((albumes.map({album => album.cancionesConPalabra(word.toLowerCase())})).flatten()).map({cancion => cancion.titulo()})
	}
	
	method segundosDeObra()
	{ 
		return (albumes.map({album => album.duracionAlbum()})).sum()
	}
	
	method laPego()
	{
		var porcentajes = albumes.map({album => album.porcentajeVendido()})
		return ((porcentajes.sum())/porcentajes.size() > 75)
	}
}

class MusicoDeGrupo inherits Musico
{
	var plusPorGrupo
	
	constructor(_habilidad, _plusPorGrupo)
	{
		habilidad = _habilidad
		plusPorGrupo = _plusPorGrupo 
	}
	
	method interpretaBien(cancion) 
	{
		return (cancion.duracion() > 300)
	}
	
	method cobra(show) 
	{
		if(show.tocaSolo()){
			return 100 * show.duracion()
		} else {
			return 50+plusPorGrupo
		}		
	}
	
	override method habilidad() 
	{
		if(solista) 
		{
			return habilidad
		} else 
		{
			return (habilidad + 5)
		}
	}
}

class VocalistaPopular inherits Musico
{
	var palabraInspiradora
	
	constructor(_habilidad, _palabraInspiradora)
	{
		habilidad = _habilidad
		palabraInspiradora = _palabraInspiradora
	}
	
	method interpretaBien(cancion) 
	{
		return (cancion.tienePalabra(palabraInspiradora))
	}
	method cobra(presentacion) 
	{
		if(self.lugarConcurrido(presentacion))
		{
			return 500
		} else {
			return 400
		}		
	}
	method lugarConcurrido(presentacion) 
	{
		return presentacion.capacidad() > 5000	
	}
	
	override method habilidad() 
	{
		if(solista) 
		{
			return habilidad
		} else 
		{
			return (habilidad - 20)
		}
	}
}

object luisAlberto inherits Musico{
	var guitarraToca
	
	/**************************Set & Get**********************************/
	
	method guitarraToca(guitarra) 
	{
		guitarraToca = guitarra
	}
	
	method guitarraToca() 
	{
		return guitarraToca
	}
	
	method interpretaBien () = true
	method cobra(presentacion) 
	{
		if(self.anterior(presentacion)) 
		{
			return 1000
		} else 
		{
			return 1200
		}
	}
	method anterior(presentacion) 
	{
		return presentacion.fecha().year() == 2017 && presentacion.fecha().month() < 9
	}
	
	override method habilidad() 
	{
		if((guitarraToca.precio()*8) > 100) 
		{
			return 100
		} else 
		{
			return (guitarraToca.precio() *8)
		}
	}
}

object fender 
{
	var precio = 10
	
	method precio(valor) 
	{
		precio = valor
	}
	
	method precio () 
	{
		return precio
	}
}

object gibson {
	var estaSana = true
	
	method estaSana(valor) 
	{
		estaSana = valor
	}
	
	method estaSana() 
	{
		return estaSana
	}
	
	method precio() 
	{
		if(estaSana) 
		{
			return 15
		} else 
		{
			return 5
		}
	}
}

class Album
{
	var titulo
	var fechaLanzamiento
	var unidadesALaVenta
	var unidadesVendidas
	var canciones
	
	constructor(_titulo, _fechaLanzamiento, _unidadesALaVenta, _unidadesVendidas, _canciones)
	{
		titulo = _titulo
		fechaLanzamiento = _fechaLanzamiento
		unidadesALaVenta = _unidadesALaVenta
		unidadesVendidas = _unidadesVendidas
		canciones = _canciones
	}
	
	method cancionesCortas()
	{
		return canciones.all({cancion => cancion.esCorta()})
	}
	
	method porcentajeVendido()
	{
		return (unidadesVendidas*100)/unidadesALaVenta
	}
	method cancionesConPalabra(unaPalabra)
	{
		var listaCanciones = []
		canciones.forEach({cancion =>if(cancion.tienePalabra(unaPalabra)){listaCanciones.add(cancion)}})
		return listaCanciones
	}
	
	method duracionAlbum()
	{
		return (canciones.map({cancion => cancion.duracion()})).sum()
	}

	method cancionMasLarga()
	{
		return canciones.max({cancion => cancion.largoCancion()}).titulo()
	}
}

class Cancion
{
	var titulo
	var letra
	var duracion
	
	constructor(_titulo, _letra, _duracion)
	{
		titulo = _titulo
		letra = _letra
		duracion = _duracion
	}
	
	method duracion()
	{
		return duracion
	}
	
	method titulo()
	{
		return titulo
	}
	method tienePalabra(word) 
	{
		return (letra.toLowerCase().contains(word))
	}
	
	method esCorta()
	{
		return ((duracion/60) < 3)
	}
	
	method largoCancion(){
		return letra.size()
	}
}

class Presentacion 
{
	var fecha
	var lugar
	var cantantes = []
	var duracion
	/*Setters */
	method fecha(date) 
	{
		fecha = date
	}
	method lugar(place) 
	{
		lugar = place
	}
	method duracion(time) 
	{
		duracion = time
	}
	
	method fecha() 
	{
		return fecha
	}
	method lugar() 
	{
		return lugar
	}
	method duracion() 
	{
		return duracion
	}

	method capacidad() 
	{
		return lugar.capacidad()
	}	
	method agregarCantante(cantante) 
	{
		cantantes.add(cantante)	
	}
	method tocaSolo() 
	{
		return (cantantes.size() == 1)
	}
	method calcularCosto() 
	{
		return cantantes.sum({cantante => cantante.cobra(self)})
	}
}

class Lugar 
{
	var capacidad
	var nombre
	
	method capacidad(presentacion) 
	{
		if(nombre.contains("Luna Park")) 
		{
			capacidad = 9290
		} else 
		{
			self.calcularCapacidad(presentacion)
		}
	}
	method nombre(name) 
	{
		nombre = name
	}
	
	method capacidad() 
	{
		return capacidad
	}
	method nombre() 
	{
		return nombre
	}
	
	method calcularCapacidad(unaPresentacion) 
	{
		if(unaPresentacion.fecha().dayOfWeek() == 6) 
		{
			capacidad =  700
		} else 
		{
			capacidad = 400
		}	
	}	
}