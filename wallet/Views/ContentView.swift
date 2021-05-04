//
//  ContentView.swift
//  wallet
//
//  Created by Payam on 5/3/21.
//

import SwiftUI

struct ContentView: View {
    init() {
        var test = BLS()
        test.GetKeys()
    }
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
