//
//  ArtikleViewController.swift
//  germanmem
//
//  Created by Sherif Hamad on 27.09.20.
//  Copyright © 2020 Sherif Hamad. All rights reserved.
//

import UIKit



class ArtikleViewController: UIViewController {

   
    @IBOutlet weak var germanGameLbl: UITextField!
    
    @IBOutlet weak var englishGameLbl: UITextField!
    

    @IBOutlet weak var artikleGameLbl: UILabel!
    
    
    @IBAction func der(_ sender: UIButton) {
        
        if artikleGameLbl.text == "der"{
                  youAreRight()
              }
    }
    
    
    @IBAction func das(_ sender: UIButton) {
        
        if artikleGameLbl.text == "das"{
                 youAreRight()
              }
    }
    
    
    @IBAction func die(_ sender: UIButton) {
        if artikleGameLbl.text == "die"{
            youAreRight()
        }
    }
    
    @IBAction func getRandomWord(_ sender: UIButton) {
        
        artikleGameLbl.isHidden=true;
        fetchingRandomInformation(index: Int.random(in: 1..<1560));
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        artikleGameLbl.isHidden=true;
        // Do any additional setup after loading the view.
    }
    
    
    func youAreRight(){
        
        artikleGameLbl.isHidden=false;
    }
    
    public func fetchingRandomInformation(index: Int){
        
        guard let path = Bundle.main.path(forResource: "B1", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path);
        do{
           let data = try Data (contentsOf: url)
           let json = try JSONSerialization.jsonObject(with: data, options: [])
        
            guard let jsonArray = json as? [[String: Any]] else {
                
                return
            }
        
            if let x =  jsonArray[index]["English"] {
                englishGameLbl.text=x as! String;
            }

            if let y =  jsonArray[index]["Article"] {
                artikleGameLbl.text=y as! String;
            }
            
            if let z =  jsonArray[index]["Singular"] {
                          germanGameLbl.text=z as! String;
                
       
                
                      }
            
            
        }catch{
            print(error)
        }
    
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




