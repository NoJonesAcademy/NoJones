//
//  InfoCollectionTableViewCell.swift
//  NoJones
//
//  Created by Mateus Nobre Ferreira on 05/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit


class InfoCollectionTableViewCell: UITableViewCell {

    let cellIdentifier = "InfoCollectionTableViewCell"
    
    @IBOutlet weak var infoCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoCollectionView.register(InfoCollectionViewCell.nib(), forCellWithReuseIdentifier: "InfoCollectionCell")
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
        
        //infoCollectionView
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension InfoCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: InfoCollectionViewCell
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionCell", for: indexPath) as! InfoCollectionViewCell
        cell.configure(image: #imageLiteral(resourceName: "achievement3-enable"), text: "Esta funcionando bem agora ")
        
        switch indexPath.item {
        case 0:
            cell.configure(image: #imageLiteral(resourceName: "roendoUnhas"), text: "Hábito x Tique")
        case 1:
            cell.configure(image: #imageLiteral(resourceName: "tourette"), text: "Síndrome de Tourette")
        case 2:
            cell.configure(image: #imageLiteral(resourceName: "reversao"), text: "Reversão de Hábitos")
        case 3:
            cell.configure(image: #imageLiteral(resourceName: "terapeuta"), text: "Análise Funcional")
            
        default:
            break
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.layer.frame.width / 2 - 10
        let cellHeight = collectionView.layer.frame.height / 2 - 5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
