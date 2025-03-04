//
//  ReceipeDetailView.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import SwiftUI

struct ReceipeDetailView: View {
    
    let receipe: Receipe
    
    var body: some View {
        VStack {
            Image(receipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
                .clipped()
            HStack {
                Text(receipe.name)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                Image(systemName: "clock.fill")
                    .font(.system(size: 15))
                Text("\(receipe.time) mins")
                    .font(.system(size: 15))
            }
            .padding(.top)
            .padding(.horizontal)
            Text(receipe.instructions)
                .font(.system(size: 15))
                .padding(.top, 10)
                .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    ReceipeDetailView(receipe: Receipe.mockReceipes[0])
}
