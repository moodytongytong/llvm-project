//===--- BuiltinsAArch64.td - AArch64 Builtin function database ---*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the AArch64-specific builtin function database.
//
//===----------------------------------------------------------------------===//

//#include "llvm/IR/Attributes.h"
include "clang/Basic/BuiltinsAArch64Base.td"


// In libgcc
//BUILTIN(__clear_cache, "vv*v*", "i")

//BUILTIN(__builtin_arm_ldrex, "v.", "t")
//BUILTIN(__builtin_arm_ldaex, "v.", "t")
//BUILTIN(__builtin_arm_strex, "i.", "t")
//BUILTIN(__builtin_arm_stlex, "i.", "t")
//BUILTIN(__builtin_arm_clrex, "v", "")

def __clear_cache : AArch64NoPrefixBuiltin<"void (void *, void *)">;

let Attributes = [CustomTypeChecking] in {
    def ldrex : AArch64Builtin<"void (...)">;
    def ldaex : AArch64Builtin<"void (...)">;
    def strex : AArch64Builtin<"int (...)">;
    def stlex : AArch64Builtin<"int (...)">;
}
def clrex : AArch64Builtin<"void ()">;



// Bit manipulation
//BUILTIN(__builtin_arm_rbit, "UiUi", "nc")
//BUILTIN(__builtin_arm_rbit64, "WUiWUi", "nc")
//BUILTIN(__builtin_arm_cls, "UiZUi", "nc")
//BUILTIN(__builtin_arm_cls64, "UiWUi", "nc")
//BUILTIN(__builtin_arm_clz, "UiZUi", "nc")
//BUILTIN(__builtin_arm_clz64, "UiWUi", "nc")

let Attributes = [NoThrow, Const] in {
    def rbit : AArch64Builtin<"uint (uint)">;
    def rbit64 : AArch64Builtin<"uint64_t (uint64_t)">;
    def cls : AArch64Builtin<"uint (uint32_t)">;
    def cls64 : AArch64Builtin<"uint (uint64_t)">;
    def clz : AArch64Builtin<"uint (uint32_t)">;
    def clz64 : AArch64Builtin<"uint (uint64_t)">;
}


// A python function for translating the builtin
// another one for the target builtin
// another for langbuiltin
// another for target header builtin


// CRC32
//TARGET_BUILTIN(__builtin_arm_crc32b, "UiUiUc", "nc", "crc")

def crc32b : AArch64TargetBuiltin<"unsigned int (unsigned int, unsigned char)"> {
    let Attributes = [Nothrow, Const];
    let Features = "crc";
}

// Memory Tagging Extensions (MTE)
//TARGET_BUILTIN(__builtin_arm_irg, "v*v*Ui", "t", "mte")
//TARGET_BUILTIN(__builtin_arm_addg, "v*v*Ui", "t", "mte")
//TARGET_BUILTIN(__builtin_arm_gmi, "Uiv*Ui", "t", "mte")
//TARGET_BUILTIN(__builtin_arm_ldg, "v*v*", "t", "mte")

let Attributes = [CustomTypeChecking], Features = "mte" in {
    def irg : AArch64TargetBuiltin<"void * (void *, unsigned int)">;
    def addg : AArch64TargetBuiltin<"void * (void *, unsigned int)">;
    def gmi : AArch64TargetBuiltin<"unsigned int (void *, unsigned int)">;
    def ldg : AArch64TargetBuiltin<"void * (void *)">;
}

// System Registers
//BUILTIN(__builtin_arm_rsr, "UiCc*", "nc")
//BUILTIN(__builtin_arm_rsr64, "WUiCc*", "nc")
let Attributes = [NoThrow, Const] in {
    def rsr : AArch64Builtin<"unsigned int (const char *)">;
    def rsr64 : AArch64Builtin<"uint32_t (const char *)">;
}

//TARGET_BUILTIN(__builtin_arm_rsr128, "LLLUiCc*", "nc", "d128")
def rsr128 : AArch64TargetBuiltin<"__uint128_t (const char *)"> {
    let Attributes = [NoThrow, Const];
    let Features = "d128";
}
// might need help translating LLL

// MSVC
//LANGBUILTIN(__dmb, "vUi", "nc", ALL_MS_LANGUAGES)
//LANGBUILTIN(__dsb, "vUi", "nc", ALL_MS_LANGUAGES)
//LANGBUILTIN(__yield, "v", "",   ALL_MS_LANGUAGES)
//LANGBUILTIN(__wfe,   "v", "",   ALL_MS_LANGUAGES)
//LANGBUILTIN(__wfi,   "v", "",   ALL_MS_LANGUAGES)

let Languages = "ALL_MS_LANGUAGES", Attributes = [NoThrow, Const] in {
  def __dmb : AArch64NoPrefixLangBuiltin<"void (unsigned int)">;
  def __dsb : AArch64NoPrefixLangBuiltin<"void (unsigned int)">;
}

let Languages = "ALL_MS_LANGUAGES" in {
    def __yield : AArch64NoPrefixLangBuiltin<"void ()">;
    def __wfe : AArch64NoPrefixLangBuiltin<"void ()">;
    def __wfi : AArch64NoPrefixLangBuiltin<"void ()">;
}

//TARGET_HEADER_BUILTIN(_BitScanForward, "UcUNi*UNi", "nh", INTRIN_H, ALL_MS_LANGUAGES, "")
//TARGET_HEADER_BUILTIN(_BitScanReverse, "UcUNi*UNi", "nh", INTRIN_H, ALL_MS_LANGUAGES, "")
//TARGET_HEADER_BUILTIN(_InterlockedExchangeAdd_acq, "NiDNi*Ni", "nh", INTRIN_H, ALL_MS_LANGUAGES, "")
//TARGET_HEADER_BUILTIN(_InterlockedExchangeAdd_rel, "NiDNi*Ni", "nh", INTRIN_H, ALL_MS_LANGUAGES, "")

let Header = "intrin.h", Languages = "ALL_MS_LANGUAGES", Attributes = [NoThrow, RequireDeclaration] in {
    def _BitScanForward : AArch64NoPrefixTargetLibBuiltin<"unsigned char (int *, int)">;
    def _BitScanReverse : AArch64NoPrefixTargetLibBuiltin<"unsigned char (int *, int)">;
    def _InterlockedExchangeAdd_acq : AArch64NoPrefixTargetLibBuiltin<"int (volatile int *, int)">;
    def _InterlockedExchangeAdd_rel : AArch64NoPrefixTargetLibBuiltin<"int (volatile int *, int)">;
}

// buildinheaders.def, in clang/basic

// How to translate Ni for prototype?  Kai will follow up on this one

//  N   -> 'int' size if target is LP64, 'L' otherwise.

// ASK ABOUT THESE
TARGET_HEADER_BUILTIN(__prefetch, "vCv*", "nh", INTRIN_H, ALL_MS_LANGUAGES, "")
BUILTIN(__builtin_arm_prefetch, "vCv*UiUiUiUi", "nc")
BUILTIN(__builtin_arm_wsrp, "vCc*Cv*", "nc")
TARGET_BUILTIN(__builtin_arm_ld64b, "vCv*WUi*", "n", "ls64") // const void * ??
TARGET_BUILTIN(__builtin_arm_st64b, "vv*CWUi*", "n", "ls64")


prototype_map = {
    "v": "void",
    ".": "...",
    "i": "int",
    "d": "double",
    "f": "float",
    "z": "size_t",
    "Ui": "unsigned int",
    "WUi": "uint64_t",
    "ZUi": "uint32_t",
    "Zi": "int32_t",
    "Uc": "unsigned char",
    "UNi": "msuint32_t",
    "Ni": "msint32_t",
    "Cc": "const char",
    "DNi": "volatile msint32_t",
    "CWUi": "const uint64_t",
    "Cv": "const void",
}