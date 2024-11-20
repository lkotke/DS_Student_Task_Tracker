//
//  DS_Student_Task_Tracker_Widget.swift
//  DS_Student_Task_Tracker_Widget
//
//  Created by Logan Kotke on 11/8/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    //What sys will show when it gets no data
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: .now, jobDetail: JobDetail.allJobs[0])
    }
    
    // what the current version of the widget looks like (show right now)
    func snapshot(for configuration: SelectJobIntent, in context: Context) async -> DayEntry {
        DayEntry(date: .now, jobDetail: configuration.job)
    }
    
    // where the timeline gets created
    func timeline(for configuration: SelectJobIntent, in context: Context) async -> Timeline<DayEntry> {
        var entries: [DayEntry] = [] //array of entries (times to update)

        // Generate a timeline consisting of 5 entries
        let currentDate = Date() // date right now
        for dayOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: dayOffset, to: currentDate)!
            
            /*
            let startOfDate = Calendar.current.startOfDay(for: entryDate) // specify what 'midnight' is defined as
            let entry = DayEntry(date: startOfDate, jobDetail: configuration.job)
            entries.append(entry)
            */
            
            let entry = DayEntry(date: .now, jobDetail: configuration.job)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    //let configuration: SelectJobIntent
    let jobDetail: JobDetail
}

// test commit and push

struct DS_Student_Task_Tracker_WidgetEntryView : View {
    //var entry: Provider.Entry
    var entry: DayEntry
    
    //static let fullColor: WidgetRenderingMode
    
    @Environment(\.widgetRenderingMode) var renderingMode
    
    var body: some View {
        // add an intentconfiguration for the students and the student sups
        
        ZStack{
            ContainerRelativeShape()
                .fill(.black.gradient)
            VStack(alignment: .center){
                HStack(alignment: .top){
                    Text(entry.date.formatted(.dateTime.weekday(.wide)))
                    Text(" - ")
//                    Text(entry.date.formatted())
                    Text(Date(), style: .date)
                }
                .foregroundColor(.white.opacity(0.7))
                .padding(.vertical, 5)
                Text("Tasks:")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow.opacity(0.8))
                Divider()
                    .padding(.horizontal, 10)
                VStack(alignment: .leading, spacing: 4){
                    
                    // loop through each tasks for the chosen role
                    ForEach(0..<entry.jobDetail.tasks.count){ task in
                        Text(entry.jobDetail.tasks[task])
                    }
                    
                    if(entry.jobDetail.id == "FTE"){
                        // prompt for password
                    }
                    
                    VStack(alignment: .leading){
                            Text(" - Extra Tasks (if you have spare time):")
                            Text("     - Organize Workbench Area")
                            Text("     - Update the Storage Area Sharepoint Site")
                                .multilineTextAlignment(.trailing)
                        }
                    .fontWeight(.ultraLight)
                    .foregroundColor(.white.opacity(0.6))
                }
                Spacer()
            }
        }
    }
}

// the actual widget
struct DS_Student_Task_Tracker_Widget: Widget {
    let kind: String = "DS_Student_Task_Tracker_Widget"
    
    // configs -> static is unconfigruable view for use, internet config is customizable by user
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: SelectJobIntent.self,
            provider: Provider()
        ) { entry in
            DS_Student_Task_Tracker_WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Student Task Tracker")
        .description("This is a list to remind you of your daily tasks to complete! Remember, this isn't all-encompassing it's just a simple reminder!")
        .supportedFamilies([.systemLarge, .systemExtraLarge])
        .contentMarginsDisabled() // gets rid of the weird border issue
    }
}
