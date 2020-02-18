/// Cóodigo destinado a exemplificar o Padrão de Projeto Singleton no contexto de acesso ao Cloud Kit

import CloudKit

///Classe Singleton que é instanciada somente uma vez e disponivel de forma Global
class Cloud {
    
    // Variável  que armazena a instancia que sera acessada
    static var instance = Cloud()
    
    // Construtor privado, visivel somente para Classe
    private init() {}
    
    var fullName = ""
    
    // Para usar o container padrão basta usar o Default Container
    static let container = CKContainer.default()
    
    static let containerIdentifier = "iCloud.CaioAzevedo.CloudKitTutorial"
    static let cloudContainer = CKContainer(identifier: containerIdentifier)
    
    // Este método faz o fetch de todas as zonas presentes no container do Cloud
    func getZones() {
        Cloud.cloudContainer.privateCloudDatabase.fetchAllRecordZones { zones, error in
            guard let zones = zones, error == nil else { return }
            
            print("I have these zones: \(zones)")
        }
    }
    
    // Este método pode ser usado tanto para criar quanto para atualizar registros
    func saveUser(id: String, name: String, email: String, birthDate: Date) {
        // Referencia o Record do Cloud
        let record = CKRecord(recordType: "User")
        
        // Popula o Record
        record.setValue(id, forKeyPath: "id")
        record.setValue(name, forKeyPath: "name")
        record.setValue(email, forKeyPath: "email")
        record.setValue(birthDate, forKeyPath: "birthDate")
        
        // Salva o record no Cloud
        Cloud.cloudContainer.publicCloudDatabase.save(record) { (record, error) in
            
            if error != nil {
                print("Error: ", error!)
            } else {
                print("Successfully saved user record!")
            }
            
        }
    }
    
    func queryUsers(competion: @escaping () -> Void){
        // Retorna todos os Records
        let predicate = NSPredicate(value: true)
        // Retorna os Records de acordo com o seguinte filtro
        //let predicate = NSPredicate(format: "self contains %@", title)
        
        let query = CKQuery(recordType: "User", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var userRecords: [CKRecord] = []

        operation.recordFetchedBlock = { record in
            // record é um registro do tipo Movie que foi obtido na operação
            userRecords.append(record)
        }
        
        // Capta somente o momento de termino da requisição
        //operation.completionBlock = competion

        // Capta e executa determinada ação
        operation.queryCompletionBlock = { cursor, error in
            // movieRecords agora contém todos os registros que foram obtidos nesta operação
            print(userRecords)
        }
        
        Cloud.cloudContainer.publicCloudDatabase.add(operation)
    }
    
    func updateUsers(searchUser: UUID, name: String, email: String, birthDate: Date){
        // Retorna todos os Records
        let predicate = NSPredicate(value: true)
        // Retorna os Records de acordo com o seguinte filtro
        //let predicate = NSPredicate(format: "self contains %@", title)
        
        let query = CKQuery(recordType: "User", predicate: predicate)
        let operation = CKQueryOperation(query: query)

        operation.recordFetchedBlock = { record in
            
            if searchUser.uuidString == record["id"] {
                record.setValue(name, forKey: "name")
                record.setValue(email, forKey: "email")
                record.setValue(birthDate, forKey: "birthDate")
                
                Cloud.cloudContainer.publicCloudDatabase.save(record, completionHandler: { (record, error) in
                    if error != nil{
                        print(error!)
                    } else {
                        print("Success!")
                    }
                })
                
            }
        }
        
        Cloud.cloudContainer.publicCloudDatabase.add(operation)
    }
}
