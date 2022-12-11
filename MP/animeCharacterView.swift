//
//  animeCharacterView.swift
//  MP
//
//  Created by Aamer Essa on 10/12/2022.
//

import UIKit

class animeCharacterView: UIViewController {
    
    @IBOutlet weak var searchTerm: UITextField!
    @IBOutlet weak var animeCharterCollection: UICollectionView!
    @IBOutlet weak var searchBtn: UIButton!
    var showSearchResult = false
    var animeCharacterList = [Characters]()
    var searchResult = [Characters]()
    var animeCharacter:AnimeCharacters?
    var animeID = String()
    var anime_name = String()
    @IBOutlet weak var animeName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeCharterCollection.delegate = self
        animeCharterCollection.dataSource = self
        animeCharterCollection.backgroundColor = .black
        animeName.text = anime_name 
         
        let url = URL(string: "https://api.jikan.moe/v4/anime/\(animeID)/characters")
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) {data, response, error in
            
            let decoder = JSONDecoder()
                do{
                    self.animeCharacter = try decoder.decode(AnimeCharacters.self, from: data!)
                    self.animeCharacterList = self.animeCharacter!.data
                    print(self.animeCharacterList.count)
                
                }catch{
                    print("\(error)")
                }
                DispatchQueue.main.async {
                    self.animeCharterCollection.reloadData()
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
    
    
    @IBAction func obClickSearchBtn(_ sender: UIButton) {
        
        if !showSearchResult {
            print("Search")
            searchBtn.setTitle("Cancel", for: .normal)
            searchBtn.tintColor = .red
            for character in animeCharacterList {
                if character.character.name == searchTerm.text {
                    searchResult.append(character)
                }
            }
            animeCharterCollection.reloadData()
            showSearchResult = true
        }
        else {
            searchBtn.setTitle("Search", for: .normal)
            searchTerm.text = ""
            searchBtn.tintColor = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00)
            showSearchResult = false
            searchResult.removeAll()
            animeCharterCollection.reloadData()
            
        }
    }
    
    

}

extension animeCharacterView:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if showSearchResult {
                return searchResult.count
            } else{
                
                return animeCharacterList.count
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if showSearchResult {
            let cell = animeCharterCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AnimeCollectionViewCell
            let imageURL = URL(string: searchResult[indexPath.row].character.images.jpg.image_url)
            cell.cahracterName.text = searchResult[indexPath.row].character.name
            cell.cahracterImage.kf.setImage(with: imageURL)
            cell.chracterContiner.backgroundColor = UIColor(white: 1, alpha: 0.2)
            cell.layer.cornerRadius = 20
            return cell
            
        } else{
            let cell = animeCharterCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AnimeCollectionViewCell
            let imageURL = URL(string: animeCharacterList[indexPath.row].character.images.jpg.image_url)
            cell.cahracterName.text = animeCharacterList[indexPath.row].character.name
            cell.cahracterImage.kf.setImage(with: imageURL)
            cell.chracterContiner.backgroundColor = UIColor(white: 1, alpha: 0.2)
            cell.layer.cornerRadius = 20
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let animeCharacterDetailsView = storyBoard.instantiateViewController(withIdentifier: "AnimeCharacterDetailsView") as! AnimeCharacterDetailsView
        if showSearchResult{
            animeCharacterDetailsView.characterID = searchResult[indexPath.row].character.mal_id
        }
        else{
            animeCharacterDetailsView.characterID = animeCharacterList[indexPath.row].character.mal_id
        }
        
        animeCharacterDetailsView.modalPresentationStyle = .formSheet
        present(animeCharacterDetailsView, animated: true)
    }
    
    
}
