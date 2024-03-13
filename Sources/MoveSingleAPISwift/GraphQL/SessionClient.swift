//
//  SessionClient.swift
//  
//
//  Created by Felix Fischer on 06/03/2024.
//

import Foundation

import Foundation
import Apollo

final class SessionClient: Apollo.URLSessionClient {

    let certificates: [Data]?

    init(certificates: [Data]? = nil) {
        self.certificates = certificates
        let config = URLSessionConfiguration.default
        config.tlsMinimumSupportedProtocolVersion = .TLSv12
        super.init(sessionConfiguration: config)
    }

    override func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        guard let certificates = certificates else {
            completionHandler(.performDefaultHandling, nil)
            return
        }

        if let trust = challenge.protectionSpace.serverTrust, SecTrustGetCertificateCount(trust) > 0 {
            if let certificateChain = SecTrustCopyCertificateChain(trust) as? [SecCertificate],
               let certificate = certificateChain.first {
                let data = SecCertificateCopyData(certificate) as Data
                if certificates.contains(data) {
                    completionHandler(.useCredential, URLCredential(trust: trust))
                    return
                }
            }
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
        return
    }
}
