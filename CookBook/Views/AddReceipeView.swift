//
//  AddReceipeView.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import SwiftUI
import PhotosUI

struct AddReceipeView: View {
    
    @State var viewModel = AddReceipeViewModel()
    @StateObject var imageLoaderViewModel = ImageLoaderViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                    Text("What's New")
                        .font(.system(size: 26, weight: .bold))
                        .padding(.top, 20)
                ZStack {
                    ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.border.opacity(0.5))
                                .frame(height: 200)
                            Image(systemName: "photo.fill")
                        }
                    if let displayedReceipeImage = viewModel.dispalyedReceipeImage {
                        displayedReceipeImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .clipped()
                    }
                }
                .onTapGesture {
                    viewModel.showImageOption = true
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
                    Task {
                        if let imageUrl = await viewModel.upload() {
                            viewModel.addReceipe(imageUrl: imageUrl) { success in
                                if success { dismiss() }
                            }
                        }
                    }
                }, label: {
                    Text("Add Receipe")
                })
                .buttonStyle(PrimaryButtonStyle())
                Spacer()
                }
            .padding(.horizontal)
            .photosPicker(isPresented: $viewModel.showLibrary, selection: $imageLoaderViewModel.imageSelection, matching: .images, photoLibrary: .shared())
            .onChange(of: imageLoaderViewModel.imageToUpload, { _, newValue in
                if let image = newValue {
                    viewModel.dispalyedReceipeImage = Image(uiImage: image)
                    viewModel.receipeImage = image
                }
            })
            .confirmationDialog("Upload an image to your receipe", isPresented: $viewModel.showImageOption, titleVisibility: .visible) {
                Button(action: {
                    viewModel.showLibrary = true
                }, label: {
                    Text("Upload from Photo Library")
                })
                Button(action: {
                    viewModel.showCamera = true
                }, label: {
                    Text("Upload from camera")
                })
            }
            .fullScreenCover(isPresented: $viewModel.showCamera) {
                CameraPicker { image in
                    viewModel.dispalyedReceipeImage = Image(uiImage: image)
                    viewModel.receipeImage = image
                }
            }
            if viewModel.isUploading {
                ProgressComponentView(value: $viewModel.uploadProgress)
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button {
                
            } label: {
                Text("OK")
            }

        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    AddReceipeView()
}
