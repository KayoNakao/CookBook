//
//  AddReceipeView.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import SwiftUI

struct AddReceipeView: View {
    
    @State var viewModel = AddReceipeViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
                Text("What's New")
                    .font(.system(size: 26, weight: .bold))
                    .padding(.top, 20)
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.border.opacity(0.5))
                        .frame(height: 200)
                    Image(systemName: "photo.fill")
                }
                Text("Receipe Name")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.top)
            TextField("Receipe Name", text: $viewModel.receipeName)
                    .frame(height: 50)
                    .background(.border.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                Text("Preparation Time")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.top)
            Picker(selection: $viewModel.preparationTime) {
                ForEach(0...120, id: \.self) { time in
                    if time % 5 == 0 {
                        Text("\(time) mins")
                            .font(.system(size: 15))
                            .tag(time)
                    }
                }
            } label: {
                Text("Prep Time")
            }
            Text("Cooking Instructions")
                .font(.system(size: 15, weight: .semibold))
                .padding(.top)
            TextEditor(text: $viewModel.instructions)
                .frame(height: 150)
                .background(.border.opacity(0.5))
                .scrollContentBackground(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Button(action: {
                
            }, label: {
                Text("Add Receipe")
            })
            .buttonStyle(PrimaryButtonStyle())
            Spacer()
            }
        .padding(.horizontal)
    }
}

#Preview {
    AddReceipeView()
}
