//
//  DashboardView.swift
//  wallet
//
//  Created by Payam on 5/6/21.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        
        VStack {
            Text("Zarb Dashboard")
            Spacer()
            
            Text("$ " + Float.random(in: 1...1000).rounded().description + " Balance")
            
            HStack {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 200, height: 200)
            }
            Spacer()
            
            
            Text("Transactions")
            List {
                
                ForEach(getRandomList(), id: \.self) { item in
                    HStack {
                        Text("$" + Float.random(in: 1...100).description )
                        Text(Date.randomBetween(start: "2021/01/01", end: "2021/04/04"))
                        Spacer()
                        Text(item)
                    }
                }
            }

            
        }
        
    }
}
func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
func getRandomList() -> [String] {
    var list = [String]()
    for _ in 1...20 {
        list.append(randomString(length: 15))

    }
    return list
}
extension Date {
    
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> String {
        let date1 = Date.parse(start, format: format)
        let date2 = Date.parse(end, format: format)
        return Date.randomBetween(start: date1, end: date2).dateString(format)
    }

    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }

    func dateString(_ format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
