//
//  AudioRecorderManager.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 21.02.2025.
//

import AVFoundation

class AudioRecorderManager {
    var audioRecorder: AVAudioRecorder?
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        }
    }
    
    func startRecording() {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try session.setActive(true)
            
            let settings: [String: Any] = [
                AVFormatIDKey: kAudioFormatMPEG4AAC,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            let filename = getFilePath()
            audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
            audioRecorder?.record()
            print("DEBUG: Start recording")
        } catch {
            print("DEBUG: Error recording - \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        print("DEBUG: Recording successfully saved to: \(getFilePath().path)")
    }
    
    private func getFilePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("recorded_audio.m4a")
    }
}
