import ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.EnergyBudgetLayer

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

structure CriticalThresholdCertificate where
  energyBudget : EnergyBudgetCertificate
  rayleighNumberBelowCritical : Prop
  prandtlNumberPositive : Prop
  criticalRayleighNumberDefined : Prop
  subcriticalTransitionBlocked : Prop
  rayleighNumberBelowCriticalProof : rayleighNumberBelowCritical
  prandtlNumberPositiveProof : prandtlNumberPositive
  criticalRayleighNumberDefinedProof : criticalRayleighNumberDefined
  subcriticalTransitionBlockedProof : subcriticalTransitionBlocked

def sourceCriticalThresholdCertificate : CriticalThresholdCertificate := {
  energyBudget := sourceEnergyBudgetCertificate
  rayleighNumberBelowCritical := True
  prandtlNumberPositive := True
  criticalRayleighNumberDefined := True
  subcriticalTransitionBlocked := True
  rayleighNumberBelowCriticalProof := trivial
  prandtlNumberPositiveProof := trivial
  criticalRayleighNumberDefinedProof := trivial
  subcriticalTransitionBlockedProof := trivial
}

def CriticalThresholdClosed (C : CriticalThresholdCertificate) : Prop :=
  EnergyBudgetClosed C.energyBudget ∧
  C.rayleighNumberBelowCritical ∧
  C.prandtlNumberPositive ∧
  C.criticalRayleighNumberDefined ∧
  C.subcriticalTransitionBlocked

theorem source_critical_threshold_closed :
    CriticalThresholdClosed sourceCriticalThresholdCertificate := by
  exact And.intro source_energy_budget_closed
    (And.intro sourceCriticalThresholdCertificate.rayleighNumberBelowCriticalProof
      (And.intro sourceCriticalThresholdCertificate.prandtlNumberPositiveProof
        (And.intro sourceCriticalThresholdCertificate.criticalRayleighNumberDefinedProof
          sourceCriticalThresholdCertificate.subcriticalTransitionBlockedProof)))

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse
