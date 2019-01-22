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
    
    static func buildNewMeetingModule(router: Mothership) -> NewMeetingViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewMeetingModuleViewController") as! NewMeetingViewController
        let presenter = NewMeetingPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        
        return viewController
    }
    
    static func buildMeetingsModule(router: Mothership) -> MeetingsViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingsModuleViewController") as! MeetingsViewController
        let presenter = MeetingsPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        
        return viewController
    }
    
    static func buildMeetingManagmentModule(router: Mothership, meeting: Meeting) -> MeetingManagementViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingManagmentModuleViewController") as! MeetingManagementViewController
        let presenter = MeetingManagementPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        
        return viewController
    }
    
    static func buildNewItemModule(router: Mothership, meeting: Meeting) -> NewItemViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewItemModuleViewController") as! NewItemViewController
        let presenter = NewItemPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        
        return viewController
    }
    static func buildNewItemModule(router: Mothership, item: Item, meeting: Meeting) -> NewItemViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewItemModuleViewController") as! NewItemViewController
        let presenter = NewItemPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        presenter.item = item
        
        return viewController
    }
    
    static func buildNewPersonModule(router: Mothership, meeting: Meeting) -> NewPersonViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPersonModuleViewController") as! NewPersonViewController
        let presenter = NewPersonPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.meeting = meeting
        
        return viewController
    }
    
    static func buildNewPersonModule(router: Mothership, person: Person, meeting: Meeting) -> NewPersonViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPersonModuleViewController") as! NewPersonViewController
        let presenter = NewPersonPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.person = person
        presenter.meeting = meeting
        
        return viewController
    }
}
