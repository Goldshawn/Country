//
//  OnboardingView.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import SwiftUI

struct OnboardingView: View {
//    MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Welcome to the Earth"
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    //    MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                //                MARK: - HEADER
                Spacer()
                
                VStack(spacing: 0){
                    Text(textTitle)
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                There was once a planet in the habitable zone of the Solar system. It was divided into smaller countries to help governing
                """)
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 10)
                } //: HEADER
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 0: -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
//                MARK: CENTER
                
                ZStack{
                    CircleGroupView(shapeColor: Color("ColorRed"), shapeOpacity: 0.4)
                        .offset(x: imageOffset.width * -1.2)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("worldImage")
                        .resizable()
                        .scaledToFit().opacity(isAnimating ? 1: 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                        }
                                    }
                                }
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "This is what earth looks like"
                                    }
                                })
                        )//: GESTURE
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }//: CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(Color("ColorRed"))
                    .offset(y: 20)
                    .opacity(isAnimating ? 1 :0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity), alignment: .bottom)
                
                Spacer()
//                MARK: FOOTER
                ZStack{
//                     PARTS OF THE CUSTOM BUTTON
                    
//                    1. BACKGROUND (STATIC)
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
//                    2. CALL TO ACTION (STATIC)
                    Text("Swipe to begin")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
//                    3. CAPSULE (DYNAMIC WIDTH)
                    
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }//: HSTACK
//                    4. CIRCLE (DRAGABLE)
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80{
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{ _ in
                                    withAnimation(.easeOut(duration: 0.4)) {
                                        if buttonOffset > (buttonWidth / 2) {
                                            hapticFeedback.notificationOccurred(.success)
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        }else{
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )//: GESTURE
                        
                        Spacer()
                    }//: HSTACK
                }//: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 0: 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }//: VSTACK
        } //: ZSTACK
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            OnboardingView()
        } else {
            // Fallback on earlier versions
        }
    }
}

