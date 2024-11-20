//
//  SelectJobIntent.swift
//  DS_Student_Task_Tracker
//
//  Created by Logan Kotke on 11/15/24.
//

import AppIntents
import SwiftUI

struct JobDetail: Identifiable, AppEntity{
    var id: String
    var tasks: [String]
    //var color: Color
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Job Type"
    static var defaultQuery = WidgetColorQuery()
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    
    //Mocked Data
    static let allJobs: [JobDetail] = [
        JobDetail(id: "Student", tasks: [
            " - Check Outlook Calendar Appointments",
            " - Verify Your Schedule In W2W",
            " - Check Your Owned Incidents In Neurons",
            " - Check Microsoft Teams Chats & Teams",
            " - Check Unread Incidents In Neurons",
            " - Check Email",
            " - Check The Workbench",
            " - Check For Any New Mail (New Deployments)"
        ]),
        JobDetail(id: "Student Supervisor", tasks: [
            " - Check Outlook Calendar Appointments",
            " - Verify Your Schedule In W2W",
            " - Check Email",
            " - Check Microsoft Teams Chats & Teams",
            " - Adjust Students' Schedules As Needed",
            " - Check Your Students' Incidents In Neurons",
            " - Check Your Owned Incidents In Neurons",
            " - Check The Workbench",
            " - Check Unread Incidents In Neurons",
            " - Check For Any New Mail (New Deployments)"
        ]),
        JobDetail(id: "FTE", tasks: [
            " - Just Vibe"
        ]),
    ]
}

struct WidgetColorQuery: EntityQuery{
    func entities(for identifiers: [JobDetail.ID]) async throws -> [JobDetail] {
        JobDetail.allJobs.filter{
            identifiers.contains($0.id)
        }
    }
    
    func suggestedEntities() async throws -> [JobDetail] {
        JobDetail.allJobs
    }
    
    func defaultResult() async -> JobDetail? {
        JobDetail.allJobs.first
    }
}


struct SelectJobIntent: WidgetConfigurationIntent{
    static var title: LocalizedStringResource = "Choose Your Character"
    static var description: IntentDescription = IntentDescription("Choose your job role.")
    
    @Parameter(title: "Choose Your Character")
    var job: JobDetail
}
