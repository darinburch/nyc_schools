
import SwiftUI

struct SavedSchools: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var savedVm: SavedSchoolsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if savedVm.savedSchools.isEmpty {
                    Placeholder(message: "No saved schools yet")
                } else {
                    List {
                        ForEach(savedVm.savedSchools, id: \.id) { school in
                            SavedSchoolCell(school: school)
                        }
                        .onDelete { indexSet in
                            self.deleteSchool(indexSet)
                        }
                    }.listStyle(PlainListStyle())
                        .navigationBarTitle(Text("Saved schools"), displayMode: .inline)
                        .navigationViewStyle(StackNavigationViewStyle())
                       
                }
            } .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    DismissButton(action: { dismiss() })
                }
            })
            .onAppear {
                savedVm.loadSchools()
            }
        }
    }
    
    func dismiss() {
        self.presentation.wrappedValue.dismiss()
    }
    
    func deleteSchool(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let schoolData = savedVm.savedSchools[index]
            savedVm.deleteSchool(schoolData)
        }
    }
}

struct Placeholder: View {
    let message: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .bold()
                .foregroundColor(.black)
            Spacer()
        }
    }
}


struct DismissButton: View {
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            ZStack {
                Text("Dismiss")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                Color.blue.opacity(0.000000001)
                    .frame(width: 40, height: 10)
            }
        })
    }
}


struct SavedSchoolCell: View {
    
    let school: SchoolViewModel
    
    var body: some View {
        VStack {
            Text(school.school_name)
                .foregroundColor(.black)
        }.padding()
    }
}
