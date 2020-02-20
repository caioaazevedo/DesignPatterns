/// Exemplo da implementaçao do Design Pattern Observer

import Foundation
/// Este protocolo será o responsável por garantir a comunicação entre os objetos
/// A porperty id será necessária para remover o Observer posteriormente
protocol Observer {
    var id: Int { get set }
    
    func updatePrice(newPrice: Double)
    func updateWarranty(newWarranty: Int)
    func updateProductType(newType: productType)
}

/// Enum meramente ilustrativo para propósitos de abstração dos tipos de porodutos
enum productType{
    case eletronic
    case smartphone
    case business
}

/// Classe Subject - Esta classe será responsável por notificar os objetos sobre alterações, ou seja, a classe que será monitorada
class Product {
    // É o array responsável por guardar as referencias dos Observers
    // nele ocorrerá a remoção e inclusão de novos Observers
    private var observerArray = [Observer]()
    
    // Atributos da Classe
    var code: Int
    var description: String
    var warrantyYears: Int
    var price: Double
    var type: productType
    
    init(code: Int, description: String, warranty: Int, price: Double, type: productType) {
        self.code = code
        self.warrantyYears = warranty
        self.price = price
        self.type = type
        self.description = description
    }
    
    /// Adiciona os Observers no array para notifica-los
    func addObserver(observer: Observer) {
        self.observerArray.append(observer)
    }
    
    /// Remove os Observers do array
    func removeObserver(observer : Observer) {
        observerArray = observerArray.filter{ $0.id != observer.id }
    }
    
    
    /// Funções de alteração do Produto
    func changePrice(newPrice: Double){
        self.price = newPrice
        notifyAllAboutPrice(price: newPrice)
    }
    
    func changeWarranty(newWarranty: Int) {
        self.warrantyYears = newWarranty
        notifyAllAboutWarranty(warranty: newWarranty)
    }
    
    func changeType(newType: productType) {
        self.type = newType
        notifyAllAboutType(type: newType)
    }
    
    
    // Funções para notificar o array de Observers
    func notifyAllAboutPrice(price: Double){
        observerArray.forEach({$0.updatePrice(newPrice: price)})
    }
    
    func notifyAllAboutWarranty(warranty: Int){
        observerArray.forEach({$0.updateWarranty(newWarranty: warranty)})
    }
    
    func notifyAllAboutType(type: productType){
        observerArray.forEach({$0.updateProductType(newType: type)})
    }
    
}

/// Classe que implementa a interface observer e vai reagir as mudanças de comportamento do Subject
class Store : Observer{
    
    /// Properti necessária para remover o elemento do array de Observers
    var id: Int
    
    init(idStore: Int) {
        self.id = idStore
    }
    
    /// Funções responsáveis por realizar o comportamento devido quando o Subject é alterado
    func updatePrice(newPrice: Double) {
        print("Store\(self.id): Product's price has been updated! Now: $ \(newPrice)")
    }
    
    func updateWarranty(newWarranty: Int) {
        print("Store\(self.id): Product's warranty time has been updated! Now: \(newWarranty) year(s)")
    }
    
    func updateProductType(newType: productType) {
        print("Store\(self.id): Product Type has been updated! Type now: \(newType)")
    }
    
}

/// Trecho de código teoricamente no lado do Cliente
var iphone = Product(code: 1123, description: "iPhone XS", warranty: 1, price: 4500, type: .smartphone)

var macbook = Product(code: 2345, description: "Macbook Pro Air", warranty: 3, price: 12700, type: .business)

var newStore = Store(idStore: 1234)

var reseller = Store(idStore: 5678)

iphone.addObserver(observer: newStore)
iphone.addObserver(observer: reseller)

macbook.addObserver(observer: newStore)

iphone.changePrice(newPrice: 5000)
sleep(1)
macbook.changeType(newType: .eletronic)
sleep(1)
iphone.changeWarranty(newWarranty: 3)
sleep(1)
iphone.changeType(newType: .business)

iphone.removeObserver(observer: newStore)




