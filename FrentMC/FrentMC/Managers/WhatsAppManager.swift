//
//  WhatsappAPI.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 21/11/22.
//

import Foundation

class WhatsAppManager {
    func createLink(user: User, goods: Goods) -> String {
        guard let numberString = user.phone_number else {return ""}
        guard let goodsName = goods.goodsName else {return ""}
        let textTemplate = "Halo%20saya%20ingin%20meminjam%20barang%20\(goodsName)"
        let whatsAppURL = "https://wa.me/\(numberString)?text=\(textTemplate)"
        
        return whatsAppURL
    }
    
    func createLinkAdmin() -> String {
        let numberString = "628174960937"
        let textTemplate = "Hi%20admin,%20I%20need%20help"
        let whatsAppURL = "https://wa.me/\(numberString)?text=\(textTemplate)"
        
        return whatsAppURL
    }

}
