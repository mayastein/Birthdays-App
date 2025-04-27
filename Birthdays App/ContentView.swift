//
//  ContentView.swift
//  Birthdays App
//
//  Created by Maya Stein on 4/25/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newFriendName = ""
    @State private var newFriendBirthday=Date.now
    var body: some View {
        NavigationStack{
            List(friends){ friend in
                HStack{
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge:.bottom) {
                VStack(alignment:.center, spacing:20){
                    Text("New Birthday").font(.headline)
                    DatePicker(selection: $newFriendBirthday, in: Date.distantPast...Date.now, displayedComponents: .date) {
                               TextField("Name", text: $newFriendName)
                                   .textFieldStyle(.roundedBorder)
                           }
                    Button("Save"){
                        let newFriend=Friend(theName: newFriendName, theBirthday: newFriendBirthday)
                        context.insert(newFriend)
                        newFriendName=""
                        newFriendBirthday = .now
                    }
                    .bold()
                    
                }
                .padding()
                .background(.bar)
               
            }
        }
    }
}

#Preview {
    ContentView().modelContainer(for: Friend.self, inMemory: true)
}
