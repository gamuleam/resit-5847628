//
//  noteTableViewCell.swift
//  Easy Notes
//
//  Created by Laurentiu Gamulea on 01/07/2018.
//  Copyright © 2018 Laurentiu Gamulea. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        shadowView.layer.shadowRadius = 1.5
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.cornerRadius = 2
        
        noteImageView.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(note: Note) {
        self.noteTitleLabel.text = note.noteTitle?.uppercased()
        self.descriptionLabel.text = note.noteDescription
        
        self.noteImageView.image = UIImage(data: note.noteImage! as Data)
    }
    
    /*func editCell(note: Note) {
        self.noteTitleLabel.text = note.noteTitle
        self.descriptionLabel.text = note.noteDescription
        
        self.noteImageView.image = UIImage(data: note.noteImage! as Data)
    }*/
    

}
