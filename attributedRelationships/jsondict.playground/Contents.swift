import UIKit



let formatter = ISO8601DateFormatter()

let tunes : [AbcTune] = [
    AbcTune(displayName: "??"),
    AbcTune(displayName: "first struct", notes: "with a note"),
    AbcTune(displayName: "second, no notes"),
    AbcTune(displayName: "third",notes:" early creation dated",createdDateTime: formatter.date(from: "2026-01-01T15:00:00Z")!)
]





let encoder = JSONEncoder()

encoder.outputFormatting = .prettyPrinted
encoder.dateEncodingStrategy = .iso8601


let secondData = try! encoder.encode(tunes)
let secondString = String(data: secondData, encoding: .utf8)
print(secondString!)

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
