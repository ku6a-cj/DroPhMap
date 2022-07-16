//
//  ImageDataModel.swift
//  DroPhMap
//
//  Created by Jakub Chodara on 15/07/2022.
//

import Foundation
import SwiftUI

struct ImageNote: Codable, Hashable, Identifiable {
    var id = UUID()
    var image: Data
    var title: String
    var description: String
    var Latitude: String
    var Longitude: String
}

@MainActor class ImageData : ObservableObject {
    private let IMAGES_KEY  = "ImagesKey"
    var imageNote: [ImageNote] {
        didSet {
            objectWillChange.send()
            //save data
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: IMAGES_KEY) {
            if let decodedNotes = try? JSONDecoder().decode([ImageNote].self, from: data)
            {
                imageNote = decodedNotes
                print("Note data succesfully retrived!")
                return
            }
        }
        
        imageNote = [ ]
    }
    
    func addNote(image: UIImage, title: String, desc:String, lat:String, long:String){
        if let pngRepresentation = image.pngData(){
            let tempNote = ImageNote(image: pngRepresentation, title: title, description: desc, Latitude: lat, Longitude: long)
            imageNote.insert(tempNote, at: 0)
            print("Note Added!")
            saveData()
        }
    }
    
    func editNote(id: UUID, title: String, description: String, Latitude: String, Longitude: String){
        if let note = imageNote.first(where: {$0.id == id }) {
            let index = imageNote.firstIndex(of:note)
            
            imageNote[index!].title = title
            imageNote[index!].description = description
            imageNote[index!].Latitude = Latitude
            imageNote[index!].Longitude = Longitude
        }
    }

    func saveData(){
        if let encodedNotes = try? JSONEncoder().encode(imageNote) {
            UserDefaults.standard.set(encodedNotes, forKey: IMAGES_KEY )
        }
    }
    
    func resetUserData(){
        UserDefaults.standard.removeObject(forKey: IMAGES_KEY)
        UserDefaults.resetStandardUserDefaults()
        
        imageNote = []
    }
    
    func deleteThisObject(id: UUID){
   
        if let note = imageNote.first(where: {$0.id == id }) {
            let index = imageNote.firstIndex(of:note)
        
            imageNote.remove(at: index ?? 0)
    }
}
}
