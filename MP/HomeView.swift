//
//  HomeView.swift
//  MP
//
//  Created by Aamer Essa on 08/12/2022.
//

import UIKit

class HomeView: UIViewController {

    
    var tvShosws = ["game of thrones","rick and morty"]
    var anime = ["Shin Kidou Senki","naruto","Kidou Senshi Gundam"]
    var pointer = Int()
    @IBOutlet weak var tvShowsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvShowsCollection.delegate = self
        tvShowsCollection.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func onclickType(_ sender: UIButton) {
        
        if sender.tag == 1 {
            pointer = sender.tag
            tvShowsCollection.reloadData()
        } else {
            pointer = sender.tag
            tvShowsCollection.reloadData()
        }
    }
    
}


extension HomeView: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if pointer == 1 {
            return anime.count
        }
        else{
            return tvShosws.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if pointer == 1 {
            let cell = tvShowsCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! tvShowsCollectionViewCell
            cell.tvShowImage.image = UIImage(named: anime[indexPath.row])
            cell.tvShowImage.layer.cornerRadius = 30
            return cell
        } else {
            let cell = tvShowsCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! tvShowsCollectionViewCell
            cell.tvShowImage.image = UIImage(named: tvShosws[indexPath.row])
            cell.tvShowImage.layer.cornerRadius = 30
            
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 && pointer == 0 {
           print("thronesView")
            let stroryBoard = UIStoryboard(name: "Main", bundle: nil)
            let rickAndMortyView = stroryBoard.instantiateViewController(withIdentifier: "thronesView")
            rickAndMortyView.modalPresentationStyle = .custom
            present(rickAndMortyView, animated: true)
        }
        
        if indexPath.row == 1 && pointer == 0 {
            let stroryBoard = UIStoryboard(name: "Main", bundle: nil)
            let rickAndMortyView = stroryBoard.instantiateViewController(withIdentifier: "RickAndMorty")
            rickAndMortyView.modalPresentationStyle = .fullScreen
            present(rickAndMortyView, animated: true)
        }
        
        if indexPath.row == 0 && pointer == 1 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let animeView = storyBoard.instantiateViewController(withIdentifier: "animeCharacterView") as! animeCharacterView
            animeView.animeID = "90"
            animeView.anime_name = "Shin Kidou Senki"
            animeView.modalPresentationStyle = .fullScreen
            present(animeView, animated: true)
            
        }
        
        if indexPath.row == 1 && pointer == 1 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let animeView = storyBoard.instantiateViewController(withIdentifier: "animeCharacterView") as! animeCharacterView
            animeView.animeID = "20"
            animeView.anime_name = "Naruto"
            animeView.modalPresentationStyle = .fullScreen
            present(animeView, animated: true)
            
        }
        
        if indexPath.row == 2 && pointer == 1 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let animeView = storyBoard.instantiateViewController(withIdentifier: "animeCharacterView") as! animeCharacterView
            animeView.animeID = "80"
            animeView.anime_name = "Kidou Senshi Gundam"
            animeView.modalPresentationStyle = .fullScreen
            present(animeView, animated: true)
            
        }
    }
    
    
    
}
