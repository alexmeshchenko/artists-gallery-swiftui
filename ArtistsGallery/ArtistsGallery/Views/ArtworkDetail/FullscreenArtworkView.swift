//
//  FullscreenArtworkView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//

import SwiftUI

// MARK: - FullscreenArtworkView
struct FullscreenArtworkView: View {
    let artwork: Artwork
    @Environment(\.dismiss) private var dismiss
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastMagnification: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            if !artwork.image.isEmpty {
                Image(artwork.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                let delta = value / lastMagnification
                                lastMagnification = value
                                scale *= delta
                            }
                            .onEnded { _ in
                                lastMagnification = 1.0
                                if scale < 1.0 {
                                    withAnimation(.spring()) {
                                        scale = 1.0
                                        offset = .zero
                                    }
                                } else if scale > 5.0 {
                                    withAnimation(.spring()) {
                                        scale = 5.0
                                    }
                                }
                            }
                            .simultaneously(with:
                                                DragGesture()
                                .onChanged { value in
                                    if scale > 1.0 {
                                        offset = value.translation
                                    }
                                }
                                .onEnded { _ in
                                    if scale <= 1.0 {
                                        withAnimation(.spring()) {
                                            offset = .zero
                                        }
                                    }
                                }
                                           )
                    )
            } else {
                Text("No Image Available")
                    .foregroundColor(.white)
                    .font(.title)
            }
        }
        .closeButton {
            dismiss()
        }
        .statusBarHidden()
        .onTapGesture(count: 2) {
            withAnimation(.spring()) {
                if scale > 1.0 {
                    scale = 1.0
                    offset = .zero
                } else {
                    scale = 2.0
                }
            }
        }
    }
}
