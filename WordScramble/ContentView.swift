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
        List {
            ForEach(people, id:\.self){
                
                Text($0)
                
            }
            
            
        }.listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
