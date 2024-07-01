//
//  EditFlightLogView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 05.06.2024.
//

import SwiftUI
import SwiftData

struct EditFlightLogView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var flightLog: FlightLog
    var isEditMode: Bool
    
    @State private var aircraftModel = ""
    @State private var aircraftRegistration = ""
    @State private var departureDate = Date()
    @State private var departureLocation = ""
    @State private var arrivalDate = Date()
    @State private var arrivalLocation = ""
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    
    @State private var pilotFunctionInput = "PIC" // Default value for the picker
    let pilotFunctions = ["PIC", "Dual", "Instructor"] // Array of options for the picker
    private var pilotFunctionTime: PilotFunctionTime { // Read value from the picker and get database-conform value
        switch pilotFunctionInput {
        case "PIC":
            return .pic
        case "Dual":
            return .dual
        case "Instructor":
            return .instructorAndPic
        default:
            return .pic // Default case
        }
    }
    
    @State private var departureModeInput = "W" // Default value for the picker
    let departureModes = ["W", "A", "S"] // Array of options for the picker
    private var departureMode: DepartureMode { // Read value from the picker and get database-conform value
        switch departureModeInput {
        case "W":
            return .winch
        case "A":
            return .aerotow
        case "S":
            return .selfLaunching
        default:
            return .winch // Default case
        }
    }
    
    
    @State private var remarks = ""
    
    @State private var showConfirmation = false
    
    var body: some View {
        ZStack {
            VStack {
                // Sheet Header Title
                ZStack {
                    Text(isEditMode ? "Edit Flight" : "Add a Flight")
                        .font(.sheetHeadline)
                    HStack {
                        Spacer()
                        Button(action: {
                            showConfirmation = true
                        }, label: {
                            Image("close button")
                                .padding(.horizontal, 16)
                        })
                        
                    }
                }
                .padding(.top, 15)
                
                
                ScrollView {
                    
                    // Sheet Content
                    VStack (alignment: .leading) {
                        
                        // Aircraft Information
                        Text("Aircraft")
                            .font(.paragraphHeadline)
                            .padding(.bottom, 0.005)
                        HStack {
                            VStack (alignment: .leading) {
                                Text("Model")
                                    .font(.paragraphText)
                                    .opacity(0.4)
                                TextField("Arcus T", text: $aircraftModel)
                                    .padding(.trailing, 10)
                                    .submitLabel(.done)
                            }
                            VStack (alignment: .leading) {
                                Text("Registration")
                                    .font(.paragraphText)
                                    .opacity(0.4)
                                TextField("HB-1234", text: $aircraftRegistration)
                                    .submitLabel(.done)
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Divider()
                            .padding(.horizontal, -16)
                            .padding(.vertical, 30)
                        
                        
                        // Departure Information
                        HStack {
                            VStack (alignment: .leading) {
                                Text("Departure")
                                    .font(.paragraphHeadline)
                                    .padding(.bottom, 0.005)
                                
                                Text("Date and Time")
                                    .font(.paragraphText)
                                    .opacity(0.4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack {
                                HStack {
                                    DatePicker("Date and Time", selection: $departureDate)
                                        .environment(\.locale, Locale(identifier: "de_CH"))
                                        .labelsHidden()
                                }
                            }
                        }
                        
                        HStack {
                            Text("Location")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .padding(.trailing, 115)
                            TextField("Mollis", text: $departureLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .submitLabel(.done)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        .padding(.bottom, 20)
                        
                        
                        
                        // Arrival Information
                        HStack {
                            VStack (alignment: .leading) {
                                Text("Arrival")
                                    .font(.paragraphHeadline)
                                    .padding(.bottom, 0.005)
                                
                                Text("Date and Time")
                                    .font(.paragraphText)
                                    .opacity(0.4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack {
                                HStack {
                                    DatePicker("Date and Time", selection: $arrivalDate)
                                        .environment(\.locale, Locale(identifier: "de_CH"))
                                        .labelsHidden()
                                }
                            }
                        }
                        
                        HStack {
                            Text("Location")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .padding(.trailing, 115)
                            TextField("Mollis", text: $arrivalLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .submitLabel(.done)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        
                        Divider()
                            .padding(.horizontal, -16)
                            .padding(.top, 30)
                        
                        
                        
                        // Flight Time Information
                        HStack {
                            VStack (alignment: .leading) {
                                Text("Flight Time")
                                    .font(.paragraphHeadline)
                                    .padding(.bottom, 0.005)
                                
                                Text("Total Time of Flight")
                                    .font(.paragraphText)
                                    .opacity(0.4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            // Hours Input
                            Picker("Hours", selection: $hours) {
                                ForEach(0..<24) { hour in
                                    Text("\(hour)").tag(hour)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 50, height: 100)
                            Text("h")
                                .padding(.trailing, 20)
                            
                            // Minutes Input
                            Picker("Minutes", selection: $minutes) {
                                ForEach(0..<60) { minute in
                                    Text("\(minute)").tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 50, height: 100)
                            Text("min")
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("Pilot Function")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .padding(.trailing, 25)
                            
                            Picker("Pilot Function", selection: $pilotFunctionInput) {
                                ForEach(pilotFunctions, id: \.self) { f in
                                    Text(f)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                        }
                        
                        // Departure Mode
                        HStack {
                            Text("Departure Mode")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .padding(.trailing, 10)
                            
                            Picker("Departure Mode", selection: $departureModeInput) {
                                ForEach(departureModes, id: \.self) { m in
                                    Text(m)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Divider()
                            .padding(.horizontal, -16)
                            .padding(.vertical, 30)
                        
                        // Remarks and Endorsements
                        VStack (alignment: .leading) {
                            Text("Remarks")
                                .font(.paragraphHeadline)
                                .padding(.bottom, 0.005)
                            
                            Text("and Endorsements")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("Write your remarks here.", text: $remarks, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom, 60)
                        }
                        
                        
                    }
                    .padding()
                    
                    Spacer()
                }
                .scrollIndicators(.hidden)
                
                // When editing a flight, pre-fill all the existing data
                .onAppear {
                    aircraftModel = flightLog.aircraftModel
                    aircraftRegistration = flightLog.aircraftRegistration
                    departureDate = flightLog.departureDate ?? Date()
                    departureLocation = flightLog.departureLocation
                    arrivalDate = flightLog.arrivalDate ?? Date()
                    arrivalLocation = flightLog.arrivalLocation
                    
                    let totalMinutes = Int(flightLog.flightTime) / 60
                    hours = totalMinutes / 60
                    minutes = totalMinutes % 60
                    
                    pilotFunctionInput = flightLog.pilotFunctionString
                    departureModeInput = flightLog.departureModeString
                    remarks = flightLog.remarks
                }
            }
            
            
            // Add Flight Button
            VStack {
                Spacer()
                Button(action: {
                    flightLog.departureLocation = departureLocation
                    flightLog.departureDate = departureDate
                    
                    flightLog.arrivalLocation = arrivalLocation
                    flightLog.arrivalDate = arrivalDate
                    
                    flightLog.aircraftModel = aircraftModel
                    flightLog.aircraftRegistration = aircraftRegistration
                    
                    let totalSeconds = (hours * 3600) + (minutes * 60)
                    flightLog.flightTime = TimeInterval(totalSeconds)
                    
                    flightLog.departureMode = departureMode
                    flightLog.pilotFunctionTime = pilotFunctionTime
                    
                    flightLog.remarks = remarks
                    
                    if !isEditMode {context.insert(flightLog)}
                    dismiss()
                    
                }, label: {
                    Text(isEditMode ? "Save Flight" : "Add Flight")
                        .font(.headline)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 5)
                })
                .buttonStyle(BorderedProminentButtonStyle())
                .padding(.bottom, 35)
            }
            .ignoresSafeArea()
            
        }
        .confirmationDialog("Do you want to exit without saving your changes?", isPresented: $showConfirmation, titleVisibility: .visible) {
            Button("Discard Changes", role: .destructive) {
                dismiss()
            }
            .foregroundStyle(.red)
        }
        .onDisappear {
            showConfirmation = true // TODO: Doesn't really work...
        }
    }
}

//#Preview {
//    EditFlightLogView()
//}
