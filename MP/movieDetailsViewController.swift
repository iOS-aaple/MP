//
//  movieDetailsViewController.swift
//  MP
//
//  Created by admin on 12/7/22.
//

import UIKit

class movieDetailsViewController: UIViewController {

    @IBOutlet weak var stautsL: UILabel!
    @IBOutlet weak var MImage: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var typeL: UILabel!
    @IBOutlet weak var speciesL: UILabel!
    @IBOutlet weak var genderL: UILabel!
    
   
    @IBOutlet weak var typeTitel: UILabel!
    var name = String()
    var type = String()
    var statues = String()
    var gender = String()
    var species = String()
    var image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    private func setUI(){
        
        if type == "" {
            typeL.isHidden = true
            typeTitel.isHidden = true
        
        }else{
            typeL.text = type
        }
        nameL.text = name
        stautsL.text = statues
        speciesL.text = species
        genderL.text = gender
        MImage.layer.cornerRadius = 20
        
        let url = URL(string: image)
        MImage.kf.setImage(with: url)
       // MImage.image = UIImage(named: image)
        
    }
    

   

}
