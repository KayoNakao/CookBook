//
//  LoadingComponentView.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import SwiftUI

struct LoadingComponentView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
            ProgressView()
                .tint(.white)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingComponentView()
}
