//
//  SignupView+ViewModel.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation
import Combine
import SwiftUI

extension SignupView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published var formStatus: FormStatus = .idle
        @Published var user: User?

        private var formCompletedSubscription: AnyCancellable?
        
        init() {
            formCompletedSubscription = $formStatus
                .compactMap { formStatus -> CreateUserDTO? in
                    guard case .validSubmission(let createUserDTO) = formStatus else {
                        return nil
                    }
                    return createUserDTO
                }
                .sink { [weak self] createUserDTO in
                    Task { [weak self] in await self?.submit(createUserDTO: createUserDTO) }
                }
        }

        private func submit(createUserDTO: CreateUserDTO) async {
            self.user = User(
                id: createUserDTO.userID,
                name: createUserDTO.name,
                email: createUserDTO.email,
                createdAt: createUserDTO.createdAt,
                avatarURL: defaultAvatarURL,
                relationshipToCudi: createUserDTO.cudiRelationship,
                favoritePartAboutCudi: createUserDTO.favoritePartAboutCudi
            )

            await userSubmittedValidForm()
        }

        private func userSubmittedValidForm() async {
        }
    }
}

extension Publisher where Failure == Never {
    func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable {
       sink { [weak root] in
            root?[keyPath: keyPath] = $0
        }
    }
}
