//
//  SplashView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import SwiftUI

@MainActor
struct SplashScreen: View {
    @State private var isAnimating = false

    var body: some View {
        NavigationStack {
            ZStack {
                LandingBackgroundView()
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 100) {
                    Image(systemName: "dog")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(isAnimating ? 1.1 : 1)
                        .animation(
                            .smooth(duration: 0.5).repeatCount(2, autoreverses: true),
                            value: isAnimating
                        )
                        .padding([.top, .horizontal], 32)
                    Spacer()
                    welcomeText
                    buttonStack
                        .padding(.bottom, 32)

                }
                .padding(24)
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(2.5))
            withAnimation {
                isAnimating = true
            }
        }
    }

    private var welcomeText: some View {
        VStack(spacing: 8) {
            Text("Welcome")
                .font(.title)
            Text("Woof-hoo! Another Cudi fan on the loose! ")
                .font(.body)
        }
        .foregroundColor(AppColor.textPrimary)
    }

    private var buttonStack: some View {
        VStack(spacing: 8) {
            NavigationLink {
                SignupView()
                
            } label: {
                Text("Sign up")
                    .foregroundColor(AppColor.textPrimary)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }

            Text("Login")
                .foregroundColor(AppColor.textSecondary)
                .padding()
                .onTapGesture {
                    // Navigate to next screen or trigger animation completion
                }
        }
        .font(.headline)
        .fontWeight(.bold)
    }
}

#Preview {
    NavigationStack {
        SplashScreen()
    }
}
