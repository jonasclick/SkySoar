//
//  AddFlightLogView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 05.06.2024.
//

import SwiftUI
import SwiftData

struct AddFlightLogView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var flightLog: FlightLog
    
    @State private var aircraftModel = ""
    @State private var aircraftRegistration = ""
    @State private var departureDate = Date()
    @State private var departureLocation = ""
    @State private var arrivalDate = Date()
    @State private var arrivalLocation = ""
    @State private var flightTime = {
        var dateComponents = DateComponents()
        dateComponents.hour = 0
        dateComponents.minute = 0
        return Calendar.current.date(from: dateComponents) ?? Date()
    }()
    
    @State private var pilotFunctionInput = "PIC"
    let pilotFunctions = ["PIC", "Dual", "Instructor"]
    private var pilotFunctionTime: PilotFunctionTime {
            switch pilotFunctionInput {
            case "PIC":
                return .pic
            case "Dual":
                return .dual
            case "Instructor":
                return .instructorAndPic
            default:
                return .pic // Default case, adjust as needed
            }
    }

    @State private var remarks = ""
    
    @State private var showConfirmation = false
    
    var body: some View {
        ZStack {
            // Sheet Header and Content
            VStack {
                // Sheet Header Title
                ZStack {
                    Text("Add a Flight")
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
                                    Spacer()
                                }
                            }
                        }
                        
                        HStack {
                            Text("Location")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("Mollis", text: $departureLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .submitLabel(.done)
                            
                        }
                        .padding(.bottom, 20)
                        
                        
                        
                        // Arrival Information
                        HStack {
                            VStack (alignment: .leading) {
                                Text("Arrival")
                                    .font(.paragraphHeadline)
                                    .padding(.bottom, 0.005)
                                
                                Text("Time")
                                    .font(.paragraphText)
                                    .opacity(0.4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack {
                                HStack {
                                    DatePicker("Date and Time", selection: $arrivalDate, displayedComponents: .hourAndMinute)
                                        .environment(\.locale, Locale(identifier: "de_CH"))
                                        .labelsHidden()
                                    Spacer()
                                }
                            }
                        }
                        
                        HStack {
                            Text("Location")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("Mollis", text: $arrivalLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .submitLabel(.done)
                            
                        }
                        
                        Divider()
                            .padding(.horizontal, -16)
                            .padding(.vertical, 30)
                        
                        
                        
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
                            
                            VStack {
                                HStack {
                                    DatePicker("Flight Time", selection: $flightTime, displayedComponents: .hourAndMinute)
                                        .environment(\.locale, Locale(identifier: "de_CH"))
                                        .labelsHidden()
                                    Text("hh : mm")
                                        .font(.paragraphText)
                                        .opacity(0.4)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.bottom, 19)
                        
                        HStack {
                            Text("Pilot Function")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .padding(.trailing, 10)
                            
                            
                            
                            Picker("Pilot Function", selection: $pilotFunctionInput) {
                                ForEach(pilotFunctions, id: \.self) { f in
                                    Text(String(f))
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
                            
                            // TODO: TextField can't be exited, because it's multiline. Add "Done" button.
                        }
                        
                        
                    }
                    .padding()
                    
                    Spacer()
                }
                .scrollIndicators(.hidden)
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
                    
                    flightLog.flightTime = flightTime
                    
                    // TODO: Implement departureMode
                    flightLog.pilotFunctionTime = pilotFunctionTime
                    
                    flightLog.remarks = remarks
                    
                    context.insert(flightLog)
                    dismiss()
                    
                }, label: {
                    Text("Add Flight")
                        .font(.headline)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 5)
                })
                .buttonStyle(BorderedProminentButtonStyle())
                .padding(.bottom, 35)
            }
            .ignoresSafeArea()
            
        }
        .confirmationDialog("Exit without saving?", isPresented: $showConfirmation, titleVisibility: .visible) {
            Button("Don't save my flight.", role: .destructive) {
                dismiss()
            }
            .foregroundStyle(.red)
        }
        .onDisappear {
            showConfirmation = true
        }
    }
}

//#Preview {
//    AddFlightLogView()
//}
