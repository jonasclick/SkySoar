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
    
    @State private var aircraftModel: String = ""
    @State private var aircraftRegistration: String = ""
    @State private var departureDate: Date = Date()
    @State private var departureLocation: String = ""
    @State private var arrivalDate: Date = Date()
    @State private var arrivalLocation: String = ""
    
    @State private var isAutoFlightTime: Bool
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    
    // MARK: Pilot Function
    // Default value for the picker
    @State private var pilotFunctionInput: String = "PIC"
    
    // Array of options for the picker
    let pilotFunctions = ["PIC", "Dual", "Instructor"]
    
    // Read value from the picker and get database-conform value
    private var pilotFunctionTime: PilotFunctionTime {
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
    
    // MARK: Departure Mode
    // Default value for the picker
    @State private var departureModeInput: String = "W"
    
    // Array of options for the picker
    let departureModes = ["W", "A", "S"]
    
    // Read value from the picker and get database-conform value
    private var departureMode: DepartureMode {
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
    
    @State private var isPopoverPresented: Bool = false
    
    @State private var remarks: String = ""
    
    @State private var showDateAlert: Bool = false
    @State private var showConfirmation: Bool = false
    
    
    init(flightLog: FlightLog, isEditMode: Bool) {
        self.flightLog = flightLog
        self.isEditMode = isEditMode
        self.isAutoFlightTime = flightLog.isAutoFlightTime
    }
    
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
                            HapticHelper.warning()
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
                        
                        // MARK: Aircraft Information
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
                                    .onChange(of: aircraftModel) { oldValue, newValue in
                                        aircraftModel = TextHelper.limitChars(input: aircraftModel, limit: 25)
                                    }
                            }
                            VStack (alignment: .leading) {
                                Text("Registration")
                                    .font(.paragraphText)
                                    .opacity(0.4)
                                TextField("HB-1234", text: $aircraftRegistration)
                                    .submitLabel(.done)
                                    .onChange(of: aircraftRegistration) { oldValue, newValue in
                                        aircraftRegistration = TextHelper.limitChars(input: aircraftRegistration, limit: 10)
                                    }
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Divider()
                            .padding(.horizontal, -16)
                            .padding(.vertical, 30)
                        
                        
                        // MARK: Departure Information
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
                                        .onChange(of: departureDate) { oldValue, newValue in
                                            if isAutoFlightTime {
                                                let timeDifference = DateHelper.calculateTimeDifference(
                                                    from: DateHelper.removeSeconds(from: departureDate),
                                                    to: DateHelper.removeSeconds(from: arrivalDate))
                                                hours = timeDifference.hours
                                                minutes = timeDifference.minutes
                                            }
                                        }
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
                                .onChange(of: departureLocation) { oldValue, newValue in
                                    departureLocation = TextHelper.limitChars(input: departureLocation, limit: 30)
                                }
                            
                        }
                        .padding(.bottom, 20)
                        
                        
                        
                        // MARK: Arrival Information
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
                                        .onChange(of: arrivalDate) { oldValue, newValue in
                                            if isAutoFlightTime {
                                                let timeDifference = DateHelper.calculateTimeDifference(
                                                    from: DateHelper.removeSeconds(from: departureDate),
                                                    to: DateHelper.removeSeconds(from: arrivalDate))
                                                hours = timeDifference.hours
                                                minutes = timeDifference.minutes
                                            }
                                        }
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
                                .onChange(of: arrivalLocation) { oldValue, newValue in
                                    arrivalLocation = TextHelper.limitChars(input: arrivalLocation, limit: 30)
                                }
                            
                        }
                        
                        Divider()
                            .padding(.horizontal, -16)
                            .padding(.top, 30)
                        
                        
                        
                        // MARK: Flight Time Information
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
                            
                            
                            // Menu to toggle flight time calculation (automatic / manual)
                            /// Some pilots measure departure and arrival to the minute while flight time to the second,
                            /// therefore they have to be able to add / subtract one minute from the automatic flight time calculation)
                            Menu {
                                Text("Flight Time")
                                
                                Button(action: {
                                    isAutoFlightTime = true
                                    
                                    // Update flight time
                                    let timeDifference = DateHelper.calculateTimeDifference(
                                        from: DateHelper.removeSeconds(from: departureDate),
                                        to: DateHelper.removeSeconds(from: arrivalDate))
                                    
                                    hours = timeDifference.hours
                                    minutes = timeDifference.minutes
                                    
                                }, label: {
                                    
                                    Text("Calculate Automatically")
                                    Image(systemName: "a.square")
                                })
                                
                                Button(action: {
                                    isAutoFlightTime = false
                                }, label: {
                                    Text("Set Manually")
                                    Image(systemName: "m.square")
                                })
                                
                                
                            } label: {
                                Image(systemName: isAutoFlightTime ? "a.square" : "m.square")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            
                            // Picker Wheels to display (and manually choose) flight time
                            // Hours Input
                            Picker("Hours", selection: $hours) {
                                ForEach(0..<24) { hour in
                                    Text("\(hour)").tag(hour)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 50, height: 100)
                            .disabled(isAutoFlightTime)
                            .opacity(isAutoFlightTime ? 0.4 : 1)
                            
                            Text("h")
                                .padding(.trailing, 20)
                                .disabled(isAutoFlightTime)
                                .opacity(isAutoFlightTime ? 0.4 : 1)
                            
                            // Minutes Input
                            Picker("Minutes", selection: $minutes) {
                                ForEach(0..<60) { minute in
                                    Text("\(minute)").tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 50, height: 100)
                            .disabled(isAutoFlightTime)
                            .opacity(isAutoFlightTime ? 0.4 : 1)
                            
                            Text("min")
                                .disabled(isAutoFlightTime)
                                .opacity(isAutoFlightTime ? 0.4 : 1)
                            
                            Spacer()
                            
                            
                        }
                        
                        // MARK: Pilot Function Picker
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
                        
                        // MARK: Departure Mode Picker
                        HStack {
                            
                            // Title
                            Text("Departure Mode")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .padding(.trailing, 10)
                            
                            // Info pop-up to explain departure mode letters
                            Menu {
                                Text("W = Winch, A = Aerotow,\nS = Self Launching")
                            } label: {
                                Image(systemName: "questionmark.circle")
                                    .font(.infoBoxContent)
                                    .opacity(0.4)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // Departure Mode Picker
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
                        
                        // MARK: Remarks and Endorsements
                        VStack (alignment: .leading) {
                            Text("Remarks")
                                .font(.paragraphHeadline)
                                .padding(.bottom, 0.005)
                            
                            Text("and Endorsements")
                                .font(.paragraphText)
                                .opacity(0.4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("Write your remarks here.", text: $remarks)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom, 60)
                                .submitLabel(.done)
                                .onChange(of: remarks) { oldValue, newValue in
                                    remarks = TextHelper.limitChars(input: remarks, limit: 180)
                                }
                        }
                        
                        
                    }
                    .padding()
                    
                    Spacer()
                }
                .scrollIndicators(.hidden)
                
                // When editing a flight, pre-fill all the existing data
                .onAppear {
                    populateFlightData()
                }
            }
            
            
            // Add Flight Button
            VStack {
                Spacer()
                Button(action: {
                    if arrivalDate < Date() {
                        updateFlightLog()
                        if !isEditMode {context.insert(flightLog)}
                        dismiss()
                        
                        HapticHelper.success()
                    } else {
                        showDateAlert = true
                    }
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
        .confirmationDialog("Do you want to exit without saving your changes?",
                            isPresented: $showConfirmation,
                            titleVisibility: .visible) {
            Button("Discard Changes", role: .destructive) {
                dismiss()
            }
            .foregroundStyle(.red)
        }
                            .alert(isPresented: $showDateAlert) {
                                Alert(title: Text("Can't save flight"),
                                      message: Text("Arrival of your flight can't be in the future."),
                                      dismissButton: .default(Text("OK")))
                            }
        // Auto-save to prevent data loss if user swipes down the sheet (accidentally)
                            .onDisappear {
                                if arrivalDate < Date() {
                                    updateFlightLog()
                                }
                            }
    }
    
    private func populateFlightData() {
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
    
    private func updateFlightLog() {
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
        
        // Save flight time calculation mode to the flightLog
        // for correct setup when editing a flightLog
        flightLog.isAutoFlightTime = isAutoFlightTime
    }
}
