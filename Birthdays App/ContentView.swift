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
    @State private var selectedFriend:Friend?
    var body: some View {
        NavigationStack{
            List{
                ForEach(friends){ friend in
                    HStack{
                        HStack{
                            Text(friend.name)
                            Spacer()
                            Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                        }.onTapGesture {
                            selectedFriend=friend
                        }
                    }
                }
                .onDelete(perform: deleteFriend)
            }
            .navigationTitle("Birthdays")
            .sheet(item:$selectedFriend){ friend in
                NavigationStack{
                    EditFriendView(friend: friend)
                }
            }
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
    func deleteFriend(at offsets:IndexSet){
        for index in offsets{
            let friendToDelete=friends[index]
            context.delete(friendToDelete)
        }
    }
}
#Preview {
    ContentView().modelContainer(for: Friend.self, inMemory: true)
}
