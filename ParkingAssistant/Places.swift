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


    init() {
        var smsDetailsTandil: SmsDetails = getSmsDetailsTandil()
        var smsDetailsLaPlata = getSmsDetailsLaPlata()
        var smsDetailsJunin = getSmsDetailsJunin()
        var smsDetailsMarDelPlata = getSmsDetailsMarDelPlata()
        var smsDetailsMoron = getSmsDetailsMoron()
        
        dictionary["Tandil"] = City(name: "Tandil", latitude: -37.3167, longitude: -59.15, smsInfo: smsDetailsTandil)
        dictionary["La Plata"] = City(name: "La Plata", latitude: 000, longitude: 000, smsInfo: smsDetailsLaPlata)
        dictionary["Junin"] = City(name: "Junin", latitude: -34.585, longitude: -60.9589, smsInfo: smsDetailsJunin)
        dictionary["Mar del Plata"] = City(name: "Mar del Plata", latitude: -38, longitude: -57.55, smsInfo: smsDetailsMarDelPlata)
        dictionary["Moron"] = City(name: "Moron", latitude: -1, longitude: -1, smsInfo: smsDetailsMoron)
        
        // assigning all the dictionary elements to an array of keys
        self.keys = [String] (dictionary.keys)

    }
    
    func getCityFrom(cityName: String) -> City? {
        if (cityName != "") {
            return dictionary[cityName]!
        }
//        hay que ver q hacer cuando no se encuentra la current city.  Retornal nil parece no estar bueno..  tal vez una city vacia o de error?
        return getCityFrom("Tandil")
    }
    
    func getNumberOfCities() -> Int {
        return dictionary.count
    }
    
    func getCityFromId(id: Int) -> City {
        var cityAsStr: String = (self.keys[id])
        return self.getCityFrom(cityAsStr)!
    }
    
    private func getSmsDetailsTandil() -> SmsDetails {
        var smsDetailsTandil: SmsDetails = SmsDetails(smsNumber: "66736")
        smsDetailsTandil.add(SmsBodyOption.LicensePlate)
        smsDetailsTandil.add(SmsBodyOption.Hours)
        smsDetailsTandil.add(SmsBodyOption.Street)
        smsDetailsTandil.add(SmsBodyOption.Block)
        smsDetailsTandil.actualHours = "1"
        return smsDetailsTandil
    }
    
    /**
    Otra forma es la carga por celular a través de un mensaje de texto. Cuando se intenta cargar por primera vez, debe enviarse un SMS al 54223 con la palabra "R" para registrarse. Luego se recibirá una clave de acceso. Y a partir de ese momento queda registrado el número de teléfono al sistema. Una vez registrado, se debe raspar la tarjeta y aparecerá un código. Cada vez que se pretenda renovar el tiempo de estacionamiento, el usuario debe mandar un SMS al 54223 con la letra "T" y el número de pin que figura en la tarjeta. Ya para estacionar, debe enviar el mismo SMS pero con la palabra "E" con los datos de la patente. Y para finalizar el tiempo de estacionamiento, un último SMS al 54223 con la letra "F" y con la patente.

    **/
    private func getSmsDetailsMarDelPlata() -> SmsDetails {
        var smsDetailsMarDelPlata: SmsDetails = SmsDetails(smsNumber: "54223")
        smsDetailsMarDelPlata.add(SmsBodyOption.Keyword)
        smsDetailsMarDelPlata.actualKeyword = "E"
        smsDetailsMarDelPlata.add(SmsBodyOption.LicensePlate)
        return smsDetailsMarDelPlata
    }

    private func getSmsDetailsLaPlata() -> SmsDetails {
        var smsDetailsLp: SmsDetails = SmsDetails(smsNumber: "6357")
        smsDetailsLp.add(SmsBodyOption.Keyword)
        smsDetailsLp.actualKeyword = "E"
        smsDetailsLp.add(SmsBodyOption.LicensePlate)
        return smsDetailsLp
    }
    
    private func getSmsDetailsJunin() -> SmsDetails {
        var smsDetailsJunin: SmsDetails = SmsDetails(smsNumber: "37822")
        smsDetailsJunin.actualKeyword = "J"
        smsDetailsJunin.add(SmsBodyOption.Keyword)
        smsDetailsJunin.add(SmsBodyOption.LicensePlate)
        return smsDetailsJunin
    }
    
    /*
    Para registrarse, el conductor deberá enviar por única vez un mensaje de texto al 86527 con la letra "E" y adquirir su crédito para estacionamiento medido con celular en los punto de venta habilitados (el monto mínimo es de $ 35). Inmediatamente recibirá un SMS confirmando la acreditación al nuevo sistema.
    
    Luego, cada vez que estacione, deberá enviar un SMS al 86527 con la letra "E" (espacio) y su patente completa (sin espacios). Ejemplo: E AAA111. Automáticamente el sistema dará inicio al estacionamiento y recibirá un mensaje de confirmación.
    
    Para finalizar el estacionamiento, se deberá enviar un SMS con las palabras E FIN al 86527 y a continuación recibirá un mensaje informando la finalización, duración, costo y nuevo saldo.
    
    El conductor podrá consultar su saldo cuando lo deseé enviando E SALDO al 86527.
    */
    private func getSmsDetailsMoron() -> SmsDetails {
        var smsDetails = SmsDetails(smsNumber: "86527")
        smsDetails.actualKeyword = "E"
        smsDetails.add(SmsBodyOption.Keyword)
        smsDetails.add(SmsBodyOption.LicensePlate)
        return smsDetails
    }
}