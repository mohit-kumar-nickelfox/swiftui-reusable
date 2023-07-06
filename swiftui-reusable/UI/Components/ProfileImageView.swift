//
//  ProfileImageView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

struct ProfileImageView: View {
    
    var didSelectImage: (_ image: UIImage)->Void
    
    /// Environment Variable: Color Scheme
    @Environment(\.colorScheme) var colorScheme
    
    // Data
    @State private var image = UIImage()
    
    // State vars
    @State private var showConfirmationDialogue: Bool = false
    @State private var openCamera = false
    @State private var openGallery = false
    
    var body: some View {
        Button {
            showConfirmationDialogue = true
        } label: {
            ZStack {
                
                self.colorScheme == .light
                ? Color.black.opacity(0.15)
                : Color.white.opacity(0.15)
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                
                Image(systemName: "camera.fill")
                    .resizable()
                    .tint((self.colorScheme == .light ? .black : .white))
                    .frame(width: 20, height: 15)
                    .opacity(0.6)
            }
            .frame(width: 100, height: 100)
            .cornerRadius(50)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.black.opacity(0.2), lineWidth: 2)
            )
        }
        .onChange(of: self.image) { newValue in
            self.didSelectImage(newValue)
        }
        .sheet(isPresented: $openCamera) {
            ImagePicker(sourceType: .camera, selectedImage: self.$image)
        }
        
        .sheet(isPresented: $openGallery) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .confirmationDialog("Select Source",
                            isPresented: $showConfirmationDialogue,
                            titleVisibility: .visible) {
            Button("Camera") {
                openCamera = true
            }
            
            Button("Gallery") {
                openGallery = true
            }
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(didSelectImage: {_ in })
    }
}
