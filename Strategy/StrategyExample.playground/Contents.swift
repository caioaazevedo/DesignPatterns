/// Trecho de Código destinado a exemplificar o Padrão de Projeto Strategy
/// indicado quando se tem uma Classe que necessita desempenha uma mesma atividade de maneiras diferentes
import UIKit

/// Classe Eventos que servirá como base para a ordenação
struct Event {
    var local: String
    var title: String
    var date: Date
    var type: typeEvent
    
    init(local: String, title: String, date: Date, type: typeEvent) {
        self.local = local
        self.title = title
        self.date = date
        self.type = type
    }
}

enum typeEvent {
    case health
    case fun
    case food
    case social
}

/// Classe responsável por delegar a ação para o método de ordenação desejado -  papel do (Context)
class ListOrganize {
    var strategy: Strategy
    var orderEvents: [Event]
    
    init(strategy: Strategy) {
        self.strategy = strategy
        self.orderEvents = [Event]()
    }
    
    func alterStrategy(strategy: Strategy){
        self.strategy = strategy
    }
    
    func filterByStrategy(events: [Event]) -> [Event] {
        self.orderEvents = self.strategy.filter(events: events)
        
        return self.orderEvents
    }
}

/// Protocolo para ditar o comportamento das diferentes Strategies
protocol Strategy {
    func filter(events: [Event]) -> [Event]
}

/// Strategie que desempenhará a ação de filtrar os eventos de acordo com seu papel - Filtrar por Titulo
struct FilterByTitle : Strategy {
    
    func filter(events: [Event]) -> [Event]{
        var newEventList: [Event]
        
        newEventList = events.sorted(by: { $0.title > $1.title })
        
        return newEventList
    }
}

/// Strategie que desempenhará a ação de filtrar os eventos de acordo com seu papel - Filtrar por Local
struct FilterByLocal : Strategy {
    
    func filter(events: [Event]) -> [Event]{
        var newEventList: [Event]
        
        newEventList = events.sorted(by: { $0.local > $1.local })
        
        return newEventList
    }
}

/// Strategie que desempenhará a ação de filtrar os eventos de acordo com seu papel - Filtrar por Date
struct FilterByDate : Strategy {
    
    func filter(events: [Event]) -> [Event]{
        var newEventList: [Event]
        
        newEventList = events.sorted(by: { $0.date > $1.date })
        
        return newEventList
    }
}



/// Inicio do código do Cliente

// Criação do Array de Eventos
var eventList = [Event(local: "Taguatinga", title: "Doutor Narciso", date: Date().addingTimeInterval(70), type: .health), Event(local: "Samambaia", title: "Aniversário do Primo", date: Date().addingTimeInterval(30), type: .social), Event(local: "Brasilia", title: "Cinema", date: Date(), type: .fun), Event(local: "Caldas Novas", title: "Sushi Loko", date: Date().addingTimeInterval(10), type: .food)]

// Instanciação das Strategies
var strategyTitle = FilterByTitle()
var strategyDate = FilterByDate()
var strategyLocal = FilterByLocal()

// Instanciação do Context passando qual estratégia deverá adotar
var lstOrganize = ListOrganize(strategy: strategyTitle)

print(lstOrganize.filterByStrategy(events: eventList))
print()

lstOrganize.alterStrategy(strategy: strategyDate)

print(lstOrganize.filterByStrategy(events: eventList))
print()


lstOrganize.alterStrategy(strategy: strategyLocal)

print(lstOrganize.filterByStrategy(events: eventList))
print()
