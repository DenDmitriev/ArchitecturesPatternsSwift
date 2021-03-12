import UIKit

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")


//Дмитриев Денис
//Домашняя работа к уроку 5

struct Person: Decodable {
    let name: String
    let age: Int
    let isDeveloper: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, age, isDeveloper
    }
    
    init(name: String, age: Int, isDeveloper: Bool) {
        self.name = name
        self.age = age
        self.isDeveloper = isDeveloper
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.isDeveloper = try container.decode(Bool.self, forKey: .isDeveloper)
    }
}

struct DataResponse: Decodable {
    let persons: [Person]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.persons = try container.decode([Person].self, forKey: .data)
    }
    
}

struct ResultResponse: Decodable {
    let persons: [Person]
    
    enum CodingKeys: String, CodingKey {
        case result
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.persons = try container.decode([Person].self, forKey: .result)
    }
    
}


protocol Parsingable {
    var next: Parsingable? { get set }
    func getPersons(from data: Data) -> [Person]?
}

class ParserData: Parsingable {
    var next: Parsingable?
    
    func getPersons(from data: Data) -> [Person]? {
        guard
            let dataResponse = try? JSONDecoder().decode(DataResponse.self, from: data) as DataResponse
        else {
            return next?.getPersons(from: data)
        }
        return dataResponse.persons
    }
}

class ParserResult: Parsingable {
    var next: Parsingable?
    
    func getPersons(from data: Data) -> [Person]? {
        guard
            let resultResponse = try? JSONDecoder().decode(ResultResponse.self, from: data) as ResultResponse
        else {
            return next?.getPersons(from: data)
        }
        return resultResponse.persons
    }
}

class Parser: Parsingable {
    var next: Parsingable?
    
    func getPersons(from data: Data) -> [Person]? {
        guard
            let persons = try? JSONDecoder().decode([Person].self, from: data) as [Person]
        else {
            next?.getPersons(from: data)
            return nil
        }
        return persons
    }
}


func getPersons(from data: Data, completion: @escaping (([Person]?) -> Void)) {
    
    let parserData = ParserData()
    let parserResult = ParserResult()
    let parser = Parser()
    
    parserData.next = parserResult
    parserResult.next = parser
    parser.next = nil
    

    guard let persons = parserData.getPersons(from: data) else {
        completion(nil)
        return
    }
    
    completion(persons)
}

getPersons(from: data3) { persons in
    persons?.forEach({ person in
        print("\(person.name) is \(person.age) years old a \(person.isDeveloper) developer")
    })
}
