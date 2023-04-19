//
//  ContentView.swift
//  DeveloperKeyboard
//
//  Created by Marchell Imanuel on 19/04/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var username: String = ""


    var body: some View {
        HStack(alignment: .center) {
            Text("Type here:")
                .font(.callout)
                .bold()
            TextField("Enter something...", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
