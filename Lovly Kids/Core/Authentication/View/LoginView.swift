import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color("D3A58C").opacity(0.25),
                        Color(.systemBackground)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack() {
                    
                    Spacer(minLength: 10)
                    
                    Image("LOVELYKIDS")
                        .resizable()
                        .cornerRadius(15)
                        .scaledToFit()
                        .shadow(color: Color("D3A58C"), radius: 30)
                        .frame(maxWidth: 300, maxHeight: 200)
                        .padding()
                    
                    Text("Log in")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 8)
                    
                    VStack(spacing: 14) {
                        BasicTextField(placeholder: "Email", text: $viewModel.email, keyboard: .emailAddress)
                        
                        BasicTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    Button {
                        Task { await viewModel.login() }
                    } label: {
                        ZStack {
                            if viewModel.isProcessing {
                                ProgressView()
                            } else {
                                Text("Login")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                        }
                        .frame(width: 330, height: 48)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .glassEffect(.regular)
                    }
                    .padding(.top, 10)
                    .alert(isPresented: $viewModel.isActiveErrorAlert) {
                        Alert(title: Text("Error"), message: viewModel.messageAlert)
                    }
                    
                    Spacer()
                    
                    Divider()
                        .padding(.horizontal, 40)
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.blue)
                        }
                        .font(.footnote)
                    }
                    
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    LoginView()
}
