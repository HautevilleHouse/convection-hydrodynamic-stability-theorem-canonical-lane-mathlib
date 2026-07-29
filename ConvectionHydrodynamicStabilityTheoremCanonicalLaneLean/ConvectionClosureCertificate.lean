import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.StabilityEndpointLayer

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

structure ConvectionClosureCertificate where
  endpoint : StabilityEndpointCertificate
  bridgeClosed : Prop
  gateClosed : Prop
  bridgeClosedProof : bridgeClosed
  gateClosedProof : gateClosed

def sourceConvectionClosureCertificate : ConvectionClosureCertificate := {
  endpoint := sourceStabilityEndpointCertificate
  bridgeClosed := bridgeClosed convectionAdmissibleClass
  gateClosed := gateClosed convectionAdmissibleClass
  bridgeClosedProof := bridge_from_admissible_class convectionAdmissibleClass
  gateClosedProof := gate_from_admissible_class convectionAdmissibleClass
}

def ConvectionClosureClosed (C : ConvectionClosureCertificate) : Prop :=
  StabilityEndpointClosed C.endpoint ∧ C.bridgeClosed ∧ C.gateClosed

theorem source_convection_closure_closed : ConvectionClosureClosed sourceConvectionClosureCertificate := by
  exact And.intro source_stability_endpoint_closed
    (And.intro sourceConvectionClosureCertificate.bridgeClosedProof sourceConvectionClosureCertificate.gateClosedProof)

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse