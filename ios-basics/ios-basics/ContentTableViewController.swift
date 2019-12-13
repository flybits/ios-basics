//
//  ContentTableViewController.swift
//  ios-basics
//
//  Created by MikeH on 2019-12-06.
//  Copyright © 2019 MikeH. All rights reserved.
//

import UIKit
import FlybitsKernelSDK
import FlybitsSDK
import CoreLocation

class ContentTableViewController: UITableViewController {

    var contentData = [LocationContent]()

    override func viewDidLoad() {
        super.viewDidLoad()

        FlybitsManager.connect(AnonymousIDP(), projectId: "7DE8F413-95FC-4FF9-B1C9-D51ACB4ECDEC") { (user, error) in

            // This object will create a filter looking for content that is labelled grocery. By removing this param and making it nil All content will
            // returned. Change the Grocery value to filter different types or make an array, ["Grocery, "Fitness"] etc, to filter multiple.
//            let query = ContentQuery(contentTypes: ["place": LocationContent.self], labelsQuery: LabelsQuery(predicates: [LabelsPredicate(labels: ["Grocery"], booleanOperator: .and)], booleanOperator: .and), pager: nil)

            // Will return all content. In this case there is no content label filter.
            let query = ContentQuery(contentTypes: ["place": LocationContent.self], labelsQuery: nil, pager: nil)
            query.locationQuery = LocationQuery(key: "address", location: CLLocationCoordinate2D(latitude: 37.76224645239545, longitude: -122.39189772883611), radius: 10000)


            _ = Content.getAllInstances(with: query) { (paged, error) in
                guard let contentElements = paged?.elements else {
                    print("No Elements")
                    return

                }

                contentElements.forEach { (content) in
                    if let pagedData = content.pagedContentData, let first = pagedData.elements.first, let locationData = first as? LocationContent {
                        self.contentData.append(locationData)
                    }
                }

                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }

            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contentData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath)

        cell.textLabel?.text = contentData[indexPath.row].name

        URLSession.shared.dataTask(with: URLRequest(url: contentData[indexPath.row].imgCover!)) { (data, _, error) in
            guard error == nil else {
                assert(false)
            }

            DispatchQueue.main.sync {

                let image = UIImage(data: data!)!
                cell.imageView?.image = image
                cell.imageView?.contentMode = .scaleToFill
                cell.imageView?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

            }
        }.resume()

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
