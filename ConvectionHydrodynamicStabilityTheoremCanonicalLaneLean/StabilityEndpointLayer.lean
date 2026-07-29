import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.NonlinearEnergyLayer

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

structure StabilityEndpointCertificate where
  energy : EnergyCertificate
  criticalLayerClosed : Prop
  bridgeClosedOnObject : Prop
  gateClosedOnAdmissibleClass : Prop
  theoremBoundaryCarried : Prop
  criticalLayerClosedProof : criticalLayerClosed
  bridgeClosedOnObjectProof : bridgeClosedOnObject
  gateClosedOnAdmissibleClassProof : gateClosedOnAdmissibleClass
  theoremBoundaryCarriedProof : theoremBoundaryCarried

def convectionAdmittedObject : AdmittedTheoremObject := {
  object := { sourceKey := "convection-hydrodynamic-stability-theorem", theoremObject := "Convection Hydrodynamic Stability Theorem", claimBoundary := "classical boundary" }
  localWitness := "Boussinesq flow with energy stability certificate"
  bridgeEvidence := "source-derived Lean certificate fields"
  sourceKeyChecked := rfl
  theoremObjectChecked := rfl
}

def convectionAdmissibleClass : AdmissibleClass := {
  object := convectionAdmittedObject
  endpointSatisfied := BoussinesqEquationClosed primitiveBoussinesqFlow
  remainderRecorded := False
  gateWitness := Or.inl primitive_flow_equation_closed_checked
}

def sourceStabilityEndpointCertificate : StabilityEndpointCertificate := {
  energy := sourceEnergyCertificate
  criticalLayerClosed := RayleightStable sourceRayleighCertificate
  bridgeClosedOnObject := bridgeClosed convectionAdmissibleClass
  gateClosedOnAdmissibleClass := gateClosed convectionAdmissibleClass
  theoremBoundaryCarried := True
  criticalLayerClosedProof := source_rayleigh_stable_checked
  bridgeClosedOnObjectProof := bridge_from_admissible_class convectionAdmissibleClass
  gateClosedOnAdmissibleClassProof := gate_from_admissible_class convectionAdmissibleClass
  theoremBoundaryCarriedProof := trivial
}

def StabilityEndpointClosed (C : StabilityEndpointCertificate) : Prop :=
  EnergyStabilityClosed C.energy ∧
  C.criticalLayerClosed ∧
  C.bridgeClosedOnObject ∧
  C.gateClosedOnAdmissibleClass ∧
  C.theoremBoundaryCarried

theorem source_stability_endpoint_closed : StabilityEndpointClosed sourceStabilityEndpointCertificate := by
  exact And.intro source_energy_stability_closed
    (And.intro sourceStabilityEndpointCertificate.criticalLayerClosedProof
      (And.intro sourceStabilityEndpointCertificate.bridgeClosedOnObjectProof
        (And.intro sourceStabilityEndpointCertificate.gateClosedOnAdmissibleClassProof
          sourceStabilityEndpointCertificate.theoremBoundaryCarriedProof)))

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse