//
//  LinkedDictionary.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/23/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import Foundation

class LinkedItem<Key: Hashable, Value> {
  var value: Value
  var prev: Key?
  var next: Key?

  init(value: Value, prev: Key?=nil, next: Key?=nil) {
    self.value = value
    self.prev = prev
    self.next = next
  }
}

class LinkedDictionary<Key : Hashable, Value> : CollectionType, DictionaryLiteralConvertible, GeneratorType {
  typealias Element = (Key, Value)
  typealias Index = DictionaryIndex<Key, Value>
  typealias SelfType = LinkedDictionary<Key, Value>
  private var dict = [Key: LinkedItem<Key, Value>]()
  private var head: Key?
  private var tail: Key?
  private var curr: Key?

  init(){}
  required init(dictionaryLiteral elements: Element...) {
    for (key, value) in elements {
      self[key] = value
    }
  }

  var startIndex: Index {
    get {
      fatalError("startIndex has not been implemented")
    }
  }

  var endIndex: Index {
    get {
      fatalError("endIndex has not been implemented")
    }
  }

  subscript (position: Index) -> Element {
    get {
      fatalError("subscript(position:) has not been implemented")
      //return (position[], dict[position]!.value)
    }
  }

  subscript(key: Key) -> Value? {
    get {
      return dict[key]?.value
    }
    set {
      updateValue(newValue!, forKey: key)
    }
  }

  func updateValue(value: Value, forKey key: Key) -> Value? {
    if let linkedItem = dict[key] {
      let linkedItemValue = linkedItem.value
      linkedItem.value = value
      return linkedItemValue
    } else {
      dict[key] = LinkedItem(value: value, prev: tail)
      if (tail != nil) {
        dict[tail!]!.next = key
      } else {
        head = key
      }
      tail = key
    }
    return nil
  }

  func removeValueForKey(key: Key) -> Value? {
    if let linkedItemValue = dict.removeValueForKey(key) {
      if let linkedItemValuePrev = linkedItemValue.prev {
        dict[linkedItemValuePrev]!.next = linkedItemValue.next
      }
      if let linkedItemValueNext = linkedItemValue.next {
        dict[linkedItemValueNext]!.prev = linkedItemValue.prev
      }
      return linkedItemValue.value
    }
    return nil
  }

  func removeAll(keepCapacity: Bool = false) {
    head = nil
    tail = nil
    dict.removeAll(keepCapacity: keepCapacity)
  }

  var count: Int {
    get {
      return dict.count
    }
  }

  func generate() -> SelfType {
    // XXX do not nest-iterate
    curr = head
    return self
  }

  func next() -> Element? {
    var element: Element?
    if (curr != nil) {
      if let linkedItem = dict[curr!] {
        element = (curr!, linkedItem.value)
        curr = linkedItem.next
      }
    }
    return element
  }

  var isEmpty: Bool {
    get {
      return dict.isEmpty
    }
  }
}