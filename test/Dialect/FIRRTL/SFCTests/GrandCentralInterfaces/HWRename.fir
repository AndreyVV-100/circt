; RUN: firtool --annotation-file %S/HWRename.anno.json %s | FileCheck %s

FIRRTL version 4.0.0
circuit Top:
  module Companion :
    output io : { }

    wire _WIRE : UInt<1>
    connect _WIRE, UInt<1>(0h0)

  module DUT:
    input a: UInt<1>
    output b: UInt<1>

    wire signed: UInt<1>

    connect signed, a
    connect b, signed

    inst companion of Companion

  public module Top:
    input a: UInt<1>
    output b: UInt<1>

    inst signed of DUT
    connect signed.a, a
    connect b, signed.b

    ; CHECK:      module Companion(
    ; CHECK:        input [[port:[a-zA-Z0-9_]+]]
    ; CHECK:      );
    ; CHECK:        MyInterface MyView();
    ; CHECK-NEXT:   assign MyView.[[elementName:.+]] = [[port]];
    ; CHECK-NEXT: endmodule

    ; CHECK:      module DUT
    ; CHECK:        input a
    ; CHECK:          Companion companion (
    ; CHECK-NEXT:       .[[port]] (a)
    ; CHECK-NEXT:     );
    ; CHECK:      endmodule

    ; CHECK:      module Top
    ; CHECK:        DUT [[dutName:.+]] (
    ; CHECK:      endmodule

    ; CHECK: interface MyInterface
    ; CHECK-NEXT:   logic [[elementName]]
    ; CHECK-NEXT: endinterface
