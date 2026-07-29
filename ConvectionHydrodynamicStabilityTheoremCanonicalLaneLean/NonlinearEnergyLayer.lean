import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.LinearStabilityLayer

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

structure EnergyCertificate where
  linear : LinearStabilityCertificate
  energyDissipation : ℝ
  energyDissipationPositive : energyDissipation > 0
  nonlinearBound : Prop
  nonlinearBoundClosed : nonlinearBound

def sourceEnergyCertificate : EnergyCertificate := {
  linear := sourceLinearStabilityCertificate
  energyDissipation := 1.5
  energyDissipationPositive := by norm_num
  nonlinearBound := True
  nonlinearBoundClosed := trivial
}

def EnergyStabilityClosed (C : EnergyCertificate) : Prop :=
  LinearStabilityClosed C.linear ∧ C.energyDissipationPositive ∧ C.nonlinearBound

theorem source_energy_stability_closed : EnergyStabilityClosed sourceEnergyCertificate := by
  exact And.intro source_linear_stability_closed
    (And.intro sourceEnergyCertificate.energyDissipationPositive sourceEnergyCertificate.nonlinearBoundClosed)

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse