add_circt_conversion_library(CIRCTAIGToComb
  AIGToComb.cpp

  DEPENDS
  CIRCTConversionPassIncGen

  LINK_LIBS PUBLIC
  CIRCTAIG
  CIRCTHW
  CIRCTComb
  MLIRIR
  MLIRPass
  MLIRSupport
  MLIRTransforms
)
