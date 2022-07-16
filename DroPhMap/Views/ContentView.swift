//
//  ContentView.swift
//  DroPhMap
//
//  Created by Jakub Chodara on 15/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAlert = false
    @State private var showAlert2 = false
    @State var showImagePicker = false
    @StateObject var imageData = ImageData()
    
    var body: some View {
        
        NavigationView{
            VStack{
                if imageData.imageNote.isEmpty {
                    // it will be forever true
                    Text("Try adding a note")
                        .italic()
                    .foregroundColor(.gray)
                    
                }else{
                        homeView()
                    }
                
            }
             .navigationTitle("DroPhMap")
             .sheet(isPresented: $showImagePicker){
                 ImagePicker(sourceType: .photoLibrary){
                     image in
                     imageData.addNote(image: image, title: "Add title!", desc: "Add description", lat: "Add latitude", long: "Add Longitude")
                 }
             }
             .toolbar {
                 
                 ToolbarItem(placement: .navigationBarTrailing) {
                     
                     Button {
                         showAlert2 = true
                     }
                 label:{
                   Label("Image2", systemImage: "figure.wave")
                 }
                     .alert(isPresented: $showAlert2) {
                         Alert(
                             title: Text("Written by ku6a-cj"),
                             message: Text("One of my first projects \n" +
                                           "Please let me know your feedback \n"
                                          + "core by Code Place \n") +
                             Text(Image(systemName: "globe" ))
                             
                         )
                     }
                 }
                 
                 
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button {
                         showImagePicker.toggle()
                     } label: {
                     Label("Image", systemImage: "photo.on.rectangle.angled")
                     }
                 }
               
                 ToolbarItem(placement: .navigationBarTrailing) {
                     
                     Button{
                            showAlert = true
                        }
                 label: {
                     Label("Trash", systemImage: "trash")
                 }
                 .tint(.red)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Delete"),
                                message: Text("Are you sure? You want to delete all data, you can't undo that process ;)"),
                                primaryButton: .default(
                                    Text("Yes"),
                                    action: imageData.resetUserData
                                ),
                                secondaryButton: .destructive(
                                    Text("No")
                                )
                            )
                        }
                    
                 }
                 
             
                 
             }
        }
        .environmentObject(imageData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




