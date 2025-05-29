//
//  ContentView.swift
//  Temparature convertor
//
//  Created by Varun Saxena on 29/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature = 0.0
    @State private var length = 1.5
    @State private var time = 0.0
    @State private var volume = 0.0
    @State private var selectedLengthUnit = "KM"
    @State private var selectedTimeUnit = "Hours"
    
    var lengthUnits : [String] = ["KM","Feet","Yard","Miles"]
    
    var timeUnits : [String] = ["Hours","Days","Seconds"]
    
    var convertCelToFer : Double {
        let currTemp = temperature
        return (currTemp * (9/5)) + 32
    }
    
    var convertLength : Double {
        let selectedUnit = selectedLengthUnit
        switch selectedUnit {
            case "KM":
                return length / 1000              // meters to kilometers
            case "Feet":
                return length * 3.28084           // meters to feet
            case "Yard":
                return length * 1.09361           // meters to yards
            case "Miles":
                return length / 1609.34           // meters to miles
            default:
                return length                     // fallback (no conversion)
            }
    }
    
    var calculateTime : Double {
        let myTime = selectedTimeUnit
        switch myTime {
            case "Hours":
                return time / 60            // minutes to hours
            case "Seconds":
                return time * 60            // minutes to seconds
            case "Days":
                return time / 1440          // minutes to days (24*60)
            default:
                return time
            }
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Convert Temperature"){
                    TextField("Temperature (℃)",value: $temperature,format: .number)
                    
                    Text("\(convertCelToFer)°F")
                }
                
                Section("Convert Length"){
                    TextField("Length in meters",value: $length,format: .number)
                    Picker("Convert to",selection: $selectedLengthUnit){
                        ForEach(lengthUnits,id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("Length converted to \(selectedLengthUnit):- \(convertLength)")
                }
                
                Section("Convert Time"){
                    
                    TextField("Time in minutes",value:$time,format: .number)
                    Picker("Convert to",selection: $selectedTimeUnit){
                        ForEach(timeUnits,id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("Time converted to \(selectedTimeUnit):- \(calculateTime)")
                }
                
            }
            .navigationTitle("Conversion App")
        }
    }
}

#Preview {
    ContentView()
}
