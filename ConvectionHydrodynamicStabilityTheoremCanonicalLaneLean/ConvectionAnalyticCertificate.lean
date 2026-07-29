import ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.RegularityEndpointLayer

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

structure ConvectionAnalyticCertificate where
  substrate : MathlibPDESubstrate
  operatorsClosed : Prop
  weakLayerClosed : Prop
  energyLayerClosed : Prop
  compactnessLayerClosed : Prop
  endpointLayerClosed : Prop
  canonicalCarriageImported : Prop
  operatorsClosedProof : operatorsClosed
  weakLayerClosedProof : weakLayerClosed
  energyLayerClosedProof : energyLayerClosed
  compactnessLayerClosedProof : compactnessLayerClosed
  endpointLayerClosedProof : endpointLayerClosed
  canonicalCarriageImportedProof : canonicalCarriageImported

def sourceConvectionAnalyticCertificate : ConvectionAnalyticCertificate := {
  substrate := mathlibPDESubstrate
  operatorsClosed := BoussinesqSystemClosed primitiveBoussinesqFlow
  weakLayerClosed := WeakSolutionLayerClosed sourceWeakSolutionLayerCertificate
  energyLayerClosed := EnergyLayerClosed sourceEnergyLayerCertificate
  compactnessLayerClosed := CompactnessLayerClosed sourceCompactnessLayerCertificate
  endpointLayerClosed := RegularityEndpointClosed sourceRegularityEndpointCertificate
  canonicalCarriageImported := commonCoreProjectionLawAvailable ∧ commonCoreCarriageLawAvailable ∧ commonCoreIdempotenceAvailable
  operatorsClosedProof := primitive_boussinesq_system_closed_checked
  weakLayerClosedProof := source_weak_solution_layer_closed
  energyLayerClosedProof := source_energy_layer_closed
  compactnessLayerClosedProof := source_compactness_layer_closed
  endpointLayerClosedProof := source_regularity_endpoint_closed
  canonicalCarriageImportedProof := And.intro mathlib_common_core_projection_law_checked
    (And.intro mathlib_common_core_carriage_law_checked mathlib_common_core_idempotence_checked)
}

def ConvectionAnalyticCertificateClosed (C : ConvectionAnalyticCertificate) : Prop :=
  C.operatorsClosed ∧
  C.weakLayerClosed ∧
  C.energyLayerClosed ∧
  C.compactnessLayerClosed ∧
  C.endpointLayerClosed ∧
  C.canonicalCarriageImported

theorem source_convection_analytic_certificate_closed :
    ConvectionAnalyticCertificateClosed sourceConvectionAnalyticCertificate := by
  exact And.intro sourceConvectionAnalyticCertificate.operatorsClosedProof
    (And.intro sourceConvectionAnalyticCertificate.weakLayerClosedProof
      (And.intro sourceConvectionAnalyticCertificate.energyLayerClosedProof
        (And.intro sourceConvectionAnalyticCertificate.compactnessLayerClosedProof
          (And.intro sourceConvectionAnalyticCertificate.endpointLayerClosedProof
            sourceConvectionAnalyticCertificate.canonicalCarriageImportedProof))))

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse