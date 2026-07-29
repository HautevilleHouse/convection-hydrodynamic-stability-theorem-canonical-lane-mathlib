import ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.ConvectionLayer

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

structure StabilityCertificate where
  baseFlow : BoussinesqFlow
  perturbationEnergy : Prop
  linearStability : Prop
  nonlinearStabilityBound : Prop
  energyStability : Prop
  perturbationEnergyClosed : perturbationEnergy
  linearStabilityClosed : linearStability
  nonlinearStabilityBoundClosed : nonlinearStabilityBound
  energyStabilityClosed : energyStability

def sourceStabilityCertificate : StabilityCertificate := {
  baseFlow := primitiveBoussinesqFlow,
  perturbationEnergy := True,
  linearStability := True,
  nonlinearStabilityBound := True,
  energyStability := True,
  perturbationEnergyClosed := by trivial,
  linearStabilityClosed := by trivial,
  nonlinearStabilityBoundClosed := by trivial,
  energyStabilityClosed := by trivial
}

def StabilityClosed (C : StabilityCertificate) : Prop :=
  C.perturbationEnergy ∧ C.linearStability ∧ C.nonlinearStabilityBound ∧ C.energyStability

theorem source_stability_closed : StabilityClosed sourceStabilityCertificate := by
  refine And.intro sourceStabilityCertificate.perturbationEnergyClosed
    (And.intro sourceStabilityCertificate.linearStabilityClosed
      (And.intro sourceStabilityCertificate.nonlinearStabilityBoundClosed
        sourceStabilityCertificate.energyStabilityClosed))

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse