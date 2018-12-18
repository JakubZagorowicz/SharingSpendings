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
    
    static func BuildNewMeetingModule(router: Mothership) -> NewMeetingModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewMeetingModuleViewController") as! NewMeetingModuleViewController
        let presenter = NewMeetingModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        
        return viewController
    }
    
    static func BuildMeetingsModule(router: Mothership) -> MeetingsModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingsModuleViewController") as! MeetingsModuleViewController
        let presenter = MeetingsModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        
        return viewController
    }
    
    static func BuildMeetingManagmentModule(router: Mothership, meeting: Meeting) -> MeetingManagementModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingManagmentModuleViewController") as! MeetingManagementModuleViewController
        let presenter = MeetingManagementModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        
        return viewController
    }
    
    static func BuildNewItemModule(router: Mothership, meeting: Meeting) -> NewItemModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewItemModuleViewController") as! NewItemModuleViewController
        let presenter = NewItemModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        
        return viewController
    }
    static func BuildNewItemModule(router: Mothership, item: Item, meeting: Meeting) -> NewItemModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewItemModuleViewController") as! NewItemModuleViewController
        let presenter = NewItemModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        presenter.item = item
        
        return viewController
    }
    
    static func BuildNewPersonModule(router: Mothership, meeting: Meeting) -> NewPersonModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPersonModuleViewController") as! NewPersonModuleViewController
        let presenter = NewPersonModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        
        return viewController
    }
    
    static func BuildNewPersonModule(router: Mothership, person: Person, meeting: Meeting) -> NewPersonModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPersonModuleViewController") as! NewPersonModuleViewController
        let presenter = NewPersonModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.person = person
        presenter.meeting = meeting
        
        return viewController
    }
    
    static func BuildMeetingSettlementModule(router: Mothership, meeting: Meeting) -> MeetingSettlementModuleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingSettlementModuleViewController") as! MeetingSettlementModuleViewController
        let presenter = MeetingSettlementModulePresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        
        return viewController
    }
}
