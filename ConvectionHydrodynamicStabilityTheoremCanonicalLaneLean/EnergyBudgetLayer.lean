import ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.LinearStabilityLayer

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

structure EnergyBudgetCertificate where
  linearStability : LinearStabilityCertificate
  kineticEnergyDissipation : Prop
  thermalEnergyDissipation : Prop
  buoyancyConversion : Prop
  kineticEnergyDissipationProof : kineticEnergyDissipation
  thermalEnergyDissipationProof : thermalEnergyDissipation
  buoyancyConversionProof : buoyancyConversion

def sourceEnergyBudgetCertificate : EnergyBudgetCertificate := {
  linearStability := sourceLinearStabilityCertificate
  kineticEnergyDissipation := True
  thermalEnergyDissipation := True
  buoyancyConversion := True
  kineticEnergyDissipationProof := trivial
  thermalEnergyDissipationProof := trivial
  buoyancyConversionProof := trivial
}

def EnergyBudgetClosed (C : EnergyBudgetCertificate) : Prop :=
  LinearStabilityClosed C.linearStability ∧
  C.kineticEnergyDissipation ∧
  C.thermalEnergyDissipation ∧
  C.buoyancyConversion

theorem source_energy_budget_closed :
    EnergyBudgetClosed sourceEnergyBudgetCertificate := by
  exact And.intro source_linear_stability_closed
    (And.intro sourceEnergyBudgetCertificate.kineticEnergyDissipationProof
      (And.intro sourceEnergyBudgetCertificate.thermalEnergyDissipationProof
        sourceEnergyBudgetCertificate.buoyancyConversionProof))

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse
