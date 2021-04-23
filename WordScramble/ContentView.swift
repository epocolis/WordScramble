//
//  ContentView.swift
//  WordScramble
//
//  Created by Leotis buchanan on 2021-04-23.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke","Ray"]
    var body: some View {
        
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt"){
            //we found the file in the bundle
            if let fileContents = try?
                String(contentsOf :fileURL){
                
            }
        }
        
       return Text("Hello World")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
