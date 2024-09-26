//
//  SettingsViewModel.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 25.09.2024.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    // MARK: Section – Flight Data Export
    func exportFlightLogsToJSON(flightLogs: [FlightLog], completion: @escaping (URL?) -> Void) {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted] // Optional: for better readability
        
        do {
            // Step 1: Encode the flight logs into JSON data
            let encodedFlightLogs = try encoder.encode(flightLogs)
            
            // Step 2: Create a temporary file URL in the temporary directory
            let tempDirectory = FileManager.default.temporaryDirectory
            let tempURL = tempDirectory.appendingPathComponent("SkySoar Flights.json")
            
            // Step 3: Write the JSON data to the file
            try encodedFlightLogs.write(to: tempURL)
            
            // Step 4: Call the completion handler with the file URL
            completion(tempURL)
            
        } catch {
            print("Error encoding flight logs or saving to file: \(error.localizedDescription)")
            completion(nil) // In case of failure, return nil
        }
    }
    
    // MARK: Section – Flight Data Import
    func decodeFlightLogsFromJSON(fileURL: URL, completion: @escaping ([FlightLog]) -> Void) throws {
        // Start accessing the security-scoped resource
        guard fileURL.startAccessingSecurityScopedResource() else {
            print("Failed to start accessing security-scoped resource")
            return
        }
        
        defer {
            // Stop accessing the resource when done
            fileURL.stopAccessingSecurityScopedResource()
        }
        
        do {
            let decodedFlights = try JSONDecoder().decode([FlightLog].self, from: Data(contentsOf: fileURL))
            completion(decodedFlights)
        } catch {
            print("Error decoding flight logs: \(error)")
            throw error
        }
    }
    
    
    // Different Email URL for Localizations EN and DE
    func localizedEmailURLString() -> String {
        return (Locale.current.language.languageCode?.identifier ?? "") == "de" ?
        "mailto:jonas@vetschmedia.com?subject=Rückmeldung SkySoar App&body=Liebes Entwicklerteam" :
        "mailto:jonas@vetschmedia.com?subject=Feedback%20SkySoar%20App&body=Dear%20Developers"
    }
    
}
