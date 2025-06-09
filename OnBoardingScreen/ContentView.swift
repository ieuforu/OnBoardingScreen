//
//  ContentView.swift
//  OnBoardingScreen
//
//  Created by Isla Cole on 2025/4/16.
//

import SwiftUI

enum OnBoardingPage: Int, CaseIterable {
    case browserMenu
    case quickDelivery
    case orderTracking
    
    var title: String {
        switch self {
        case .browserMenu:
            return "Browse Menus"
            
        case .quickDelivery:
            return "Lighting Fast Delivery"
            
        case .orderTracking:
            return "Real-Time Tracking"
        }
    }
    
    var description: String {
        switch self {
        case .browserMenu:
            return "Discover a world of flaovors from top-rated restaurants, at your fingertips."
            
        case .quickDelivery:
            return "From Kitchen to your doorstep in minutes, always refresh and delicious!"
            
        case .orderTracking:
            return "Watch your order's journey in real-time, from preparation to delivery."
        }
    }
    
}

struct ContentView: View {
    @State private var currentPage = 0
    @State private var isAnimation = false
    @State private var deliveryOffset = false
    @State private var trackingProgress: CGFloat = 0.0
    
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(OnBoardingPage.allCases, id: \.rawValue){ page in
                    getPageView(for: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.spring(), value: currentPage)
             
            HStack (spacing:12) {
                ForEach(0..<OnBoardingPage.allCases.count, id: \.self) {index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.5))
                        .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12 : 8)
                        .animation(.spring, value: currentPage)
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            Button {
                withAnimation(.spring()) {
                    if currentPage < OnBoardingPage.allCases.count - 1 {
                        currentPage += 1
                        isAnimation = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            isAnimation = true
                        })
                    } else {
                        
                    }
                }
            } label: {
                Text(currentPage < OnBoardingPage.allCases.count - 1 ? "Next" : "Get Started")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background {
                        LinearGradient(colors: [Color.blue, Color.blue.opacity(0.8)], startPoint: .leading, endPoint: .trailing)
                    }.clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.blue.opacity(0.3), radius: 10,x: 0, y: 5)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                withAnimation {
                    isAnimation = true
                }
            })
        }
    }
    
    private var foodImagesGrup: some View {
        ZStack {
            Image("burger")
                .resizable()
                .scaledToFit()
                .frame(height: 240)
                .offset(y: isAnimation ? 0 : 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimation)
                .zIndex(1)
            
            Image("fries")
                .resizable()
                .scaledToFit()
                .frame(height: 210)
                .offset(x: -120,y: isAnimation ? 0 : 40)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimation)
            
            Image("coffee")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .scaleEffect(x: -1, y: 1)
                .offset(x: 120, y: isAnimation ? 0 : 40)
                .animation(.spring(dampingFraction: 0.6).delay(0.4), value: isAnimation)
        }
    }
    
    private var deliveryAnimation: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                .frame(width: 250, height: 250)
                .scaleEffect(isAnimation ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimation)
            
            Image("delivery")
                .resizable()
                .scaledToFit()
                .frame(height:300)
                .offset(y: deliveryOffset ? -20 : 0)
                .rotationEffect(.degrees(deliveryOffset ? 5 : -5))
                .opacity(isAnimation ? 1 : 0)
                .animation(.spring(dampingFraction: 0.7).delay(0.2), value: isAnimation)
            
            ForEach(0..<8) { index in
                
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .offset(
                        x:120 * cos(Double(index) * .pi / 4),
                        y:120 * sin(Double(index) * .pi / 4)
                    )
                    .scaleEffect(isAnimation ? 1 : 0)
                    .opacity(isAnimation ? 0.7 : 0)
                    .animation (
                        .easeInOut(duration: 1.5)
                        .repeatForever()
                        .delay(Double(index) * 0.1),
                        value: isAnimation
                    )
            }
        }
    }
    
    private var orderTrackingAnimation: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                .frame(width: 250, height: 250)
                .scaleEffect(isAnimation ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimation)
            
            Image("order")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .opacity(isAnimation ? 1 : 0)
                .scaleEffect(isAnimation ? 1 : 0.8)
                .rotation3DEffect(.degrees(isAnimation ? 360 : 1), axis: (x: 0, y: 1, z: 0))
                .animation(.spring(dampingFraction: 0.7).delay(0.2), value: isAnimation)
            
            
            ForEach(0..<4) {index in
                Image(systemName: "location.fill")
                    .foregroundStyle(.blue)
                    .offset(
                        x:100 * cos(Double(index) * .pi / 2),
                        y:100 * sin(Double(index) * .pi / 2))
                    .opacity(isAnimation ? 1 : 0)
                    .scaleEffect(isAnimation ? 1 : 0)
                    .animation(.spring(dampingFraction: 0.6).delay(Double(index) * 0.1), value: isAnimation)
                
            }
        }
    }
    
    @ViewBuilder
    private func getPageView(for page: OnBoardingPage) -> some View {
        VStack(spacing: 30){
            
            // images
            ZStack {
                switch page {
                    
                case .browserMenu:
                    foodImagesGrup
                    
                case .quickDelivery:
                    deliveryAnimation
                    
                case .orderTracking:
                    orderTrackingAnimation
                }
            }
            
            // labels
            VStack(spacing: 20){
                Text(page.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimation ? 1 : 0)
                    .offset(y: isAnimation ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimation)
                
                
                Text(page.description)
                    .font(.title2)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .opacity(isAnimation ? 1 : 0)
                    .offset(y: isAnimation ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimation)
            }
        }
        .padding(.top, 50)
    }
}

#Preview {
    ContentView()
}
