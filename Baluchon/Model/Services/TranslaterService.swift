//
//  TranslaterSession.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 16/06/2021.
//

import Foundation

class TranslaterService {
    
    // MARK: - Variables and constants

    // Singleton used to create a single instance and call the API once at a time.
    static var shared = TranslaterService()
    private init() {}
    
    // API Url.
    private static let translaterUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    
    // To parameter API calling.
    private var task: URLSessionDataTask?
    
    // To parameter API calling.
    private var translaterSession = URLSession(configuration: .default)
    
    // To avoid var translater Session remains public, use of an initializer.
    init(translaterSession: URLSession) {
        self.translaterSession = translaterSession
    }
    
    // Int use in the language selection process.
    var tag = 0
    
    // MARK: - Functions
    
    // To recognize which language to insert in API Url as body parameter.
    func selectSourceLanguage() -> String {
        if tag == 0 {
            return "&target=en&source=fr"
        }
            return "&target=fr&source=en"
    }
    
    // To get data from API in an asynchrone thread, taking into account the chosen language and the text to translate typed by the user.
    func getTranslation(userTag: Int, text: String, callback: @escaping (Bool, Translation?) -> Void) {
        
        tag = userTag
        let bodyForLanguages = selectSourceLanguage()
        
        var request = URLRequest(url: TranslaterService.translaterUrl)
        request.httpMethod = "POST"
        
        let body = "q=\(text)" + "\(bodyForLanguages)" + "&key=AIzaSyCXQoqZn2DYlK89KWubvz-9kKcwTFBbLUU"
        request.httpBody = body.data(using: .utf8)
        
        task?.cancel()
        task = translaterSession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }

                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }

                    guard let responseJSON = try? JSONDecoder().decode(Translation.self, from: data) else {
                            callback(false, nil)
                            return
                    }
                    callback(true, responseJSON)
                    }
                }
            task?.resume()
        }
}
