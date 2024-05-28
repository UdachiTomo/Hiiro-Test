//
//  CalendarView.swift
//  Hiiro Test
//
//  Created by udachi_tomo on 28.05.2024.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewModel: CalendarViewModel
    @Namespace var animation
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.currentWeek, id: \.self) { day in
                                    VStack(spacing: 10) {
                                        Text(viewModel.extractDate(date: day, format: "EEE", with: true))
                                            .font(.system(size: 11))
                                            .fontWeight(.light)
                                            .foregroundColor(.white)
                                        Text(viewModel.extractDate(date: day, format: "dd", with: false))
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 44, height: 72)
                                    .background(viewModel.isToday(date: day) ? .purple : .secondary)
                                    .cornerRadius(100)
                                    .background(
                                        ZStack {
                                            if viewModel.isToday(date: day) {
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(lineWidth: 2)
                                                    .foregroundStyle(.gray)
                                                    .frame(width: 52, height: 80)
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                    )
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.currentDay = day
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        Text("Activities")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .hLeading()
                            .padding(.leading, 17)
                        activitiesView()
                    } header: {
                        headerView()
                            .padding(.bottom, -20)
                    }
                }
            }
        }
    }
    
    private func activitiesView() -> some View {
        LazyVStack(spacing: 18) {
            if let activities = viewModel.filtredActivities {
                if activities.isEmpty {
                    Text("No Activities Today")
                        .foregroundColor(.white)
                        .offset(y:100)
                    
                } else {
                    ForEach(activities) { activity in
                        ActivityElementView(activity: activity)
                        
                    }
                }
            } else {
                ProgressView()
                    .offset(y: 100)
            }
        }
        .onChange(of: viewModel.currentDay) {
            viewModel.filtredActivitiesToday()
        }
    }
    
    private func ActivityElementView(activity: Actitvity) -> some View {
        HStack {
            Image(activity.image)
            VStack {
                HStack {
                    Text(activity.type)
                    Text(viewModel.extractDate(date: activity.calendarDate, format: "dd", with: false))
                        .fontWeight(.medium)
                        .hTrailing()
                        .padding(.trailing, 10)
                }
                .foregroundColor(.white)
                .hLeading()
                HStack {
                    Text(activity.activityTime)
                    Text(activity.activityDescription)
                    Text(viewModel.extractDate(date: activity.calendarDate, format: "EEE", with: true))
                        .hTrailing()
                        .padding(.trailing, 7)
                }
                .lineLimit(1)
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .hLeading()
                
            }
        }
    }
    
    private func headerView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: -10) {
                Text(viewModel.extractDate(date: Date(), format: "MMM YYYY", with: false))
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .hLeading()
        }
        .padding()
    }
}

extension View {
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
