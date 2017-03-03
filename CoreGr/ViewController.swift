//
//  ViewController.swift
//  CoreGr
//
//  Created by formador on 8/2/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

//Core Graphics
//UIColor, UIBezierPath, CGColor, CGPath
//translateBy(), rotateBy(), strokePath()

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var tipoDeDibujoActual = 0 //Cambiamos el valor de esta variable y para cada valor usamos un tipo de coreGraphics
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dibujarRectangulo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dibujarRectangulo() {
        //UIGraphicsRenderer
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        //Contexto = Lienzo - Canvas
        let img = renderer.image { contexto in
            //Dibujar el rectángulo
            //setFillColor()
            //setStrokeColor()
            //setLineWidth()
            //addRect()
            //drawPath()
            
            let rectangulo = CGRect(x: 0, y: 0, width: 512, height: 512)
            contexto.cgContext.setFillColor(UIColor.red.cgColor) //El relleno
            contexto.cgContext.setStrokeColor(UIColor.black.cgColor)
            contexto.cgContext.setLineWidth(10)
            contexto.cgContext.addRect(rectangulo)
            contexto.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = img
        
    }
    
    func dibujarCirculo() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let img = renderer.image { ctx in
            let rectangulo = CGRect(x: 10, y: 10, width: 480, height: 480)
            ctx.cgContext.setFillColor(UIColor.blue.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.orange.cgColor)
            ctx.cgContext.setLineWidth(15)
            ctx.cgContext.addEllipse(in: rectangulo)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = img
    }
    
    func dibujarDamas() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let img = renderer.image { (ctx) in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            for fila in 0..<8 {
                for columna in 0..<8 {
                    if (fila + columna) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: columna * 64, y: fila * 64, width: 64, height: 64))
                    }
                }
            }
        }
        imageView.image = img
    }
    
    func girarCuadrados() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let img = renderer.image { (ctx) in
            ctx.cgContext.translateBy(x: 256, y: 256) //Marcamos el punto de rotacion (centro). //En UIKit el eje de giro siempre esta en el centro, en CoreGraphics esta en la esquina superior izquierda
            let rotations = 64
            let amount = Double.pi / Double(rotations) //Valor del giro
            for _ in 0..<rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
    }
    
    func dibujarLineas() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let img = renderer.image { (ctx) in
            ctx.cgContext.translateBy(x: 256, y: 256)
            var first = true
            var anchura: CGFloat = 256
            
            for _ in 0..<256 {
                ctx.cgContext.rotate(by: CGFloat.pi/2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: anchura, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: anchura, y: 50))
                }
                anchura *= 0.99
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
    }
    
    func dibujarStrings() {
        //Creamos un render a un tamaño concreto
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
        let img = renderer.image { (ctx) in
            //Definir el estilo del párrafo y alinear al centro
            let estiloParrafo = NSMutableParagraphStyle()
            estiloParrafo.alignment = .center
            
            //Crear un diccionario de atributos que contenga el estilo del párrafo y la fuente tipográfica
            let atributos = [NSFontAttributeName: UIFont(name:"HelveticaNeue-Thin", size: 36)!, NSParagraphStyleAttributeName: estiloParrafo]
            
            //Dibujamos el string en la pantalla usando el diccionario anterior
            let string = "Aquí escribo una frase medianamente larga para que no la dibuje Core Graphics"
            string.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: atributos, context: nil)
            
            //Cargar una imagen y dibujamos el contexto
            let raton = UIImage(named: "mouse")
            raton?.draw(at: CGPoint(x: 150, y: 150))
        }

        //Actualizamos el imageView con el resultado final
        imageView.image = img
    }
    

    @IBAction func redibujarApretado(_ sender: AnyObject) {
        tipoDeDibujoActual += 1
        
        if tipoDeDibujoActual > 5 {
            tipoDeDibujoActual = 0
        }
        
        switch tipoDeDibujoActual {
        case 0:
            dibujarRectangulo()
        case 1:
            dibujarCirculo()
        case 2:
            dibujarDamas()
        case 3:
            girarCuadrados()
        case 4:
            dibujarLineas()
        case 5:
            dibujarStrings()
        default:
            break
        }
    }
    

}

