//
//  SignupView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import SwiftUI

@MainActor
struct SignupView: View {
    var form = SignupForm()
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel = ViewModel()
    @Environment(\.modelContext) var modelContext

    var body: some View {
        ZStack {
            LandingBackgroundView()
                .edgesIgnoringSafeArea(.all)

            signupForm
                .padding()
        }
        .navigationTitle("Sign Up")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .tint(.primary)
                }
            }
        }
        .navigationDestination(item: $viewModel.user) { user in
            MainTabView()
        }
        .onReceive(viewModel.$user) { user in
            guard let user else { return }
            modelContext.insert(user)
        }
    }

    private var signupForm: some View {
        VStack(spacing: 16) {
            Text("Tell us about yourself:")
                .font(.title3)
                .bold()
            
            SignupFormView(
                form: form,
                formStatus: $viewModel.formStatus
            )
        }
        .foregroundStyle(AppColor.textSecondary)
    }

}

#Preview {
    NavigationStack {
        SignupView()
    }
}
