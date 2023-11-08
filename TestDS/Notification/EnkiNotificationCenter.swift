//
//  EnkiNotificationCenter.swift
//  TestDS
//
//  Created by FREDERIC ASTIC on 24/10/2023.
//

import Foundation

enum EnkiNotification: String {

    case refreshHomes
    case refreshRooms
}

extension EnkiNotification {
    var name: String {
        return "\(self.rawValue)Notification"
    }
}

extension Notification.Name {
    init(enkiNotification: EnkiNotification) {
        self = Notification.Name(enkiNotification.name)
    }
}

class EnkiNotificationCenter {

    private static let notificationCenter = NotificationCenter.default

    private init() { }

    static func post(_ enkiNotification: EnkiNotification, object: Any? = nil) {
        notificationCenter.post(
            name: Notification.Name(
                enkiNotification: enkiNotification
            ),
            object: object
        )
    }

    static func publisher(_ enkiNotification: EnkiNotification) -> NotificationCenter.Publisher {
        return notificationCenter.publisher(
            for: Notification.Name(
                enkiNotification: enkiNotification
            )
        )
    }
}
