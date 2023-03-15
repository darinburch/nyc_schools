
import SwiftUI

struct SchoolCell: View {
    @ObservedObject var vm : SchoolListViewModel
    @ObservedObject var savedVm : SavedSchoolsViewModel
    
    @State var school: SchoolDTO
    
    var body: some View {
        HStack {
            VStack(spacing: 7.5) {
                SchoolName(name: school.school_name ?? "")
                SchoolLocation(location: school.location ?? "")
                SchoolOverview(overview: school.overview_paragraph ?? "")
                SchoolNumber(vm: vm, savedVm: savedVm, school: school, action: { getSatScore() }, saveSchool: { saveSchool() }, deleteSchool: { deleteSchool()
                }
)
            }.padding()
            ChevronArrow()
        }
        .listRowInsets(EdgeInsets()) // expand to edge of device
        .background ( /// programatic navigation link
            NavigationLink("", destination: SatScoreView(vm: vm), isActive: $vm.presentSatView).hidden()
        )
    }
    
    func getSatScore() {
        vm.selectedSchoolDbn = ""
        vm.selectedSchoolDbn = school.dbn
        vm.getSatScore(dbn: school.dbn)
    }
    
    func saveSchool() {
        vm.saveSchool(school)
    }
    
    func deleteSchool() {
        savedVm.deleteSchoolByDbn(school.dbn)
    }
    
}


struct SchoolName: View {
    let name: String
    
    var body: some View {
        HStack {
            Text(name)
                .lineLimit(3)
                .font(.system(size: 18, weight: .bold))
                .padding(.trailing, TRAILING_PADDING)
            Spacer()
        }
    }
}

struct SchoolLocation: View {
    let location: String
    
    var components: [String] {     /// exclude coordinates for UI
        return location.components(separatedBy: "(")
    }
    
    var body: some View {
        HStack {
            Text(components[0])
                .multilineTextAlignment(.center)
                .font(.system(size: 15, weight: .semibold))
            Spacer()
        }
    }
}


struct SchoolOverview: View {
    let overview: String
    
    var body: some View {
        Text(overview)
            .lineLimit(nil)
            .font(.system(size: 12, weight: .regular))
            .padding(.trailing, TRAILING_PADDING)
    }
}


struct SchoolNumber: View {
    @ObservedObject var vm : SchoolListViewModel
    @ObservedObject var savedVm : SavedSchoolsViewModel
    
    let school: SchoolDTO
    let action: () -> Void
    let saveSchool: () -> Void
    let deleteSchool: () -> Void
    
    @State private var isSaved: Bool = false
    
    var body: some View {
        HStack(spacing: 30) {
            Text(school.phone_number ?? NA)
                .lineLimit(1)
                .font(.system(size: 14, weight: .bold))
            Text("View SAT scores")
                .opacity(satOpacity())
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.blue)
                .overlay(
                    ProgressView().tint(.blue)
                        .opacity(loadingOpacity())
                )
                .onTapGesture {
                    action()
                }
            Image(systemName: star().image)
                .foregroundColor(star().color)
                .font(.system(size: 18, weight: .regular))
                .padding(.bottom, 3)
                .onTapGesture {
                    determineSaveOrDeleteSchool()
                }
        }.padding(.leading, -15)
        .onAppear { isSchoolSaved() }
    }
    
    func isSchoolSaved() {
        savedVm.savedSchools.forEach { sch in
            if school.dbn == sch.dbn {
                self.isSaved = true
            } else {
                self.isSaved = false
            }
        }
    }
    
    func determineSaveOrDeleteSchool() {
        if isSaved {
           deleteSchool()
        } else {
            saveSchool()
            self.isSaved = true
        }
    }
    
    /// below 2 functions make sure progress view shows for correct cell only and not all
    func satOpacity() -> Double {
        if vm.satLoading && vm.selectedSchoolDbn == school.dbn {
            return 0.0
        }
        return 1.0
    }
    
    func loadingOpacity() -> Double {
        if vm.satLoading && vm.selectedSchoolDbn == school.dbn {
            return 1.0
        }
        return 0.0
    }
    
    func star() -> (image: String, color: Color) {
        if isSaved {
            return ("star.fill", .yellow)
        }
        return ("star", .black)
    }
    
}

struct ChevronArrow: View {
    
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 20, weight: .regular))
            .foregroundColor(.gray)
            .padding(.trailing, 17.5)
    }
}


//

//struct SchoolCell: View {
//
//    @ObservedObject var vm : SchoolViewModel
//
//    var body: some View {
//        HStack {
//            Text("TEXT")
//        }
//        .listRowInsets(EdgeInsets()) // expand to edge of device
//        .background ( /// programatic navigation link
//            NavigationLink("", destination: SatScoreView(vm: vm), isActive: $vm.presentSatView).hidden()
//        )
//    }
//}
