//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Afnan Ahmad on 29/04/2024.
//

import Foundation


extension Bundle {
    //func decode(_ file: String) -> [String: Astronauts] {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        //guard let loaded = try? decoder.decode([String: Astronauts].self, from: data) else {
            //fatalError("failed to decode \(file) from bundle.")
        //}
        //return loaded
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("failed to decode \(file) from bundle due to missing key '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("failed to decode \(file) from bundle because it appears to be a invalid JSON")
        } catch {
            fatalError("failed to decode \(file) from bundle due to error: \(error.localizedDescription)")
        }
    }//end method
    
}//end extension
