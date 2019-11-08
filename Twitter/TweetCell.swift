//
//  TweetCell.swift
//  Twitter
//
//  Created by Dinaol Melak on 11/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var retweeted: Bool = false
    var favorited:Bool = false
    var tweetId:Int = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func didTapfav(_ sender: Any) {
        let toBeFavorited = !favorited
        if toBeFavorited{
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        }else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("unfavorite did not succeed: \(Error)")
            })
        }
    }
    @IBAction func didTapRetweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error in retweeting: \(Error)")
        })
    }
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweetButton.isEnabled = false
        }   else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            retweetButton.isEnabled = false
        }
    }
    func setFavorite(_ isFavoritedBool: Bool){
        favorited  = isFavoritedBool
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
