import SUV
import SwiftestClient

describe("INet") {
  describe("family") {
    it("returns UVINetAF for AF") {
      expect(INet.AF.family).to.equal(UVINetAF)
    }

    it("returns UVINetPF for PF") {
      expect(INet.PF.family).to.equal(UVINetPF)
    }
  }
}
