//
//  ContentView.swift
//  AnimatedGlassTabs
//
//  Created by Kai Chi Tsao on 2025/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: CustomTab = .home
    
    var body: some View {
        TabView(selection: $activeTab) {
            Tab.init(value: .home) {
                Text("Home")
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            
            Tab.init(value: .notifications) {
                Text("Notification")
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            
            Tab.init(value: .settings) {
                Text("Settings")
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            CustomTabBarView()
                .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    func CustomTabBarView() -> some View {
        GlassEffectContainer(spacing: 10) {
            HStack(spacing: 10) {
                GeometryReader {
                    CustomTabBar(size: $0.size, barTint: .gray.opacity(0.3), activeTab: $activeTab) { tab in
                        VStack(spacing: 3) {
                            Image(systemName: tab.symbol)
                                .font(.title3)
                                .opacity(activeTab == tab ? 0 : 1 )
                            Text(tab.rawValue)
                                .font(.system(size: 10))
                                .fontWeight(.medium)
                        }
                        .symbolVariant(.fill)
                        .frame(maxWidth: .infinity)
                    }
                    
                    HStack(spacing: 0) {
                        ForEach(CustomTab.allCases, id: \.rawValue) { tab in
                            VStack(spacing: 3) {
                                Image(systemName: tab.selectedSymbol)
                                    .font(.title3)
                                    .scaleEffect(activeTab == tab ? 1.15 : 0.001)
                                    .rotationEffect(.degrees(activeTab == tab ? 360 : 0))
                                    .opacity(activeTab == tab ? 1 : 0)
                                Text(tab.rawValue)
                                    .font(.system(size: 10))
                                    .fontWeight(.medium)
                                    .opacity(0)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .animation(.spring(response: 0.6, dampingFraction: 0.4), value: activeTab)
                        }
                    }
                }
                .glassEffect(.regular.interactive(), in: .capsule)
            }
        }
        .frame(height: 55)
    }
}

#Preview {
    ContentView()
}
