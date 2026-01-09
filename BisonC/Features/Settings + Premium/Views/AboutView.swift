//
//  AboutView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 09.01.2026.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                
                
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                //
                            } label: {
                                Image("backButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 40)
                            }
                            
                            Spacer()
                            
                        }
                        
                        Text("About")
                            .font(.customPlayfairDisplay(.bold, size: 24))
                            .foregroundStyle(.brownApp)
                    }
                    
                    .padding(.top, getSafeAreaTop())
                    .padding()
                    
                    VStack {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 160)
                        
                        Text("Version: 1.0.0")
                            .font(.customInriaSans(.bold, size: 20))
                            .foregroundStyle(.brownApp)
                        
                        Text("BisonC  is your comprehensive guide to the history, culture, and conservation of the American bison, designed for educational exploration.")
                            .font(.customInriaSans(.regular, size: 18))
                            .foregroundStyle(.darkTextApp)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Content disclaimer ")
                                .font(.customInriaSans(.bold, size: 18))
                                .foregroundStyle(.darkTextApp)
                            
                            Text("All content is sourced from reputable educational and historical archives for accuracy. This app is intended for educational purposes.")
                                .font(.customInriaSans(.regular, size: 18))
                                .foregroundStyle(.darkTextApp)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.beigeAppCat)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.beigeApp.opacity(0.5))
                        )
                        
                        Spacer()
                        
                        HStack {
                            Button {
                                //
                            } label: {
                                HStack{
                                    Text("Privacy Policy")
                                        .font(.customInriaSans(.bold, size: 16))
                                        .foregroundStyle(.brownApp)
                                    Image(systemName: "arrow.up.right")
                                        .foregroundStyle(.brownApp)
                                }
                            }
                            Spacer()
                            Button {
                                //
                            } label: {
                                HStack{
                                    Text("Terms")
                                        .font(.customInriaSans(.bold, size: 16))
                                        .foregroundStyle(.brownApp)
                                    Image(systemName: "arrow.up.right")
                                        .foregroundStyle(.brownApp)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, getSafeAreaBottom() + 40)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    AboutView()
}
