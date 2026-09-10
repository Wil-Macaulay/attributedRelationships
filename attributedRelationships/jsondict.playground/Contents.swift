import UIKit



let formatter = ISO8601DateFormatter()

let encoder = JSONEncoder()

encoder.outputFormatting = .prettyPrinted
encoder.dateEncodingStrategy = .iso8601



let decodedTunes = AbcTune.importFromJsonFile("tunesData")

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601


let reEncodedTunes = try! encoder.encode(decodedTunes)
let reEncodedString = String(data: reEncodedTunes, encoding: .utf8)

print("reencoded tunes")
print(reEncodedString!)


let decodedSets : [AbcTuneSet] = AbcTuneSet.importFromJsonFile("tuneSets")

let reencodedSets = try! encoder.encode(decodedSets)
let setString = String(data: reencodedSets, encoding: .utf8)
print("sets reencoded")
print(setString!)

let decodedCollections : [AbcCollection] = AbcCollection.importFromJsonFile("collections")

let reEncodedCollections = try! encoder.encode(decodedCollections)

let stringed = String(data:reEncodedCollections, encoding: .utf8)

print("collections reencoded")

print(stringed!)

let file3URL = Bundle.main.url(forResource: "collections", withExtension: "json")

let content3 = try! String(contentsOf: file3URL! , encoding: .utf8)
let content3data = content3.data(using: .utf8)
let decodedCollection2 : [AbcCollection] = try! decoder.decode([AbcCollection].self, from: content3data!)
