//
//  ContentView.swift
//  Birthdays App
//
//  Created by Maya Stein on 4/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var friends: [Friend] = [
        Friend(theName: "Ria Koppikar", theBirthday: Date(timeIntervalSinceReferenceDate:105236400)),
        Friend(theName:"Kirsten Mahler", theBirthday: Date(timeIntervalSinceReferenceDate:111279600))
    ]
    @State private var newFriendName = ""
    @State private var newFriendBirthday=Date.now
    var body: some View {
        NavigationStack{
            List(friends, id:\.name){ friend in
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
                        friends.append(newFriend)
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
    ContentView()
}
