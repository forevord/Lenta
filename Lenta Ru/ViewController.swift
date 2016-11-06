//
//  ViewController.swift
//  Lenta Ru
//
//  Created by Pavel Salkevich on 05.10.16.
//  Copyright © 2016 Pavel Salkevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDelegate {
    var data: NSMutableData = NSMutableData()
    var info1:String = ""
    var ArrNews:NSMutableArray = []
    var NewsArray = [News]()
    var result1 = Array<News>()

    override func viewDidLoad() {
        super.viewDidLoad()
        ArrNews = []
    // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startConnection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startConnection(){
        let urlPath: String = "https://api.lenta.ru/lists/latest"
        let url: URL = URL(string: urlPath)!
        let request: URLRequest = URLRequest (url: url)
        let connection: NSURLConnection = NSURLConnection (request: request, delegate: self, startImmediately:false)!
        connection.start()
    }
    
    func connection(_ connection: NSURLConnection!, didReceiveData data: Data!){
        self.data.append(data)
    }
    
    func buttonAction(_ sender: UIButton!){
        startConnection()
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection!) {
        var err: NSError
        
        do {
            if
             let jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject]{
            print("----Start---")
             let infoGG = jsonResult["headlines"] as? [[String:AnyObject]]
            for inform in infoGG! {
                    ArrNews.add(inform["info"]!)
                }
             var i = 0
            for _ in ArrNews {
            if (i != 99) {
                i += 1
             var titleArr = ArrNews[i] as! [String:AnyObject]
             let titleTrue = titleArr["title"] as! String
             let idTrue = titleArr["id"] as! String
             let rightcolTrue = titleArr["rightcol"] as! String
             let newsObject = News.init(title: titleTrue, id: idTrue, rightcol: rightcolTrue)
                    self.NewsArray.append(newsObject)
                    self.result1.append(newsObject)
                    }
                }
                print("NewsArray:\(result1)")
                readJSONData(jsonResult)
                print("-------")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func readJSONData(_ object:[String:AnyObject]) {
        guard let _ = object["info"] as? String
            else {return}
        
    }
    
    
    func asynchronousWorkLoading(completion: @escaping (_ inner: @escaping () throws -> [News]) -> Void) -> Void {
        let urlPath: String = "https://api.lenta.ru/lists/latest"
        let url: URL = URL(string: urlPath)!
        let queue = OperationQueue()
        let request: NSURLRequest = NSURLRequest(url: url)
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: queue) {
            (response, data, error) -> Void in
            guard let data = data else { return }
            do {
                if
                    let jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject]{
                    let infoGG = jsonResult["headlines"] as? [[String:AnyObject]]
                    for inform in infoGG! {
                        self.ArrNews.add(inform["info"]!)
                    }
                    var i = 0
                    for _ in self.ArrNews {
                        if (i != 99) {
                            i += 1
                            var titleArr = self.ArrNews[i] as! [String:AnyObject]
                            let titleTrue = titleArr["title"] as! String
                            let idTrue = titleArr["id"] as! String
                            let rightcolTrue = titleArr["rightcol"] as! String
                            let newsObject = News.init(title: titleTrue, id: idTrue, rightcol: rightcolTrue)
                            self.NewsArray.append(newsObject)
                            self.result1.append(newsObject)
                        }
                    }
                    self.readJSONData(jsonResult)
                }
                completion({return self.result1})
                // print(self.result1)
            } catch let error {
                completion({throw error})
            }
        }
    }
    
}

