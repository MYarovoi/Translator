//
//  MessageBubbleView.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 24.02.2025.
//

import UIKit

class MessageBubbleView: UIView {
    
    let text: String
    
    init(quote: String) {
        self.text = quote
        super.init(frame: CGRect(x: 0, y: 0, width: 291, height: 142))
        backgroundColor = .clear
    }
      
      required init?(coder: NSCoder) {
          self.text = ""
          super.init(coder: coder)
          backgroundColor = .clear
      }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let cornerRadius: CGFloat = 16
        let tailWidth: CGFloat = 15
        let tailHeight: CGFloat = 110
        let tailOffset: CGFloat = 35
        let bubbleRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height - tailHeight)

        let bubblePath = UIBezierPath(roundedRect: bubbleRect, cornerRadius: cornerRadius)
        path.append(bubblePath)

    
        let tailStartX = bubbleRect.maxX - tailOffset
        let tailStartY = bubbleRect.maxY
        let tailEndX = tailStartX - tailWidth - 50
        let tailEndY = rect.maxY

        path.move(to: CGPoint(x: tailStartX, y: tailStartY))
        path.addLine(to: CGPoint(x: tailEndX, y: tailEndY))
        path.addLine(to: CGPoint(x: tailStartX + tailWidth, y: tailStartY))
        path.close()

        UIColor.themepurpleForMessageView.setFill()
        path.fill()
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Konkhmer Sleokchher", size: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]
        
        let textSize = text.size(withAttributes: textAttributes)
              
        let textRect = CGRect(
            x: (rect.width - textSize.width) / 2,
            y: (bubbleRect.height - textSize.height) / 2,
            width: textSize.width,
            height: textSize.height
        )
              
              text.draw(in: textRect, withAttributes: textAttributes)
    }
}

