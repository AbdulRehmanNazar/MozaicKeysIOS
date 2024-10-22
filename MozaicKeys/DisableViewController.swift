//
//  DisableViewController.swift
//  MozaicKeys
//
//  Created by Muhammad  Aqeel on 14/10/2024.
//

import UIKit
import CoreBluetooth
import CoreLocation

class DisableViewController: UIViewController, CBPeripheralManagerDelegate {
    
    var peripheralManager: CBPeripheralManager?
    var beaconUUID = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!
    var majorValue: CLBeaconMajorValue = 1
    var minorValue: CLBeaconMinorValue = 2
    var beaconID: String = ""
    
    @IBOutlet weak var beaconIDLabel: UILabel!
    @IBOutlet weak var disableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let phoneNumber = UserDefaults.standard.string(forKey: "userPhoneNumber") {
            beaconUUID = UUID(uuidString: "\(phoneNumber)-1234-1234-1234-123456789abc")!
            beaconID = beaconUUID.uuidString
            beaconIDLabel.text = beaconID
        }
        
        // Start broadcasting beacon
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        setupDisableButton()
    }
    
    func setupDisableButton() {
        disableButton.setTitle("Disable Beacon", for: .normal)
        disableButton.addTarget(self, action: #selector(disableBeacon), for: .touchUpInside)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            startBroadcastingBeacon()
        } else {
            print("Bluetooth is not available.")
        }
    }
    
    func startBroadcastingBeacon() {
        let beaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: majorValue, minor: minorValue, identifier: beaconID)
        let peripheralData = beaconRegion.peripheralData(withMeasuredPower: nil) as? [String: Any]
        peripheralManager?.startAdvertising(peripheralData)
        print("Broadcasting Beacon ID: \(beaconID)")
    }
    
    @objc func disableBeacon() {
        peripheralManager?.stopAdvertising()
        print("Beacon broadcasting stopped.")
    }
    
    @IBAction func copyBeaconID(_ sender: UIButton) {
        UIPasteboard.general.string = beaconID
        let alert = UIAlertController(title: "Copied", message: "Beacon ID copied to clipboard", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
