//
//  ThronseViewController.swift
//  MP
//
//  Created by Aamer Essa on 10/12/2022.
//

import UIKit

class ThronseDetailsCharter: UIViewController {
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var family: UILabel!
    @IBOutlet weak var charterTitle: UILabel!
    @IBOutlet weak var charterImage: UIImageView!
    
    var imageUrl = String()
   var firstname = String()
   var lastname = String()
    var fullname = String()
    var familyCh = String()
    var title_ch = String()
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        let url = URL(string: imageUrl)
        charterImage.kf.setImage(with: url)
        firstName.text = firstname
        lastName.text = lastname
        fullName.text = fullname
        family.text = familyCh
        charterTitle.text = title_ch
        charterImage.layer.cornerRadius = 30.0
        charterImage.layer.masksToBounds = true
    }
    

    

}
