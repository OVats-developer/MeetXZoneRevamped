//
//  CustomPicker.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 04/09/2022.
//

import Foundation
import SwiftUI

struct CustomPicker:UIViewRepresentable {
    
    typealias UIViewType = UIPickerView
    
    @Binding var hour:Int
    @Binding var minute:Int
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        picker.selectRow(hour, inComponent: 0, animated: true)
        switch minute {
        case 0:
            picker.selectRow(0, inComponent: 1, animated: true)
        case 15:
            picker.selectRow(1, inComponent: 1, animated: true)
        case 30:
            picker.selectRow(2, inComponent: 1, animated: true)
        case 45:
            picker.selectRow(3, inComponent: 1, animated: true)
        default:
            picker.selectRow(0, inComponent: 1, animated: true)
        }
        return picker
    }
    
    func makeCoordinator() -> CustomPickerCoordinator {
        return .init(owner: self)
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {}
}

class CustomPickerCoordinator:NSObject, UIPickerViewDelegate, UIPickerViewDataSource
{
    var owner:CustomPicker
    
    init(owner:CustomPicker)
    {
        self.owner = owner
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {return 24}
        else {return 4}
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        withAnimation {
            if (component == 0) {owner.hour = row}
            else
            {
                if (row == 0) {owner.minute = 0}
                if (row == 1) {owner.minute = 15}
                if (row == 2) {owner.minute = 30}
                else  {owner.minute = 45}
                
            }
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            if (row < 10) {return "0\(row)"}
            return "\(row)"
        }
        else {
            if (row == 0) {return "00"}
            if (row == 1) {return "15"}
            if (row == 2) {return "30"}
            else  {return "45"}
        }
    }
    
}


struct CustomPicker_preview:PreviewProvider {
    
    static var previews: some View {
        CustomPicker(hour: .constant(2), minute: .constant(15))
    }
}
