//
//  ViewController.swift
//  MP
//
//  Created by admin on 12/7/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var characters:RickAndMortyCharacters?
    var charactersList = [RickAndMortyCharacter]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black 
        
        let url = URL(string: "https://rickandmortyapi.com/api/character")
                
                
                let session = URLSession.shared
                
                let dataTask = session.dataTask(with: url!) { data, response, error in
                    let decoder = JSONDecoder()
                    
                    do{
                        self.characters = try decoder.decode(RickAndMortyCharacters.self, from: data!)
                        self.charactersList = self.characters!.results
                        
                        print(self.charactersList)
                    }catch {
                        print("\(error)")
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    }
                
                dataTask.resume()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer)
    {
        if sender.direction == .right
        {
            dismiss(animated: true)
        }}
    
    


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! myCollectionViewCell
        cell.titel.text = charactersList[indexPath.row].name
        let url = URL(string: charactersList[indexPath.row].image)
        cell.movieImage.kf.setImage(with: url)
        cell.movieView.backgroundColor = UIColor(white: 1, alpha: 0.2)
        cell.movieView.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = storyboard?.instantiateViewController(withIdentifier: "details") as! movieDetailsViewController
        let data = charactersList[indexPath.row]
    
        sb.name = data.name
        sb.type = data.type
        print("type == \(data.type)")
        sb.image = data.image
        sb.gender = data.gender
        sb.statues = data.status
        sb.species = data.species
        sb.modalPresentationStyle = .formSheet
        present(sb, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (view.frame.size.width/2)-4, height: (view.frame.size.height/5)-4)
           }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 3.0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }

    
    
    
    
}


