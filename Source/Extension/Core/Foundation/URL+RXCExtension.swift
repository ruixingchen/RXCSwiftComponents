//
//  URL+RXCExtension.swift
//  SampleProject
//
//  Created by ruixingchen on 2/14/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

public extension URL {

    var decodedString:String {
        return self.absoluteString.urlDecoded(loop: true)
    }

    /**
     * Gets the decoded authority part of this URI. For
     * server addresses, the authority is structured as follows:
     * {@code [ userinfo '@' ] host [ ':' port ]}
     *
     * <p>Examples: "google.com", "bob@google.com:80"
     *
     * @return the authority for this URI or null if not present
     */
    var authority: String? {
        return self.host
    }

    /**
     * Gets the scheme-specific part of this URI, i.e.&nbsp;everything between
     * the scheme separator ':' and the fragment separator '#'. If this is a
     * relative URI, this method returns the entire URI. Decodes escaped octets.
     *
     * <p>Example: "//www.google.com/search?q=android"
     *
     * @return the decoded scheme-specific-part
     */
//    public var schemeSpecificPart:String {
//        guard let com = URLComponents(url: self, resolvingAgainstBaseURL: true) else {return nil}
//        com.rangeOfFragment
//    }

    init ? (rawString:String) {
        self.init(string: rawString.urlEncoded(safe: true))
    }

    func removeApplewebdata()->URL {
        if self.scheme == "applewebdata" {
            guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {return self}
            components.scheme = nil
            components.host = nil
            return components.url ?? self
        }
        return self
    }

    var components:URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: true)
    }

    func getQuery(name:String)->String? {
        return self.components?.queryItems?.filter({$0.name==name}).first?.value
    }

    ///set nil means remove the query
    subscript(queryName:String)->String? {
        get {
            return getQuery(name: queryName)
        }
        set {
            guard var components = self.components else {return}
            if newValue == nil {
                //rmeove
                let items = components.queryItems?.filter({$0.name != queryName})
                components.queryItems = items
                guard let url = components.url else {return}
                self = url
            }else {
                //update value
                guard var items = components.queryItems else {return}
                for i in 0..<items.count {
                    if items[i].name == queryName {
                        items[i].value = newValue
                    }
                }
                components.queryItems = items
                guard let url = components.url else {return}
                self = url
            }
        }
    }

}
