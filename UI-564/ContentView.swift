//
//  ContentView.swift
//  UI-564
//
//  Created by nyannyan0328 on 2022/05/17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View{
        
        NavigationView{
            
            Home()
                .navigationTitle("Task Manger")
                .navigationBarTitleDisplayMode(.inline)
               
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
