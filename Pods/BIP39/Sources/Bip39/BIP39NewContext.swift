//
//  BIP39NewContext.swift
//  BIP39
//
//  Created by Thuyen Truong on 5/26/20.
//  Copyright © 2020 Bitmark Inc. All rights reserved.
//

import Foundation
import CBip39

public struct BIP39NewContext {
    private let ctx: OpaquePointer!

    public init() {
        self.ctx = bip39_new_context()
    }

    public var wordCount: Int {
        return bip39_get_word_count(ctx)
    }

    public var byteCount: UInt8 {
        return bip39_get_byte_count(ctx)
    }

    public func clear() {
        bip39_clear(ctx)
    }

    public func setByteCount(count: Int) {
        bip39_set_byte_count(ctx, count)
    }

    public func getBytes() -> UnsafePointer<UInt8> {
        return bip39_get_bytes(ctx)
    }

    public func setBytes(_ bytes: UnsafePointer<UInt8>, length: Int) {
        return bip39_set_bytes(ctx, bytes, length)
    }

    public func setWord(_ word: Int16, in index: Int) {
        bip39_set_word(ctx, index, UInt16(word))
    }

    public func getWord(in index: Int) -> UInt16 {
        return bip39_get_word(ctx, index)
    }

    public func verifyChecksum() -> Bool {
        return bip39_verify_checksum(ctx)
    }

    public func appendChecksum() {
        bip39_append_checksum(ctx)
    }
}
