//
//  SmsFormatTandil.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 16/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

class SmsFormatTandil {
    
    let licensePlate: String
    let hoursToPark: String
    let streetToPark: String
    
    init(licensePlate: String, hoursToPark:String, streetToPark: String) {
        self.licensePlate = licensePlate
        self.hoursToPark = hoursToPark
        self.streetToPark = streetToPark
    }
    
    func getSmsBody() -> String {
        return licensePlate + hoursToPark + streetToPark
    }
    
/*    Para estacionar, por ejemplo en uno de los lugares disponibles en la calle Paz al 500, el automovilista deberá enviar mensaje al 66 736, escribiendo el número de patente, espacio, horas a adquirir y el lugar, que se identificará con las dos primeras letras de la calle y su altura. Como ejemplo, para un coche con la patente ASF 342, el automovilista deberá poner en el mensaje ASF 342 1 (el tiempo) PA 500 (por calle Paz al 500).
  */  
}