//
//  ProgressComponentView.swift
//  CookBook
//
//  Created by Kayo on 2025-03-05.
//

import SwiftUI

struct ProgressComponentView: View {
    
    @Binding var value: Float
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
            ProgressView("Uploading...", value: value, total: 1)
                .padding(.horizontal)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProgressComponentView(value: .constant(0.5))
}
