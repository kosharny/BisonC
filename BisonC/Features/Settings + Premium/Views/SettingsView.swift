//
//  SettingsView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 09.01.2026.
//

import SwiftUI

struct SettingsView: View {
    @State private var isEnter: Bool = true
    @State private var isNoEnter: Bool = false
    
    let onAboutTap: () -> Void
    
    var body: some View {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Image("settingsLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 50)
                        Spacer()
                    }
                    .padding(.top, getSafeAreaTop())
                    .padding()
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            Text("Premium tools")
                                .font(.customPlayfairDisplaySC(.bold, size: 18))
                                .foregroundStyle(.brownApp)
                            
                            HStack(spacing: 16) {
                                PremiumToolsCardView()
                                PremiumToolsCardView()
                            }
                            
                            Text("Preferences")
                                .font(.customPlayfairDisplaySC(.bold, size: 18))
                                .foregroundStyle(.brownApp)
                            
                            VStack(alignment: .leading) {
                                Text("Theme")
                                    .font(.customInriaSans(.regular, size: 18))
                                    .foregroundStyle(.darkTextTitleApp)
                                HStack {
                                    PreferencesCardButton(title: "Light", isActive: $isEnter)
                                    PreferencesCardButton(title: "Dark", isActive: $isNoEnter)
                                    PreferencesCardButton(title: "System", isActive: $isNoEnter)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.yellowApp)
                                )
                                Text("Text size")
                                    .font(.customInriaSans(.regular, size: 18))
                                    .foregroundStyle(.darkTextTitleApp)
                                HStack {
                                    PreferencesCardButton(title: "Small", isActive: $isNoEnter)
                                    PreferencesCardButton(title: "Medium", isActive: $isEnter)
                                    PreferencesCardButton(title: "Large", isActive: $isNoEnter)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.yellowApp)
                                )
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.beigeApp)
                                    .shadow(radius: 4, x: 0, y: 4)
                            )
                            
                            Text("Data")
                                .font(.customPlayfairDisplaySC(.bold, size: 18))
                                .foregroundStyle(.brownApp)
                            
                            VStack(alignment: .leading) {
                                
                                DataCardView(title: "Export Data")
                                
                                Divider()
                                    .frame(height: 2)
                                    .background(.beigeApp)
                                
                                DataCardView(title: "Reset History")
                                
                                Divider()
                                    .frame(height: 2)
                                    .background(.beigeApp)
                                
                                SettingsButton(title: "Restore Purchases", onTap: { })
                                
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.beigeApp)
                                    .shadow(radius: 4, x: 0, y: 4)
                            )
                            
                            Text("About")
                                .font(.customPlayfairDisplaySC(.bold, size: 18))
                                .foregroundStyle(.brownApp)
                            SettingsButton(title: "About the application", onTap: onAboutTap)
                                .padding(.horizontal)
                                .padding(.bottom, getSafeAreaBottom() + 50)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
    }
}

#Preview {
    SettingsView(onAboutTap: { })
}

struct SettingsButton: View {
    let title: String
    let onTap: () -> Void
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(title)
                .font(.customInriaSans(.regular, size: 16))
                .foregroundStyle(.beigeApp)
                
        }
        .padding()
         .frame(maxWidth: .infinity)
        .background(
            Capsule()
                .fill(.brownAppCat)
        )
        .overlay(
            Capsule()
                .stroke(Color.brownAppCat.opacity(0.5))
        )
    }
}

struct DataCardView: View {
    let title: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.customInriaSans(.regular, size: 18))
                    .foregroundStyle(.darkTextTitleApp)
                Image("premiumLabel")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 60)
            }
            Spacer()
            Button {
                //
            } label: {
                Text(title)
                    .font(.customInriaSans(.regular, size: 16))
                    .foregroundStyle(.beigeApp)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.brownAppCat)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.brownAppCat.opacity(0.5))
                    )
            }
        }
    }
}

struct PreferencesCardButton: View {
    let title: String
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            Text(title)
                .font(.customInriaSans(.regular, size: 14))
                .foregroundStyle(.darkTextTitleApp)
                .frame(minWidth: 50)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.lightBrownApp)
                        .opacity(isActive ? 1 : 0)
                )
        }
    }
}

struct PremiumToolsCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Text("Export Data. Export your reading history to a file")
                    .opacity(0)
                Image("premiumLock")
                    .resizable()
                    .scaledToFit()
            }
            Text("Export Data")
                .font(.customInriaSans(.bold, size: 16))
                .foregroundStyle(.darkTextTitleApp)
            Text("Export your reading history to a file")
                .font(.customInriaSans(.light, size: 14))
                .foregroundStyle(.darkTextTitleApp)
            
            HStack {
                Text("$1.99")
                    .font(.customInriaSans(.bold, size: 16))
                    .foregroundStyle(.darkTextTitleApp)
                Spacer()
                Button {
                    //
                } label: {
                    Text("Unlock")
                        .font(.customInriaSans(.regular, size: 16))
                        .foregroundStyle(.beigeApp)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.brownAppCat)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.brownAppCat.opacity(0.5))
                        )
                }
                
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.beigeApp)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.beigeApp.opacity(0.5))
                .shadow(radius: 4, x: 0, y: 4)
        )
    }
}
