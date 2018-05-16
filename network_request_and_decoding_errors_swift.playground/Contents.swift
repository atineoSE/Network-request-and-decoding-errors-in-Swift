import Foundation
import PlaygroundSupport

// Model
struct API: Decodable {
    let films: URL
    let people: URL
    let planets: URL
    let species: URL
    let starships: URL
    let vehicles: URL
}
struct Films: Decodable {
    let count: Int
    let results: [Film]
}
struct Film: Decodable {
    let title: String
    let episodeId: Int
    let url: URL
    let releaseDate: Date
}

// Data
extension Data {
    static var corruptedData: Data {
        return "corruptedData".data(using: .utf8)!
    }
}

// Constants
let rootURL = URL(string: "https://swapi.co/api/")!
let nonExistingUrl = URL(string: "https://nonexisting.co/api/")!
let nonExistingResourceUrl = URL(string: "https://swapi.co/api/chewbacca/")!
let urlWithNonExistingQuery = URL(string: "https://swapi.co/api/films?u=5")!

// Barrier
var proceed = true
var count = 0
func start() {
    proceed = false
}
func wait() {
    while(!proceed) {
        count = count + 1
    }
}
func done() {
    proceed = true
}

// Task
class TaskFactory {
    func task<Model>(url: URL, modelType: Model.Type, mockData: Data?) -> URLSessionDataTask
        where Model: Decodable {
            
            func dumpInfo(data: Data?, response: URLResponse?, error: Error?) {
                if let data = data {
                    print("Data: \(String(describing: String(data: data, encoding: .utf8)))")
                } else {
                    print("Data: none")
                }
                if let response = response {
                    print("Response: \(response)")
                } else {
                    print("Response: none")
                }
                if let error = error {
                    print("Network error: \(error)")
                } else {
                    print("Network error: none")
                }
            }
            
            let session = URLSession(configuration: .default)
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                guard error == nil else {
                    dumpInfo(data: data, response: response, error: error)
                    done()
                    return
                }
                guard let _ = data else {
                    dumpInfo(data: data, response: response, error: error)
                    done()
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                dumpInfo(data: data, response: response, error: error)
                do {
                    let decodableData = mockData != nil ? mockData : data
                    let model = try decoder.decode(modelType, from: decodableData!)
                    print("Decoded model: \(model)")
                } catch let error {
                    print("Decoding error: \(error)")
                }
                done()
            }
            return task
    }
}

// Exercises
start()
let taskFactory =  TaskFactory()
print("Exercise 1: successful request")
let task1 = taskFactory.task(url: rootURL, modelType:API.self, mockData: nil)
task1.resume()
wait()

start()
print("Exercise 2: non-existing host")
let task2 = taskFactory.task(url: nonExistingUrl, modelType:API.self, mockData: nil)
task2.resume()
wait()

start()
print("Exercise 3: non-existing resource")
let task3 = taskFactory.task(url: nonExistingResourceUrl, modelType:API.self, mockData: nil)
task3.resume()
wait()

start()
print("Exercise 4: non-existing query")
let task4 = taskFactory.task(url: urlWithNonExistingQuery, modelType:Films.self, mockData: nil)
task4.resume()
wait()

start()
print("Exercise 5: corrupted data (non-conforming JSON)")
let task5 = taskFactory.task(url: rootURL, modelType:API.self, mockData: Data.corruptedData)
task5.resume()
wait()

start()
print("Exercise 6: model mismatch / wrong decoding key")
let task6 = taskFactory.task(url: rootURL, modelType:Films.self, mockData: nil)
task6.resume()
wait()
