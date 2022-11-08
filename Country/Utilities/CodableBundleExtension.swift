//
//  CodableBundleExtension.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation

extension Bundle{
    // this was needed as i wanted to display pictures of some characters on the character page
    // TODO: align the response from the api, such that as soon as the name is selected the image is shown (Down side, the app would be too large as the images are not loaded but exist in the bundle)
    /// extension to read json data from the app bundle.
    func decodeInfo<T: Codable>(_ file: String) -> T{
        //1. Locate the JSON File
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in bundle")
        }
        //2. Create a property for the data
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        //3. Create a decoder
        let decoder = JSONDecoder()
        
        //4. Create a property for the decoded data
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        //5. Retrun the ready to use data
        return loaded
    }
}
