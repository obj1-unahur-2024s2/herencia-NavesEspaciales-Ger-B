// 1. Modelo basico
class Nave{
  var velocidad 
  var dirRespectoAlSol
  method velocidad() = velocidad
  method dirRespectoAlSol() = dirRespectoAlSol

  method acelerar(valor){
    velocidad = 100000.min(velocidad + valor)
  }
  method desacelerar(valor) {
    velocidad = 0.max(velocidad - valor)
  }
  method irHaciaElSol() {
    dirRespectoAlSol = 10
  }
  method escaparDelSol() {
    dirRespectoAlSol = -10
  }
  method paraleloAlSol() {
    dirRespectoAlSol = 0
  }
  method acercarseUnPocoAlSol() {
    dirRespectoAlSol = 10.min(dirRespectoAlSol + 1)
  }
  method alejarseUnPocoDelSol() {
    dirRespectoAlSol = (-10).max(dirRespectoAlSol - 1)
  }
  // 2
  method prepararViaje() {
    
  }
}
// 2. Distintos modelos
class NaveBaliza inherits Nave{
  var baliza
  method baliza() = baliza

  method cambioDeColorDeBaliza(colorNuevo) {
    if(not self.esColorValido(colorNuevo))
      throw new DomainException(message = 'No es un color valido')
    else
      baliza = colorNuevo
  }
  method esColorValido(color) = 
    color == 'verde' or color == 'rojo' or color == 'azul'
  
  override method prepararViaje(){
    self.cambioDeColorDeBaliza('verde')
    self.paraleloAlSol()
  }
}

class NavePasajero inherits Nave{
  const nroPasajeros
  var bebida = 0
  var comida = 0
  method bebida() = bebida
  method comida() = comida

  method cargarComida(cantidad) {
    comida = 0.max(comida + cantidad)
  }
  method cargarBebida(cantidad) {
    bebida = 0.max(bebida + cantidad)
  }
  override method prepararViaje(){
    self.cargarBebida(4 * nroPasajeros)
    self.cargarComida(6 * nroPasajeros)
    self.acercarseUnPocoAlSol()
  }
}

class NaveCombate inherits Nave{
  // Visibilidad
  var visible
  method estaVisible() = visible
  method ponerseVisible() {
    visible = true
  }
  method ponerseInvisible() {
    visible = false
  }
  // Misiles
  var desplegados = false
  method misilesDesplegados() = desplegados
  method desplegarMisiles() {
    desplegados = true
  }
  method replegarMisiles() {
    desplegados = false
  }
  // Mensajes
  const mensajes = []
  
  method emitirMensaje(unMensaje) {
    mensajes.add(unMensaje)
  }
  
  method mensajesEmitidos() = mensajes
  
  method primerMensajeEmitido() = 
    if(not mensajes.isEmpty()) mensajes.first() else throw new ExceptionNoHayMensajes()
  
  method ultimoMensajeEmitido() = 
    if(not mensajes.isEmpty()) mensajes.last() else throw new ExceptionNoHayMensajes()
  
  method esEscueta() = mensajes.all({mensajes => mensajes.length() < 30})
  
  method emitioMensaje(unMensaje) = mensajes.any({mensajes => mensajes == unMensaje})
  
  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje('Saliendo en misión')
  }
}
class ExceptionNoHayMensajes inherits DomainException(message = 'No se emitieron mensajes'){}