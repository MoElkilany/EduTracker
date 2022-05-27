//
//  BaseViewController.swift
//  EduTracker
//
//  Created by Mohamed Elkilany on 17/05/2022.
//

import RxSwift
import UIKit
import StatefulViewController
import SwiftMessages
import PanModal

class BaseViewController: UIViewController, StatefulViewController {
    
    var contentCount = 5
    var documentInteractionController: UIDocumentInteractionController?
    
    private var onTimeCall = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupInitialViewState()
        onTimeCalling()
    }
    
    private func onTimeCalling() {
        if onTimeCall == false {
            onTimeCall = true
            self.viewWillAppearOnTimeCalling()
        }
    }
    
    func viewWillAppearOnTimeCalling() {}
    func configureUI() {}
    func configureData() {}
    
    func hasContent() -> Bool {
        return contentCount > 0
    }
    
    func registerCell(id: String, tableView: UITableView) {
        let nib = UINib(nibName: id, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: id)
    }
    
    func registerCollectionCell(id: String, collectionView: UICollectionView) {
        let nib = UINib(nibName: id, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: id)
    }
    
    
    func dismiss(completion: (() -> Void)? = nil){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: completion)
    }
    
}
