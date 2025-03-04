//
//  HomeView.swift
//  CookBook
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel = HomeViewModel()
    @Environment(SessionManager.self) var sessionManager: SessionManager
    
    private let spacing: CGFloat = 5
    private let padding: CGFloat = 5
    
    var itemWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth - spacing * 2 - padding * 2) / 3
    }
    
    var itemHeight: CGFloat {
        itemWidth * 1.5
    }

    fileprivate func ReceipeRow(receipe: Receipe) -> some View {
        VStack(alignment: .leading) {
            Image(receipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: itemWidth, height: itemHeight)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .clipped()
            Text(receipe.name)
                .lineLimit(1)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.black)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: spacing) {
                    ForEach(0...2, id: \.self) { index in
                        NavigationLink {
                            ReceipeDetailView(receipe: Receipe.mockReceipes[index])
                        } label: {
                            ReceipeRow(receipe: Receipe.mockReceipes[index])
                        }

                    }
                }
                .padding(.horizontal, padding)
                Spacer()
                Button(action: {
                    viewModel.showAddReceipeView = true
                }, label: {
                    Text("Add Receipe")
                })
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal)
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showSignOutAlert = true
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    })
                }
            })
            .alert("Are you sure you would like to sign out?", isPresented: $viewModel.showSignOutAlert) {
                
                Button("Sign Out", role: .destructive) {
                    //sessionManager.sessionState = .loggedOut
                }
                Button("Cancel", role: .cancel) {
                    
                }
            }
        }
        .sheet(isPresented: $viewModel.showAddReceipeView) {
            AddReceipeView()
        }
    }
    
}

#Preview {
    HomeView()
        .environment(SessionManager())
}


