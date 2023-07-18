//
//  AuthView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 14.07.23.
//

import SwiftUI

struct AuthView: View {
    @StateObject var userManager: UsersManager
    @State var isActive = false

    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack {
            Color("color.background")
                .ignoresSafeArea()
            floatingCircle
            VStack {
                
                heading
                    .padding(.bottom, 100)
                options
            }
        }
        .fontDesign(.rounded)
    }
    
    @ViewBuilder var floatingCircle: some View {
        VStack {
            Circle()
                .foregroundColor(Color("color.theme"))
                .offset(x: -200, y: -200)
            Spacer()
            Circle()
                .foregroundColor(Color("color.theme"))
                .offset(x: 200, y:200)
        }
    }
    
    @ViewBuilder var heading: some View {
        VStack {
            Text("Noteify")
                .font(.system(size: 80, weight: .heavy))
                .foregroundColor(Color("color.theme"))
            Text("Organize your life!")
                .foregroundColor(Color("color.theme"))
                .font(.body)
        }
        .bold()
    }
    
    @ViewBuilder var options: some View {
        VStack {
            Group {
                
                Button("LOGIN") {
                    navigationPath.append("login")
                    debugPrint(navigationPath)
                }
                
                Button("REGISTER") {
                    navigationPath.append("register")
                }

            }
            .bold()
            .foregroundColor(.white)
            .frame(maxWidth: 200)
            .padding(.all)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color("color.theme"))
            )
            
        }
        .padding(.all)
    }
}
