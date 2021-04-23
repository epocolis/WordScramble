//
//  ContentView.swift
//  WordScramble
//
//  Created by Leotis buchanan on 2021-04-23.
//
/*
 iOS gives us some really powerful APIs for working with strings, including the ability to split
 them into an array, remove whitespace, and even check spellings.

 In this app, we’re going to be loading a file from our app bundle that contains over 10,000
 eight-letter words, each of which can be used to start the game. These words are stored one per
 line, so what we really want is to split that string up into an array of strings in order that
 we can pick one randomly.

 Swift gives us a method called components(separatedBy:) that can converts a single string into
 an array of strings by breaking it up wherever another string is found. For example, this will
 create the array ["a", "b", "c"]:
 */

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        let input = "a b c"
        let letters = input.components(separatedBy: " ")
        
        
       return Text("Hello world")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
