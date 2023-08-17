//
//  ViewController.swift
//  Task-APi-Intergration-POST-3
//
//  Created by Ananth Nair on 17/08/23.
//

import UIKit

class ViewController: UIViewController {

    
    var jsonData : Root?
//var jsonAnotherData : vehicleInfo?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVariantsResponse()
        // Do any additional setup after loading the view.
    }
    //MARK: - Response Function
    
    
    func getVariantsResponse(){
        let url = "https://kuwycredit.in/servlet/rest/ltv/forecast/ltvLoc"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var param : [String:Any] = ["year":"2020","make":"RENAULT","model":"KWID","variant":"1.0 RXL"]
        
        do{
            request.httpBody =  try JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions())
            let task = URLSession.shared.dataTask(with: request as URLRequest ,completionHandler: {(data, response, error) in
                
                // response
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print("statusCode ----->>>> \(statusCode)")
                    
                }
                // error
                if let error = error {
                    print(error)
                }
                // data
                if let data = data {
                    do {
                        let content = try? JSONDecoder().decode(Root.self, from: data)
                        self.jsonData = content
                        print(content as Any)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            })
            task.resume()
            
            
        } catch {
            print("somting is went wrong ")
            
            
            
        }
    }


}

extension ViewController : UITableViewDelegate {
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData?.locationList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vc = tableView.dequeueReusableCell(withIdentifier: "cell") as! SecondTableViewCell
        
        vc.textlabel123.text = jsonData?.locationList[indexPath.row]
        vc.modelLabel?.text = jsonData?.vehicleInfo?.model
        vc.makeLabel.text = jsonData?.vehicleInfo?.make
        vc.yearLabel.text = jsonData?.vehicleInfo?.year?.description
        return vc
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

}

