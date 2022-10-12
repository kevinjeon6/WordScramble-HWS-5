//
//  ContentView.swift
//  WordScramble
//
//  Created by Kevin Mattocks on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
Text("hello")
        
        
    }
    
    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                fileContents
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 List is the view that you rely on the most compared to VStack, etc.
 
 Lists provide a scrolling table is for presentation data while form is for user input
 
 Use Dynamic content using ForEach inside the brackets or List(0...5)
 
 Modifier .listStyle can change the appearance of the list
 
 
 ID parameter is used to tell SwiftUI on how to identify each item in the array unique
 
 \.self is used for Strings and numbers
 */


/*
 If you want to read the URL for a file in our main app bundle, we use Bundle.main.url(forResources: "some-file", withExtension: "txt")
 */
