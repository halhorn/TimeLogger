//
//  TaskGroup.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import Foundation

enum TaskGroupProperty {
    case GroupId
    case Name
}

protocol ITaskGroupDelegate : class {
    func didTaskGroupUpdate(propertyName : TaskGroupProperty, taskGroup : TaskGroup)
}

class TaskGroup : Equatable {
    var groupId : Int
    var name : String {
        didSet (value) {
            self.delegate?.didTaskGroupUpdate(.Name, taskGroup: self)
        }
    }
    
    weak var delegate : ITaskGroupDelegate?

    init(groupId : Int, name : String) {
        self.groupId = groupId
        self.name = name
    }
}

func == (left : TaskGroup, right: TaskGroup) -> Bool {
    return left.groupId == right.groupId
}

func != (left : TaskGroup, right: TaskGroup) -> Bool {
    return !(left == right)
}
