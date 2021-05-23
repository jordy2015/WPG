//
//  UserDetailsTableViewController.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//

import UIKit
import AlamofireImage

class UserDetailsTableViewController: UITableViewController {
    
    var user: UserProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "User Details"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "default")
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = user?.getUserName()
            cell.detailTextLabel?.text = "Name"
            if let url = URL(string: user?.getProfileImageUrl() ?? "") {
                cell.imageView?.af.setImage(withURL: url, cacheKey: user?.getId(), placeholderImage: UIImage(named: "placeholder"))
            }
        case 1:
            cell.textLabel?.text = user?.getPortfolioUrl()
            cell.detailTextLabel?.text = "Portfolio Url"
            cell.imageView?.image = nil
        case 2:
            cell.textLabel?.text = "\(user?.getTotalPhotos() ?? 0)"
            cell.detailTextLabel?.text = "Total Photos"
            cell.imageView?.image = nil
        default: break
        }

        return cell
    }

}
