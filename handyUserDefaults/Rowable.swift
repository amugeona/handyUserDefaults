//
//  Rowable.swift
//  handyUserDefaults
//
//  Created by KimYong Gyun on 12/2/17.
//  Copyright © 2017 haruair. All rights reserved.
//

import Foundation

class TypeInfo {
    var name : String
    var props : [Property]
    init(_ name: String, _ props: [Property]) {
        self.name = name
        self.props = props
    }
}

struct Property {
    var label : String
    var value : Mirror
    
    // return typename -- String(describing: type(of: prop.subjectType))
}

class TypeInfoResource {
    static let sharedInstance = TypeInfoResource()
    var infoList : [TypeInfo] = []
    
    func add(_ typeInfo: TypeInfo) {
        infoList.append(typeInfo)
    }
    func find(byKey key: String) -> TypeInfo? {
        return infoList.filter { $0.name == key }.first
    }
}

class Rowable<T : NSObject> : NSObject, NSCoding {
    
    var item : T
    var typeinfo : TypeInfo
    
    init(from item: T) {
        self.item = item
        let res = TypeInfoResource.sharedInstance
        
        let mirror = Mirror(reflecting: item)
        let params = "\(mirror.subjectType)"
        

        if let typeinfo = res.find(byKey: mirror.description) {
            self.typeinfo = typeinfo
        } else {
            let props = mirror.children.flatMap {
                Property(label: $0.label!, value: Mirror(reflecting: $0.value))
            }
            self.typeinfo = TypeInfo(mirror.description, props)
            res.add(self.typeinfo)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        let item = self.item
        for prop in typeinfo.props {
            aCoder.encode(item.value(forKey: prop.label), forKey:prop.label)
        }
        aCoder.encode(typeinfo.name, forKey: "_type")
    }
    
    func properties() -> [Property] {
        return typeinfo.props
    }

    required convenience init?(coder aDecoder: NSCoder){
        guard let typeName = aDecoder.decodeObject(forKey: "_type") as? String else { return nil }
        let res = TypeInfoResource.sharedInstance
        
        guard let typeinfo = res.find(byKey: typeName) else { return nil }
        
        let item = T()
        for prop in typeinfo.props {
            if prop.value.subjectType == String.self,
                let value = aDecoder.decodeObject(forKey: prop.label) as? String {
                item.setValue(value, forKey: prop.label)
            }
            else if prop.value.subjectType == Int.self,
                let value = aDecoder.decodeObject(forKey: prop.label) as? Int {
                item.setValue(value, forKey: prop.label)
            }
        }
        self.init(from: item)
    }
}
