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
    @IBOutlet var scrollView: UIScrollView!
    var selectedIndex = [Int]()
    var selectionTitles = ["Breakfast", "Lunch", "Dinner"]
    var tagTitles = ["this is a dynamic answer that should work", "Best", "Veg", " answer that should",  "Apple", "Diet", "Must Every Week", "大块肉", "尖椒土豆丝", "蝙蝠侠大战超人", "家乡捞单呢吗这位您的二位"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectionEditView.selectionTitles = self.selectionTitles
        tagEditView.tagTitles = self.tagTitles
        
        selectionEditView.delegate = self
        tagEditView.delegate = self
        
        selectionEditView.reloadData()
        tagEditView.reloadData()
        
        resizeScrollViewContentSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private methods
    private func resizeScrollViewContentSize() {
        var unionRect = CGRect.zero
        for subview in self.view.subviews {
            unionRect = unionRect.union(subview.frame)
        }
        self.scrollView.contentSize = unionRect.size
    }
    
    // MARK: TagEditViewDelegate
    
    func didAddTag(title: String) {
        self.tagTitles.append(title)
    }
    
    func didRemoveTag(title: String) {
        if let index = tagTitles.index(of: title) {
            tagTitles.remove(at: index)
        }
    }
    
    // MAKR: SelectionEditViewDelegate
    func didSelectItem(index: Int) {
        selectedIndex.append(index)
    }
    
    func didDeselectItem(index: Int) {
        if let removedItemIndex = selectedIndex.index(of: index) {
            selectedIndex.remove(at: removedItemIndex)
        }
    }
    
}
