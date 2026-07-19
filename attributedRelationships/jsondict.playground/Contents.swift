import UIKit



let formatter = ISO8601DateFormatter()

let tunes : [AbcTune] = [
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

let fileURL = Bundle.main.url(forResource: "tunesData", withExtension: "json")
let content = try! String(contentsOf: fileURL!, encoding: .utf8)

let contentData = content.data(using: .utf8)

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601


let decodedTunes : [AbcTune] = try! decoder.decode([AbcTune].self, from: contentData!)

let reEncodedTunes = try! encoder.encode(decodedTunes)
let reEncodedString = String(data: reEncodedTunes, encoding: .utf8)

let file2URL = Bundle.main.url(forResource: "tuneSets", withExtension: "json")

let content2 = try! String(contentsOf: file2URL!, encoding: .utf8)
let content2Data = content2.data(using: .utf8)
let decodedSets : [AbcTuneSet] = try! decoder.decode([AbcTuneSet].self, from: content2Data!)

let file3URL = Bundle.main.url(forResource: "collections", withExtension: "json")

let content3 = try! String(contentsOf: file3URL! , encoding: .utf8)
let content3data = content3.data(using: .utf8)
let decodedCollections : [AbcCollection] = try! decoder.decode([AbcCollection].self, from: content3data!)
