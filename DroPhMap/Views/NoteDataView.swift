//
//  NoteDataView.swift
//  DroPhMap
//
//  Created by Jakub Chodara on 15/07/2022.
//

import SwiftUI
import CoreLocation


struct NoteDataView: View {
    @EnvironmentObject var imageData: ImageData
    @State var note: ImageNote
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Image(uiImage: UIImage(data: note.image)!)
                        .resizable()
                        .frame(width: 300, height: 200, alignment: .center)
                    Spacer()
                }
                TextField("Title here!", text: $note.title)
                    .textSelection(.enabled)
                    .onTapGesture {
                        note.title = ""
                    }
                
                TextField("Latitude here!", text: $note.Latitude)
                    .textSelection(.enabled)
                    .onTapGesture {
                        note.Latitude = ""
                    }
                TextField("Longitude here!", text: $note.Longitude)
                    .textSelection(.enabled)
                    .onTapGesture {
                        note.Longitude = ""
                    }
                ZStack{
                    TextEditor(text: $note.description)
                        .textSelection(.enabled)
                        .frame( height: 200)
                    
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("\(note.description.count)/120")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    
                
                 
                }
                ZStack{
                    VStack{
                        GeometryReader { proxy in
                            MapView(coordinate: CLLocationCoordinate2D(
                                latitude: Double(note.Latitude) ?? 52.2531871,
                                longitude: Double(note.Longitude) ?? 20.9006214))
                                .frame(width: proxy.size.width,
                                       height: 200,
                                       alignment: .center)
                        }
                        
                    }
                    .navigationTitle("SwiftUI Map")
                }
                .frame(height: 200)
                
                HStack{
                    Spacer()
                    Button("Confirm Changes") {
                        imageData.editNote(id: note.id, title: note.title, description: note.description, Latitude: note.Latitude, Longitude: note.Longitude)
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    
                    
                }
                HStack{
                    Spacer()
                    Button("Delete") {
                        imageData.deleteThisObject(id: note.id)
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct NoteDataView_Previews: PreviewProvider {
    static var previews: some View {
        let tempImage = UIImage(systemName: "map")?.pngData()
        
        NoteDataView(note: ImageNote(id: UUID(), image: tempImage!, title: "Enter Title", description: "Enter description", Latitude: "Enter Latitude", Longitude: "Enter Longitude"))
            .environmentObject(ImageData())
        
    }
}
