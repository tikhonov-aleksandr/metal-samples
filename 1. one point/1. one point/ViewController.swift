//
//  ViewController.swift
//  1. one point
//
//  Created by pino on 29.01.26.
//

import UIKit
import MetalKit

final class Renderer: NSObject {
    
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var metalView: MTKView!
    private var renderer: Renderer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        renderer = Renderer()
        metalView.delegate = renderer
        metalView.clearColor = MTLClearColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        
    }

}

