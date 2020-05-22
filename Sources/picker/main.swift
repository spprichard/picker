import Foundation
import ArgumentParser
import Yams

struct Config: Codable {
    var options: [String]
}

struct Picker: ParsableCommand {
    func run() throws {
        var results: [String] = []
        let ops = readOptions()
        
        results.append(pick(at: Int.random(in: 0..<ops.count), from: ops))
        
        print("Choice: \(results) Was chosen from: \(ops)")
    }
    
    func pick(at index: Int, from options: [String]) -> String {
        return options[index]
    }
    
}

func readOptions() -> [String] {
    let d = YAMLDecoder()
    guard let data = FileManager.default.contents(atPath: "/Users/stevenprichard/.picker.yaml") else { fatalError() }
    let s = String(bytes: data, encoding: .utf8)!
    do {
        let c = try d.decode(Config.self, from: s)
        return c.options
    } catch {
        fatalError()
    }
    
    
    
}

Picker.main()
