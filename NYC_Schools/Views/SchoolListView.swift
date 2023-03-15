import SwiftUI

struct SchoolListView: View {
    @StateObject var savedVm = SavedSchoolsViewModel()
    @StateObject var vm = SchoolListViewModel()
    
    var moreSchoolsToLoad: Bool {
        /// if vm.schools.count cannot evenly be divided by 10, no more to load...
        let double = Double(vm.schools.count) / Double(SCHOOL_LIMIT)
        return floor(double) == double
    }
    
    /// get id of last index so when that cell appears we make an API call to load 10 more schools
    var schoolDbnLastIndex: String {
        if let lastSchool = vm.schools.last {
            return lastSchool.dbn
        }
        return ""
    }
    
    var body: some View {
        if vm.isLoading {
            VStack {
                Spacer()
                Text("Loading NYC schools...")
                    .bold()
                ProgressView().tint(.black)
                Spacer()
            }
        } else {
            List(vm.schools, id: \.dbn) { school in
                SchoolCell(vm: vm, savedVm: savedVm, school: school)
                    .onAppear { /// when last element appears we load more
                        if school.dbn == schoolDbnLastIndex && moreSchoolsToLoad {
                            Task.detached {
                                await vm.loadMoreSchools()
                            }
                        }
                    }
            }
            .clipped()
            .listStyle(PlainListStyle())
            .alert(isPresented: $vm.showAlert) {
                Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))
            }
            .background( // add dismiss button
                EmptyView().fullScreenCover(isPresented: $vm.presentFavoritedSchools, content: { SavedSchools(savedVm: savedVm) } ) // PP
            )
            .listStyle(PlainListStyle()) /// get rid of extra padding TOP AND BOTTOM
            .refreshable { /// pull down to refresh functionality
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    Task.detached {
                        await vm.loadSchools()
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {  presentFavoritedSchools() }, label: {
                        Text("Saved")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(foregroundColor())
                    }).padding(.trailing, 10)
                }
            })
            .navigationBarTitle(Text("NYC Schools"))
        }
    }
    
    func foregroundColor() -> Color {
        return .blue
    }
    
    func presentFavoritedSchools() {
        DispatchQueue.main.async {
            vm.presentFavoritedSchools = true
        }
    }
    
}


