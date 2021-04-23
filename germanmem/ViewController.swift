//
//  ViewController.swift
//  germanmem
//
//  Created by Sherif Hamad on 09.09.20.
//  Copyright © 2020 Sherif Hamad. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{

    
    var index = 0;
    var boundry = 1585;
    
    @IBOutlet weak var articleLbl: UILabel!
    
    @IBOutlet weak var englishLbl: UILabel!
    
    @IBOutlet weak var germanLbl: UILabel!
    
    @IBOutlet weak var wordsCount: UILabel!
    
    @IBOutlet weak var uiSlider: UISlider!
    
    @IBOutlet weak var correctMark: UIImageView!
    @IBOutlet weak var testWord: UITextField!
    
  

    
    @IBOutlet weak var typeYourWordTxt: UITextField!
    
    @IBOutlet weak var typeYourWordLbl: UILabel!
    
    @IBOutlet weak var testModeSwitch: UISwitch!
    
    @IBAction func testModeSwitchAction(_ sender: Any) {
        
      setTestModeStatus();

    }
    
    @IBAction func wordsSlider(_ sender: UISlider) {
        
        index = Int(sender.value);
        wordsCount.text = "Word \(index) of \(boundry)";
    
    }
    

    
    @IBAction func menuButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testWord.delegate = self;
        correctMark.isHidden = true;

        // Do any additional setup after loading the view.
        
        setTestModeStatus();
        typeYourWordTxt.delegate = self;
        
        
    }


    
    func setTestModeStatus(){
        if testModeSwitch.isOn{
            typeYourWordLbl.isHidden=false;
            typeYourWordTxt.isHidden=false;
            
        }
        else {
            typeYourWordLbl.isHidden=true;
            typeYourWordTxt.isHidden=true;
        }
        
    }
    
    
    @IBAction func prevWordBtn(_ sender: Any) {
        
        fetchingInformation(index: index);
        if index>0 {index = index - 1;}
               else {index = boundry;}
        uiSlider.value = Float (index) ;
        wordsCount.text = "Word \(index) of \(boundry)";

    }
    
    
    @IBAction func nextWordBtn(_ sender: Any) {
        fetchingInformation(index: index);
        if index<boundry {index = index + 1;}
        else {index = 0}
        uiSlider.value = Float (index) ;
        wordsCount.text = "Word \(index) of \(boundry)";


    }
    
    
    public func fetchingInformation(index: Int){
        
        guard let path = Bundle.main.path(forResource: "B1", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path);
        do{
           let data = try Data (contentsOf: url)
           let json = try JSONSerialization.jsonObject(with: data, options: [])
        
            guard let jsonArray = json as? [[String: Any]] else {
                
                return
            }
        
            if let x =  jsonArray[index]["English"] {
                englishLbl.text=x as! String;
            }

            if let y =  jsonArray[index]["Article"] {
                articleLbl.text=y as! String;
            }
            
            if let z =  jsonArray[index]["Singular"] {
                          germanLbl.text=z as! String;
                
                let utterance = AVSpeechUtterance(string: z as! String)
                utterance.voice = AVSpeechSynthesisVoice(language: "de-DE")
                utterance.rate = 0.5
                let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(utterance)
                
                      }
            
            
        }catch{
            print(error)
        }
    
    }
    
}

func checkWordIsCorrect(){
    
    
}

func isTheWordCorrect(){
    
    
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder();
        if typeYourWordTxt.text == germanLbl.text{
            
            correctMark.isHidden=false;
        }else{correctMark.isHidden=true}
        
        
        return true;
    }
    
    
}





