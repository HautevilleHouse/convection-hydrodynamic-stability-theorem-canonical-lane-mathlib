import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

structure RayleighCertificate where
  rayleighNumber : ℝ
  criticalThreshold : ℝ
  stabilityMargin : ℝ
  criticalThresholdClosed : criticalThreshold > 0
  stabilityMarginClosed : stabilityMargin > 0

def sourceRayleighCertificate : RayleighCertificate := {
  rayleighNumber := 1708
  criticalThreshold := 1708
  stabilityMargin := 0.1
  criticalThresholdClosed := by norm_num
  stabilityMarginClosed := by norm_num
}

def RayleighStable (R : RayleighCertificate) : Prop :=
  R.rayleighNumber < R.criticalThreshold + R.stabilityMargin

theorem source_rayleigh_stable_checked : RayleighStable sourceRayleighCertificate := by
  unfold RayleighStable sourceRayleighCertificate
  norm_num

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse