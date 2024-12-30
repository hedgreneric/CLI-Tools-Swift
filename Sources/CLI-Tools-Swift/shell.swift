import Foundation

func runShell() {
    print("Welcome to SwiftShell! Type 'exit' to quit.")
    
    while true {
        print("> ", terminator: "")
        
        guard let input = readLine(), !input.isEmpty else {
            continue
        }
        
        if input.lowercased() == "exit" {
            print("Goodbye!")
            break
        }
        
        let components = input.split(separator: " ").map(String.init)
        guard let command = components.first else { continue }
        let arguments = Array(components.dropFirst())
        
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = [command] + arguments
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = errorPipe
        
        do {
            try process.run()
            process.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: outputData, encoding: .utf8) {
                print(output)
            }
            
            let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
            if let error = String(data: errorData, encoding: .utf8), !error.isEmpty {
                print("Error: \(error)")
            }
        } catch {
            print("Failed to run command: \(error)")
        }
    }
}
