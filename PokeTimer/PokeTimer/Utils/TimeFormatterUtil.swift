//
//  TimeFormatterUtil.swift
//  PokeTimer
//
//  Created by HUA Cindy on 12/03/2025.
//

import Foundation

struct TimeFormatterUtil {
    /// Converts a session duration in seconds into a human-readable format.
    static func formattedDuration(_ durationInSeconds: Int) -> String {
        let hours = durationInSeconds / 3600
        let minutes = (durationInSeconds % 3600) / 60
        let seconds = durationInSeconds % 60

        if hours > 0 {
            return String(format: "%dh %dm", hours, minutes)
        } else if minutes > 0 {
            return String(format: "%dm %ds", minutes, seconds)
        } else {
            return String(format: "%ds", seconds)
        }
    }
    
    /// Converts seconds into MM:SS format (for timer display).
    static func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    /// Converts minutes to seconds (for clarity in duration-based functions).
    static func minutesToSeconds(_ minutes: Int) -> Int {
        return minutes * 60
    }
}
