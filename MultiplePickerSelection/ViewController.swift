//
//  ViewController.swift
//  MultiplePickerSelection
//
//  Created by volive solutions on 31/08/19.
//  Copyright © 2019 volive solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    
    var dataSource1 = ["RU", "ES", "ENG","Rami","Ongole","KADAPA","JAGAN"]
    var dataSource2 = [String]()
    var dict = ["RU": ["Спартак", "ЦСКА", "Динамо"], "ES": ["Real Madrid", "Barcelona", "Valencia", "Sevilla"], "ENG": ["Arsenal", "Chelsea", "MU", "MC", "Liverpool"]]
    
    //selectedValues
    var selectedArray = [String]()
    //index selected row in component
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getData(row: 0)
        
        //set Up Tap Gesture
        let tapGestureRecognaizer = UITapGestureRecognizer(target: self, action: #selector(pickerTapp))
        tapGestureRecognaizer.delegate = self
        tapGestureRecognaizer.numberOfTapsRequired = 1
        self.pickerView.addGestureRecognizer(tapGestureRecognaizer)
    }
    
    @objc func pickerTapp(tapGesture: UITapGestureRecognizer) {
        
        if tapGesture.state == .ended {
            // looking for frame selection row
            let selectedItem = dataSource1[pickerView.selectedRow(inComponent: 0)]
            let rowHeight = self.pickerView.rowSize(forComponent: 0).height
            let rowWidth = self.pickerView.rowSize(forComponent: 0).width
            let selectRowFrame = CGRect(x: CGFloat(Int(self.pickerView.frame.width)), y: (self.pickerView.frame.height - rowHeight) / 2, width: rowWidth, height: rowHeight)
            
            let userTappedOnSelectedRow = selectRowFrame.contains(tapGesture.location(in: self.pickerView))
            // if tap to selection row ....
            
            
            print("user tapped",selectedItem)
            
           // if userTappedOnSelectedRow {
                if selectedArray.contains(selectedItem) {
                    var index = 0
                    for item in selectedArray {
                        if item == selectedItem {
                            selectedArray.remove(at: index)
                            
                        } else {
                            index += 1
                        }
                    }
                } else {
                   
                    selectedArray.append(selectedItem)
                      print("user tappeds selection",selectedArray.count)
                }
          //  }
            
            //reload Data
            self.pickerView.dataSource = self
            self.pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            self.pickerView(self.pickerView, didSelectRow: selectedRow, inComponent: 0)
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
            return dataSource1.count
       
    
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString()
        
       
            let string = self.dataSource1[row]
            let attrString = NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            attributedString.append(attrString)
            print("selected array count ",selectedArray.count)
            // add image to atributed string if isSelected true
            for item in selectedArray {
                if item == string {
                    attributedString.append(NSAttributedString(string: " "))
                    let imageAtchement = NSTextAttachment()
                    imageAtchement.image = UIImage(named: "checkmark.png")
                    imageAtchement.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
                    let imageAttachString = NSAttributedString(attachment: imageAtchement)
                    attributedString.append(imageAttachString)
                }
            }
        
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      print("did select row",row)
            selectedRow = row
        
        
         self.pickerView.reloadAllComponents()
       // getData(row: row)
    }
    
    func getData(row: Int) {
        self.dataSource1 = dict[dataSource1[row]] ?? [String]()
        self.pickerView.reloadAllComponents()
        
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


