////
////  WeekUIView.swift
////  Booking
////
////  Created by Aleksandra Asichka on 25/02/2025.
////
//
//import SwiftUI
//
//struct WeekUIView: View {
//    
//    var body: some View {
//       TabView(selection: $currentWeekIndex) {
//           ForEach(weekSlider.indices, id: \.self) {
//               index in
//               WeekView(weekSlider[index])
//           }
//        }
//       .onAppear() {
//           let currentWeek = Date().fetchWeek()
//           if let firstDate = currentWeek.first?.date {
//               weekSlider.append(currentWeek)
//           }
//       }
//    }
//    
//    @ViewBuilder func WeekView(_ week: [Date.WeekDay]) -> some View {
//        HStack(spacing: 0) {
//            ForEach(week) { day in
//                VStack(spacing: 8) {
//                    Text(day.date.format(with: "E"))
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    WeekUIView()
//}
