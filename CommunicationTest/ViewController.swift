//
//  ViewController.swift
//  CommunicationTest
//
//  Created by Parrot on 2019-10-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate  {

    // MARK: Outlets
    @IBOutlet weak var outputLabel: UITextView!
    
    // MARK: Required WCSessionDelegate variables
    // ------------------------------------------
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //@TODO
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //@TODO
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //@TODO
    }
    
    // MARK: Receive messages from Watch
    // -----------------------------------
    
    // 3. This function is called when Phone receives message from Watch
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        // 1. When a message is received from the watch, output a message to the UI
        // NOTE: Since session() runs in background, you cannot directly update UI from the background thread.
        // Therefore, you need to wrap any UI updates inside a DispatchQueue for it to work properly.
        DispatchQueue.main.async {
            self.outputLabel.insertText("\nMessage Received: \(message)")
        }
        
        // 2. Also, print a debug message to the phone console
        // To make the debug message appear, see Moodle instructions
        print("Received a message from the watch: \(message)")
    }

    
    // MARK: Default ViewController functions
    // -----------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 1. Check if phone supports WCSessions
        print("view loaded")
        if WCSession.isSupported() {
            outputLabel.insertText("\nPhone supports WCSession")
            WCSession.default.delegate = self
            WCSession.default.activate()
            outputLabel.insertText("\nSession activated")
        }
        else {
            print("Phone does not support WCSession")
            outputLabel.insertText("\nPhone does not support WCSession")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Actions
    // -------------------
    @IBAction func sendMessageButtonPressed(_ sender: Any) {
        
        // 2. When person presses button, send message to watch
        outputLabel.insertText("\nTrying to send message to watch")
        
        // 1. Try to send a message to the phone
        if (WCSession.default.isReachable) {
            let message = ["course": "MADT"]
            WCSession.default.sendMessage(message, replyHandler: nil)
            // output a debug message to the UI
            outputLabel.insertText("\nMessage sent to watch")
            // output a debug message to the console
            print("Message sent to watch")
        }
        else {
            print("PHONE: Cannot reach watch")
            outputLabel.insertText("\nCannot reach watch")
        }
    }
    
    
    // MARK: Choose a Pokemon actions
    
    @IBAction func pokemonButtonPressed(_ sender: Any) {
        print("You pressed the pokemon button")
    }
    @IBAction func caterpieButtonPressed(_ sender: Any) {
        print("You pressed the caterpie button")
    }
    
    
}

