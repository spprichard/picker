import Foundation
import ArgumentParser
import Yams

struct Config: Codable {
    var options: [String]
}

struct Picker: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Randomly do things",
        subcommands: [List.self]
    )
    
    func run() throws {
        let ops = readOptions()
        
        let chosenOne = pick(at: Int.random(in: 0..<ops.count), from: ops)
        
        print("Choice: 🎉 \(chosenOne.capitalized) 🎉 Was chosen from: \(ops)")
    }
}

extension Picker {
    struct List: ParsableCommand {
        func run() {
            var ops = readOptions()
            var randomList : [String] = []
            
            for _ in ops {
                let chosenOne = pick(at: Int.random(in: 0..<ops.count), from: ops)
                ops = ops.filter{$0 != chosenOne}
                randomList.append(chosenOne)
            }

            print("Random List: \n \(randomList)")
        }
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

func pick(at index: Int, from options: [String]) -> String {
    return options[index]
}

Picker.main()
