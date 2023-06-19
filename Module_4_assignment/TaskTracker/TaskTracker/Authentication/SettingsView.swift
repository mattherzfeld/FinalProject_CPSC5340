//
//  SettingsView.swift
//  TaskTracker
//
//  Created by user239896 on 6/18/23.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "matthew.herzfeld@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "testing123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List {
            Button("Log Out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            Section {
                Button("Reset Password") {
                    Task {
                        do {
                            try await viewModel.resetPassword()
                            print("Your Password is reset!")
                        } catch {
                            print(error)
                        }
                    }
                }
                Button("Update Password") {
                    Task {
                        do {
                            try await viewModel.updatePassword()
                            print("Your Password is updated!")
                        } catch {
                            print(error)
                        }
                    }
                }
                Button("Update Email") {
                    Task {
                        do {
                            try await viewModel.updateEmail()
                            print("Your Email is updated!")
                        } catch {
                            print(error)
                        }
                    }
                }
            } header: {
                    Text("Email Functions:")
                }
            Section {
                NavigationLink("Go to Golf Notes Tracker", destination: ContentView())
                NavigationLink("How is today's weather?", destination: WeatherView())
            } header: {
                Text("Main Applications")
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(showSignInView: .constant(false))
        }
    }
}
