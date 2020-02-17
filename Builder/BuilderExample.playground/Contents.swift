/// Trecho de Código destinado a exemplificar o Padrão de Projeto de Criaão Builder
/// indicado na criação de Classe Complexa com diversos parâmetros a serem inicializados

/// Classe Comolexa com diversos parametros e construtor grande
// Nessa classe uma forma de melhorar suas inicializações seria dividindo este processo
struct Car {
    var chassi: String
    var year: Int
    var color: carColor
    var engine: engineModel
    var seats: Int
    var airBag: Bool
    
    init() {
        self.chassi = String()
        self.year = Int()
        self.seats = Int()
        self.airBag = false
        self.color = carColor.black
        self.engine = engineModel.boxer
    }
}

/// Interface que fornece os passos comuns aos Builders
protocol Builder {
    func setChassi(carChassi: String)
    func setYear(carYear: Int)
    func setColor(color: carColor)
    func setEngine(engine: engineModel)
    func setSeats(number: Int)
    func setAirbag(hasAirbag: Bool)
    func returnCar() -> Car
}

/// Classe Builder: responsável pela rotina de criação dos objetos
/// Este Builder se especializa em Criar Carros Clássicos, por exemplo
class CassiCarBuilder : Builder{
    
    var car: Car?
    
    init() {
        
    }
    
    func createCar(){
        self.car = Car()
    }
    
    func setChassi(carChassi: String) {
        self.car!.chassi = carChassi
    }
    
    func setYear(carYear: Int) {
        self.car!.year = carYear
    }
    
    func setColor(color: carColor) {
        self.car!.color = color
    }
    
    func setEngine(engine: engineModel) {
        self.car!.engine = engine
    }
    
    func setSeats(number: Int) {
        self.car!.seats = number
    }
    
    func setAirbag(hasAirbag: Bool) {
        self.car!.airBag = hasAirbag
    }
    
    func returnCar() -> Car {
        return self.car!
    }
}

/// Classe Builder: responsável pela rotina de criação dos objetos
/// Este Builder se especializa em Criar Super Carros, por exemplo
class SuperCarBuilder : Builder{
     var car: Car?
    
    init() {
        
    }
        
    func createCar(){
        self.car = Car()
    }
    
    func setChassi(carChassi: String) {
        self.car!.chassi = carChassi
    }
    
    func setYear(carYear: Int) {
        self.car!.year = carYear
    }
    
    func setColor(color: carColor) {
        self.car!.color = color
    }
    
    func setEngine(engine: engineModel) {
        self.car!.engine = engine
    }
    
    func setSeats(number: Int) {
        self.car!.seats = number
    }
    
    func setAirbag(hasAirbag: Bool) {
        self.car!.airBag = hasAirbag
    }
    
    func returnCar() -> Car {
        return self.car!
    }
}

/// Classe Builder: responsável pela rotina de criação dos objetos
/// Este Builder se especializa em Criar Carros Normais, por exemplo
class NormalCarBuilder : Builder{
    var car: Car?
        
    init() {
        
    }
    
    func createCar(){
        self.car = Car()
    }
    
    func setChassi(carChassi: String) {
        self.car!.chassi = carChassi
    }
    
    func setYear(carYear: Int) {
        self.car!.year = carYear
    }
    
    func setColor(color: carColor) {
        self.car!.color = color
    }
    
    func setEngine(engine: engineModel) {
        self.car!.engine = engine
    }
    
    func setSeats(number: Int) {
        self.car!.seats = number
    }
    
    func setAirbag(hasAirbag: Bool) {
        self.car!.airBag = hasAirbag
    }
    
    func returnCar() -> Car {
        return self.car!
    }
}

// Classe Director: responsável por definir a ordem de execussão dos builders
struct Director {
    
    func makeCarClassiCar(builder: CassiCarBuilder){
        builder.createCar()
        builder.setSeats(number: 5)
        builder.setChassi(carChassi: "Opalao")
        builder.setColor(color: carColor.black)
        builder.setEngine(engine: engineModel.v8)
        builder.setAirbag(hasAirbag: false)
        builder.setYear(carYear: 1971)
    }
    
    func makeCarSuperCar(builder: SuperCarBuilder){
        builder.createCar()
        builder.setSeats(number: 2)
        builder.setChassi(carChassi: "One")
        builder.setColor(color: carColor.white)
        builder.setEngine(engine: engineModel.v12)
        builder.setAirbag(hasAirbag: true)
        builder.setYear(carYear: 2015)
    }
    
    func makeCarNormalCar(builder: NormalCarBuilder){
        builder.createCar()
        builder.setSeats(number: 5)
        builder.setChassi(carChassi: "Celtinha")
        builder.setColor(color: carColor.red)
        builder.setEngine(engine: engineModel.v6)
        builder.setAirbag(hasAirbag: true)
        builder.setYear(carYear: 2008)
    }
    
}

/// Enums meramente por motivos de abstração do Exemplo
enum carColor{
    case black
    case white
    case red
    case blue
    case yellow
    case orange
}

enum personEyes {
    case pulledEyes
    case clearEyes
    case darkEyes
}

enum engineModel{
    case v6
    case v8
    case v10
    case v12
    case boxer
    case w12
    case w16
}


/// Código que seria realizado no lado do Cliente, fora do Padrão de Design Builder
var diretor = Director()
var builder = CassiCarBuilder()
diretor.makeCarClassiCar(builder: builder)

var  car = builder.returnCar()

print("\(car.chassi) - \(car.airBag) - \(car.color) - \(car.engine)")

var superBuilder = SuperCarBuilder()
diretor.makeCarSuperCar(builder: superBuilder)

var superCar = superBuilder.returnCar()

print("\(superCar.chassi) - \(superCar.airBag) - \(superCar.color) - \(superCar.engine)")
