//
//  AddMealViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/9.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class AddMealViewController: UIViewController, TagEditViewDelegate, SelectionEditViewDelegate {

    @IBOutlet var selectionEditView: SelectionEditView!
    @IBOutlet var tagEditView: TagEditView!
    
    var selectionTitles = ["Breakfast", "Lunch", "Dinner", "Night", "Afternoon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectionEditView.selectionTitles = self.selectionTitles
        
        
        tagEditView.tagTitles = ["this is a dynamic answer that should work", "Best", "Veg", " answer that should",  "Apple", "Diet", "Must Every Week", "大块肉", "尖椒土豆丝", "蝙蝠侠大战超人", "家乡捞单呢吗这位您的二位"]
        

        selectionEditView.delegate = self
        tagEditView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectionEditView.reloadData()
        tagEditView.reloadData()
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TagEditViewDelegate
    
    func didAddTag(title: String) {
        // TODO: add the tag to list
        print("Added tag:", title)
    }
    
    func didRemoveTag(title: String) {
        // TODO: remove the tag from list
        print("Removed tag:", title)
    }
    
    // MAKR: SelectionEditViewDelegate
    func didSelectItem(index: Int) {
        print("Did select index:", index)
    }
    
    func didDeselectItem(index: Int) {
        print("Did deselect index:", index)
    }
    
}
