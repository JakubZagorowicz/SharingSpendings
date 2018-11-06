//
//  Builder.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class Builder {
    static func BuildMainModule(router: Mothership) -> MainModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainModuleViewController") as! MainModuleViewController
        let presenter = MainModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        
        return viewController
    }
    
    static func BuildNewMeetingModule(router: Mothership, dataController: DataController) -> NewMeetingModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewMeetingModuleViewController") as! NewMeetingModuleViewController
        let presenter = NewMeetingModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.dataController = dataController
        
        return viewController
    }
    
    static func BuildMeetingsModule(router: Mothership, dataController: DataController) -> MeetingsModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingsModuleViewController") as! MeetingsModuleViewController
        let presenter = MeetingsModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.dataController = dataController
        
        return viewController
    }
    
    static func BuildLoginModule(router: Mothership) -> LoginModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginModuleViewController") as! LoginModuleViewController
        let presenter = LoginModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        
        return viewController
    }
    
    static func BuildMeetingManagmentModule(router: Mothership, meeting: Meeting, dataController: DataController) -> MeetingManagementModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingManagmentModuleViewController") as! MeetingManagementModuleViewController
        let presenter = MeetingManagementModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        presenter.dataController = dataController
        
        return viewController
    }
    
    static func BuildNewItemModule(router: Mothership, dataController: DataController, people: [Person], meeting: Meeting) -> NewItemModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewItemModuleViewController") as! NewItemModuleViewController
        let presenter = NewItemModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.people = people
        presenter.dataController = dataController
        
        return viewController
    }
    static func BuildNewItemModule(router: Mothership, dataController: DataController, people: [Person], item: Item, meeting: Meeting) -> NewItemModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewItemModuleViewController") as! NewItemModuleViewController
        let presenter = NewItemModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.dataController = dataController
        presenter.people = people
        presenter.item = item
        
        return viewController
    }
    
    static func BuildNewPersonModule(router: Mothership, dataController: DataController, meeting: Meeting) -> NewPersonModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPersonModuleViewController") as! NewPersonModuleViewController
        let presenter = NewPersonModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.dataController = dataController
        presenter.meeting = meeting
        
        return viewController
    }
    
    static func BuildNewPersonModule(router: Mothership, dataController: DataController, person: Person, meeting: Meeting) -> NewPersonModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPersonModuleViewController") as! NewPersonModuleViewController
        let presenter = NewPersonModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.person = person
        presenter.dataController = dataController
        presenter.meeting = meeting
        
        return viewController
    }
    
    static func BuildMeetingSettlementModule(router: Mothership, dataController: DataController, meeting: Meeting) -> MeetingSettlementModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingSettlementModuleViewController") as! MeetingSettlementModuleViewController
        let presenter = MeetingSettlementModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.dataController = dataController
        presenter.meeting = meeting
        
        return viewController
    }
}
