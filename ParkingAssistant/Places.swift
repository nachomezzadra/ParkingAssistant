//
//  Country.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 19/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

class Places {

    var dictionary = Dictionary<String, City>()
    var keys: [String] = [String]()
    let unknownCityKey = "Unknown City"

    init() {
        var smsParkingSetUnknown: SmsParkingSet = getSmsParkingSetUnknown()
        var smsParkingSetTandil: SmsParkingSet = getSmsDetailsTandil()
        var smsParkingSetLaPlata: SmsParkingSet = getSmsDetailsLaPlata()
        var smsParkingSetJunin: SmsParkingSet = getSmsDetailsJunin()
        var smsParkingSetMarDelPlata: SmsParkingSet = getSmsDetailsMarDelPlata()
        var smsParkingSetMoron: SmsParkingSet = getSmsDetailsMoron()
        
        
        dictionary["Tandil"] = City(name: "Tandil", latitude: -37.3167, longitude: -59.15, smsParkingSet: smsParkingSetTandil)
        dictionary["La Plata"] = City(name: "La Plata", latitude: 000, longitude: 000, smsParkingSet: smsParkingSetLaPlata)
        dictionary["Junin"] = City(name: "Junin", latitude: -34.585, longitude: -60.9589, smsParkingSet: smsParkingSetJunin)
        dictionary["Mar del Plata"] = City(name: "Mar del Plata", latitude: -38, longitude: -57.55, smsParkingSet: smsParkingSetMarDelPlata)
        dictionary["Moron"] = City(name: "Moron", latitude: -1, longitude: -1, smsParkingSet: smsParkingSetMoron)

        dictionary[unknownCityKey] = City(name: unknownCityKey, latitude: -1, longitude: -1, smsParkingSet: smsParkingSetUnknown)
        // assigning all the dictionary elements to an array of keys
        self.keys = [String] (dictionary.keys)

    }
    
    func getCityFrom(cityName: String) -> City? {
            return dictionary[cityName] ?? dictionary[unknownCityKey]!
    }
    
    func getNumberOfCities() -> Int {
        return dictionary.count
    }
    
    func getCityFromId(id: Int) -> City? {
        var cityAsStr: String = (self.keys[id])
        return self.getCityFrom(cityAsStr)
    }
    
    private func getSmsParkingSetUnknown() -> SmsParkingSet {
        var smsFormat: SmsFormat = SmsFormat(smsNumber: "Unknown number")
        return SmsParkingSet(smsStart: smsFormat, smsStop: nil, smsRegister: nil, smsCard: nil, smsBalance: nil)
    }
    
    private func getSmsDetailsTandil() -> SmsParkingSet {
        var smsFormat: SmsFormat = SmsFormat(smsNumber: "66736")
        smsFormat.add(SmsBodyOption.LicensePlate)
        smsFormat.add(SmsBodyOption.Hours)
        smsFormat.add(SmsBodyOption.Street)
        smsFormat.add(SmsBodyOption.Block)
        
        var smsParkingSet: SmsParkingSet = SmsParkingSet(smsStart: smsFormat, smsStop: nil, smsRegister: nil, smsCard: nil, smsBalance: nil)
        
        return smsParkingSet
    }
    
    /**
    Otra forma es la carga por celular a través de un mensaje de texto. Cuando se intenta cargar por primera vez, debe enviarse un SMS al 54223 con la palabra "R" para registrarse. 
        Luego se recibirá una clave de acceso. Y a partir de ese momento queda registrado el número de teléfono al sistema. Una vez registrado, se debe raspar la tarjeta y aparecerá un código. Cada vez que se pretenda renovar el tiempo de estacionamiento, el usuario debe mandar un SMS al 54223 con la letra "T" y el número de pin que figura en la tarjeta. Ya para estacionar, debe enviar el mismo SMS pero con la palabra "E" con los datos de la patente. Y para finalizar el tiempo de estacionamiento, un último SMS al 54223 con la letra "F" y con la patente.

    **/
    private func getSmsDetailsMarDelPlata() -> SmsParkingSet {
        var smsStart: SmsFormat = SmsFormat(smsNumber: "54223")
        smsStart.add("E")
        smsStart.add(SmsBodyOption.LicensePlate)
        
        var smsRegister: SmsFormat = SmsFormat(smsNumber: "54223")
        smsRegister.add("R")
        
        var smsStop: SmsFormat = SmsFormat(smsNumber: "54223")
        smsStop.add("F")
        smsStop.add(SmsBodyOption.LicensePlate)
        
        var smsCard: SmsFormat = SmsFormat(smsNumber: "54223")
        smsCard.add("T")
        smsCard.add(SmsBodyOption.CardNumber)
        
        
        var smsParkingSet: SmsParkingSet = SmsParkingSet(smsStart: smsStart, smsStop: smsStop, smsRegister: smsRegister, smsCard: smsCard, smsBalance: nil)
        
        
        return smsParkingSet
    }

    private func getSmsDetailsLaPlata() -> SmsParkingSet {
        var smsStart: SmsFormat = SmsFormat(smsNumber: "6357")
        smsStart.add("E")
        smsStart.add(SmsBodyOption.LicensePlate)
        
        var smsParkingSet: SmsParkingSet = SmsParkingSet(smsStart: smsStart, smsStop: nil, smsRegister: nil, smsCard: nil, smsBalance: nil)
        
        return smsParkingSet
    }
    
    private func getSmsDetailsJunin() -> SmsParkingSet {
        var smsStart: SmsFormat = SmsFormat(smsNumber: "37822")
        smsStart.add("J")
        smsStart.add(SmsBodyOption.LicensePlate)
        
        var smsParkingSet: SmsParkingSet = SmsParkingSet(smsStart: smsStart, smsStop: nil, smsRegister: nil, smsCard: nil, smsBalance: nil)
        
        
        return smsParkingSet
    }
    
    /*
    Para registrarse, el conductor deberá enviar por única vez un mensaje de texto al 86527 con la letra "E" y adquirir su crédito para estacionamiento medido con celular en los punto de venta habilitados (el monto mínimo es de $ 35). Inmediatamente recibirá un SMS confirmando la acreditación al nuevo sistema.
    
    Luego, cada vez que estacione, deberá enviar un SMS al 86527 con la letra "E" (espacio) y su patente completa (sin espacios). Ejemplo: E AAA111. Automáticamente el sistema dará inicio al estacionamiento y recibirá un mensaje de confirmación.
    
    Para finalizar el estacionamiento, se deberá enviar un SMS con las palabras E FIN al 86527 y a continuación recibirá un mensaje informando la finalización, duración, costo y nuevo saldo.
    
    El conductor podrá consultar su saldo cuando lo deseé enviando E SALDO al 86527.
    */
    private func getSmsDetailsMoron() -> SmsParkingSet {
        var smsStart = SmsFormat(smsNumber: "86527")
        smsStart.add("E")
        smsStart.add(SmsBodyOption.LicensePlate)
        
        var smsRegister: SmsFormat = SmsFormat(smsNumber: "86527")
        smsRegister.add("E")
        
        var smsStop: SmsFormat = SmsFormat(smsNumber: "86527")
        smsStop.add("E")
        smsStop.add("FIN")
        
        var smsBalance: SmsFormat = SmsFormat(smsNumber: "86527")
        smsBalance.add("E")
        smsBalance.add("SALDO")
        
        var smsParkingSet: SmsParkingSet = SmsParkingSet(smsStart: smsStart, smsStop: smsStop, smsRegister: smsRegister, smsCard: nil, smsBalance: nil)
        
        return smsParkingSet
    }
}