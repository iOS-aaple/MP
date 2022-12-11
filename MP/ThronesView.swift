//
//  ThronesView.swift
//  MP
//
//  Created by Aamer Essa on 10/12/2022.
//

import UIKit
import Kingfisher
class ThronesView: UIViewController {
    
    
    @IBOutlet weak var thronesCollection: UICollectionView!
    var thronse = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thronesCollection.dataSource = self
        thronesCollection.delegate = self

        StarWarsModel.getAllPeople(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
            data, response, error in
                do {
                    // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                    
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                        if let results = jsonResult as? NSArray {
                                                   for charcter in results {
                                                       
                                                       let characterDict = charcter as! NSDictionary
                                                       self.thronse.append(characterDict)
                                                   }//end for
                                               } // end results
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.thronesCollection.reloadData()
                    }
                } catch {
                    print("Something went wrong")
                }
        })
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        thronesCollection.backgroundColor = .black 
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer)
    {
        if sender.direction == .right
        {
            dismiss(animated: true)
        }}


}

extension ThronesView: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thronse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = thronesCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! thronesCollectionCell
    
        let characterImageUrl = URL(string: thronse[indexPath.row]["imageUrl"] as! String)
        
     
        cell.charcterName.text = "\(thronse[indexPath.row]["fullName"] as! String)"
        cell.charcterImage.kf.setImage(with: characterImageUrl)
        cell.charctFamily.text = "\(thronse[indexPath.row]["family"] as! String)"
        cell.layer.cornerRadius = 20
        cell.charterNameContiner.backgroundColor = UIColor(white: 1, alpha: 0.2)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let thronseDetailsCharterView = storyBoard.instantiateViewController(withIdentifier: "ThronseDetailsCharter") as! ThronseDetailsCharter
        thronseDetailsCharterView.firstname = thronse[indexPath.row]["firstName"] as! String
        thronseDetailsCharterView.lastname = thronse[indexPath.row]["lastName"] as! String
        thronseDetailsCharterView.fullname = thronse[indexPath.row]["fullName"] as! String
        thronseDetailsCharterView.familyCh = thronse[indexPath.row]["family"] as! String
        thronseDetailsCharterView.title_ch = thronse[indexPath.row]["title"] as! String
       
        print(thronse[indexPath.row]["imageUrl"] as! String)
        thronseDetailsCharterView.imageUrl = thronse[indexPath.row]["imageUrl"] as! String
        
        present(thronseDetailsCharterView, animated: true)
    
    }
    
    
}
