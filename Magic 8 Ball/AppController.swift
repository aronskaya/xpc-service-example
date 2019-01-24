/*
 * MIT License
 *
 * Copyright (c) 2019 aronskaya (Julia Vashchenko)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import Foundation

class AppController {
    
    private var connection: NSXPCConnection?
    private var service: MagicServiceProtocol?
    
    func start() {
        connect()
    }
    
    private func connect() {
        connection = NSXPCConnection(serviceName: kServiceName)
        connection?.remoteObjectInterface = NSXPCInterface(with: MagicServiceProtocol.self)
        
        connection?.invalidationHandler = { NSLog("Connection did invalidate") }
        connection?.interruptionHandler = { NSLog("Connection did interrupt") }
        
        connection?.resume()
        service = self.connection?.remoteObjectProxyWithErrorHandler({ (error) in
            NSLog("Error: description: \(error as NSError)")
        }) as? MagicServiceProtocol
    }
}

extension AppController {
    func getDecision(withReply decisionHandler: @escaping (String) -> ()) {
        service?.getDecision(replyBlock: { (decision) in
            decisionHandler(decision)
        })
    }
}
