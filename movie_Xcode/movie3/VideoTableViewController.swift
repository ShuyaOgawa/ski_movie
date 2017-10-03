//
//  VideoTableViewController.swift
//  movie3
//
//  Created by 小川秀哉 on 2017/09/28.
//  Copyright © 2017年 Digital Circus Inc. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireImage


class VideoTableViewController: UITableViewController {
    
    @IBOutlet var tableview: UITableView!


    var videofiles: [JSON] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        self.refreshControl = refreshControl
        let listUrl = "http://localhost:3000/articles.json";
        Alamofire.request(listUrl).responseJSON{ response in
            let json = JSON(response.result.value ?? 0)
            json.forEach{(arg) in
                
                let (_, data) = arg
                self.videofiles.append(data)
            }
            self.tableView.reloadData()

        
        
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videofiles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoViewCell", for: indexPath) as! VideoViewCell
        
        cell.title.text = videofiles[indexPath.row]["title"].string
//        cell.dates.text = videofiles[indexPath.row]["updated_at"].stringValue
//       cell.photo.image = UIImage(named: videofiles[indexPath.row]["video"]["screenshot"].stringValue)
        
        
        let imgUrlString: String = "http://localhost:3000\(videofiles[indexPath.row]["video"]["screenshot"]["url"].string!)"
       
        let imgUrl: NSURL = NSURL(string: imgUrlString)!
       
        //URLの情報を取得
       
        let file: Data = try! Data(contentsOf: imgUrl as URL)

        //画像データに変換
        let img = UIImage(data: file as Data)
        
        cell.photo.image = img
      
    
        cell.photo.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(playMovieFromProjectBundle))
        cell.photo.addGestureRecognizer(tap)
            
        
        return cell
    }
    
    
 
    @objc func playMovieFromProjectBundle(gestureRecognizer: UIGestureRecognizer) {
        
        let tappedLocation = gestureRecognizer.location(in: tableView)
        let tappedIndexPath = tableView.indexPathForRow(at: tappedLocation)
        let tappedRow = tappedIndexPath?.row

        if  let videoUrlString: String = "http://localhost:3000\(videofiles[tappedRow!]["video"]["url"].string!)"{
        
            let videoUrl: NSURL = NSURL(string: videoUrlString)!
            let videoPlayer = AVPlayer(url: videoUrl as URL)

            // 動画プレイヤーの用意
            let playerController = AVPlayerViewController()
            playerController.player = videoPlayer
            self.present(playerController, animated: true, completion: {
                videoPlayer.play()
            })
        } else {
            print("no such file")
        }

        
    }

    

    
  
    
    
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /*
    override func viewWillAppear(_ animated: Bool) {
        refreshData()
    }

    
    func refreshData() {
       
        self.refreshControl = refreshControl
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
       
    }
 */


}
