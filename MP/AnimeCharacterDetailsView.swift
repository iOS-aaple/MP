//
//  AnimeDetailsView.swift
//  MP
//
//  Created by Aamer Essa on 10/12/2022.
//

import UIKit

class AnimeCharacterDetailsView: UIViewController {

    @IBOutlet weak var NickNameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    var animeData:AnimeCharactersData?
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var name: UILabel!
    var characterID = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.jikan.moe/v4/characters/\(characterID)/full")
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            let decoder = JSONDecoder()
            
            do{
                let chart = try decoder.decode(FullAnimeCharactersData.self, from: data!)
                self.animeData = chart.data
                
                
                
            }catch {
                print("\(error)")
            }
            DispatchQueue.main.async {
                let imageUrl = URL(string: self.animeData!.images.jpg.image_url)
                let imageNotExist = URL(string: "https://i.ytimg.com/vi/q41AIk3gPKQ/hqdefault.jpg")
                self.name.text = self.animeData!.name ?? "Null"
                self.about.text = self.animeData!.about ?? "Null"
                
                if self.animeData?.nicknames.count == 0 {
                    self.nickname.text = ""
                    self.NickNameLabel.isHidden = true
                } else {
                    self.nickname.text = self.animeData!.nicknames[0]
                }
                if self.animeData!.images.jpg.image_url == "" {
                    self.image.kf.setImage(with: imageNotExist)
                } else{
                    self.image.kf.setImage(with: imageUrl)
                }
               
                
            }
            
        }
        dataTask.resume()
        name.text = ""
        about.text = ""
        nickname.text = ""
        
      

    }
    

}
