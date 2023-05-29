//
//  ViewController.swift
//  WeatherAPIApp
//
//  Created by Salih Yusuf Göktaş on 29.05.2023.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var currentLabel: UILabel!
	@IBOutlet weak var fellsLabel: UILabel!
	@IBOutlet weak var getButtonStyle: UIButton!
	@IBOutlet weak var windLabel: UILabel!
	
	let api = "07fdaa7b7fa8a2befa831458fcdd3ed9"
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Weather API"
		
		getButtonStyle.layer.cornerRadius = 25.0
		getButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
		getButtonStyle.layer.shadowRadius = 4
		getButtonStyle.layer.shadowOpacity = 0.5
		getButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
		
	}
	
	
	// 1. Web adresine gideceğiz istek göndereceğiz
	// 2. Datayı al
	// 3. Datayı işle
	@IBAction func getButton(_ sender: Any) {
		// 1.adım istek gönderdik
		let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=41.008939227467614&lon=28.980132084657654&appid=\(api)")
		let session = URLSession.shared
		let task = session.dataTask(with: url!) { data, response, error in
			if error != nil {
				print("error")
			} else {
				// 2.adım datayı aldık
				if data != nil {
					do {
						let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
						
						DispatchQueue.main.async {
							if let main  = jsonResponse!["main"] as? [String:Any] {
								if let temp = main["temp"] as? Double {
									self.currentLabel.text = String(Int(temp-272.15))
								}
								if let feels = main["feels_like"] as? Double {
									self.fellsLabel.text = String(Int(feels-272.15))
								}
							}
							if let wind  = jsonResponse!["wind"] as? [String:Any] {
								if let speed = wind["speed"] as? Double {
									self.windLabel.text = String(Int(speed))
								}
							}
						}
					} catch {
						
					}
				}
			}
		}
		task.resume()
	}
}
