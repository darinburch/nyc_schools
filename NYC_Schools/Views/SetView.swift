
import SwiftUI

struct SatScoreView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var vm : SchoolListViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            if let sat = vm.currentSat {
                VStack {
                    Text(sat.school_name ?? NA)
                        .font(.system(size: 18,weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 20)
                }.padding(.bottom, 20)
                ScoreDetail(header: "Number of test takers.", detail: sat.num_of_sat_test_takers ?? NA)
                ScoreDetail(header: "Avg reading score", detail: sat.sat_critical_reading_avg_score ?? NA)
                ScoreDetail(header: "Avg math score", detail: sat.sat_math_avg_score ?? NA)
                ScoreDetail(header: "Avg writing score", detail: sat.sat_writing_avg_score ?? NA)
                Spacer()
            }
        }.padding()
            .navigationBarTitle("SAT Scores", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: { dismiss() })
                }
            })
    }
    
    func dismiss() {
        vm.currentSat = nil
        self.presentation.wrappedValue.dismiss()
    }
}

struct ScoreDetail: View {
    
    let header: String
    let detail: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(header)
                .multilineTextAlignment(.center)
                .font(.system(size: 18,weight: .bold))
            Text(detail)
                .font(.system(size: 20,weight: .semibold))
        }
    }
}


struct BackButton: View {
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            ZStack {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                Color.blue.opacity(0.000000001)
                    .frame(width: 40, height: 10)
            }
        })
    }
}
