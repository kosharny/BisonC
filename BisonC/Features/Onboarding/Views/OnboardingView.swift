//
//  OnboardingView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 09.01.2026.
//

import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let description: String
    let imageName: String
    let buttonTitle: String
}

struct OnboardingView: View {
    @State private var selection = 0
    let onFinish: () -> Void

    private let pages: [OnboardingPage] = [
        .init(
            title: "WELCOME TO BISONC",
            subtitle: "Discover the Bison Story",
            description: "The bison provided food, clothing and shelter, was a sacred symbol of strength and unity – the heart of the prairies.",
            imageName: "onboarding1",
            buttonTitle: "CONTINUE"
        ),
        .init(
            title: "WELCOME TO BISONC",
            subtitle: "Near Extinction — and the Comeback",
            description: "In the 19th century, they were almost exterminated, but today, thanks to protection, the population is recovering.",
            imageName: "onboarding2",
            buttonTitle: "CONTINUE"
        ),
        .init(
            title: "WELCOME TO BISONC",
            subtitle: "Offline Library in Your Pocket",
            description: "Everything is available without the internet + FAVORITES + HISTORY",
            imageName: "onboarding3",
            buttonTitle: "START"
        )
    ]

    var body: some View {
        ZStack {
            BackgroundView()

            TabView(selection: $selection) {
                ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                    OnboardingPageView(page: page,
                                       index: index,
                                       total: pages.count, onFinish: onFinish,
                                       selection: $selection)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    let index: Int
    let total: Int
    let onFinish: () -> Void

    @Binding var selection: Int

    var body: some View {
        VStack(spacing: 24) {
            header

            Spacer()

            content

            Spacer()

            footer
        }
        .padding()
    }

    private var header: some View {
        HStack {
            if index > 0 {
                Button {
                    onFinish()
                } label: {
                    Image("backButton")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 30)
                }
            }

            Spacer()

            Button("SKIP") {
                selection = total - 1
            }
            .font(.customPlayfairDisplaySC(.bold, size: 18))
            .padding(.horizontal, 4)
            .padding()
            .background(
                Capsule()
                    .stroke(.brownApp.opacity(0.6), lineWidth: 1)
            )
        }
        .foregroundStyle(.brownApp)
    }

    private var content: some View {
        VStack(spacing: 20) {
            Text(page.title)
                .font(.customPlayfairDisplay(.bold, size: 24))
                .foregroundStyle(.brownApp)

            Text(page.subtitle)
                .font(.customPlayfairDisplay(.balck, size: 20))
                .foregroundStyle(.brownApp)

            Image(page.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)

            Text(page.description)
                .font(.customInriaSans(.regular, size: 18))
                .foregroundStyle(.brownApp)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            pageIndicator
        }
    }

    private var footer: some View {
        Button {
            if index < total - 1 {
                selection += 1
            } else {
                onFinish()
            }
        } label: {
            Text(page.buttonTitle)
                .font(.customPlayfairDisplay(.bold, size: 18))
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    Capsule()
                        .stroke(.brownApp.opacity(0.6), lineWidth: 1)
                )
        }
        .foregroundStyle(.brownApp)
    }

    private var pageIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { i in
                Circle()
                    .fill(i == index ? Color.brownApp : Color.brownApp.opacity(0.4))
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, 8)
    }
}

#Preview {
    OnboardingView(onFinish: { })
}
