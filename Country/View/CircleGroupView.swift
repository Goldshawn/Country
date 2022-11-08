//
//  CircleGroupView.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import SwiftUI

// a simple onboarding view to show halo behind a map
struct CircleGroupView: View {
    //    MARK: Property
        @State var shapeColor: Color
        @State var shapeOpacity: Double
        @State private var isAnimating: Bool = false
        
        var body: some View {
            ZStack{
                Circle()
                    .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 40)
                    .frame(width: 260, height: 260, alignment: .center)
                Circle()
                    .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 80)
                    .frame(width: 260, height: 260, alignment: .center)
            }//: ZSTACK
            .blur(radius: isAnimating ? 0 : 10)
            .opacity(isAnimating ? 1 : 0)
            .scaleEffect(isAnimating ? 1 : 0.5)
            .animation(.easeOut(duration: 1), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
        }
    }

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .edgesIgnoringSafeArea(.all)
            
            CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
        }
    }
}

