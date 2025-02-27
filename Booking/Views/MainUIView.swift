//
//  MainUIView.swift
//  Booking
//
//  Created by Aleksandra Asichka on 19/02/2025.
//

import SwiftUI

struct MainUIView: View {
    // MARK: - Rroperties
    // MARK: Calendar properties
    @State private var selectedDate: Date?
    @State private var currentDate: Date = Date()
    @State private var currentWeekIndex: Int = 1
    @State private var weekSlider = [[Date.WeekDay]]()
    @State private var createWeek: Bool = true
    
    
    // MARK: View properties
    @Namespace private var animation
    @State private var showApproveView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
            ScrollView {
                
            }
        }
        .onAppear() {
            let currentWeek = Date().fetchWeek()
            if let firstDate = currentWeek.first?.date {
                weekSlider.append(firstDate.createPreviousWeek())
            }
            weekSlider.append(currentWeek)
            if let lastDate = currentWeek.last?.date {
                weekSlider.append(lastDate.createNextWeek())
            }
        }
    }
    
    @ViewBuilder func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                Text(currentDate.format(with: "MMMM"))
                    .foregroundStyle(.blue)
                Text(currentDate.format(with: "YYYY"))
                    .foregroundStyle(.gray)
                    
            }
            .font(.title.bold())
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) {
                    index in
                    WeekView(weekSlider[index])
                }
             }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
        }
        .hSpacing(.leading)
        .padding()
    }
    
    @ViewBuilder func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack(spacing: 8) {
                    Text(day.date.format(with: "E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    Text(day.date.format(with: "dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDay(day.date, currentDate) ? .white : .gray)
                        .frame(width: 36, height: 36)
                        .background {
                            if isSameDay(day.date, currentDate) {
                                Circle().fill(.blue)
                            } else {
                                Circle().fill(.clear)
                            }
                            if day.date.isToday {
                                Circle()
                                    .fill(.cyan)
                                    .frame(width: 6, height: 6)
                                    .vSpacing(.bottom)
                                    .offset(y: 12)
                            }
                        }
                }
                .hSpacing(.center)
                .onTapGesture {
                    withAnimation {
                        currentDate = day.date
                    }
                }
            }
            
        }
//        .background {
//            GeometryReader { proxy in
//                let minX = proxy.frame(in: .global).minX
//                
//                Color.clear
//                    .preference(key: OffsetKey.self, value: minX)
//                    .onPreferenceChange(OffsetKey.self) { value in
//                        if value.rounded() == 15 && createWeek {
//                            pagenateWeek()
//                        }
//                    }
//            }
//        }
    }
    
    func pagenateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.date.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex -= 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last, currentWeekIndex == weekSlider.count - 1 {
                weekSlider.append(lastDate.date.createNextWeek())
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
}

#Preview {
    MainUIView()
}
