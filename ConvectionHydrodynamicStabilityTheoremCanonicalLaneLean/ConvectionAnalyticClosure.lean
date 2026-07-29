import ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.ConvectionAnalyticCertificate

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

def ConvectionAdmittedAnalyticClosure : Prop :=
  ConvectionAnalyticCertificateClosed sourceConvectionAnalyticCertificate ∧
  ConstrainedTheoremClosure analyticAdmissibleClass

def UnrestrictedClassicalConvectionBoundaryCarried : Prop :=
  formalizationCertificate.theoremBoundaryOpen = true ∧
  mathlibPDESubstrate.unrestrictedBoussinesqStackCarried = true

theorem convection_admitted_analytic_closure_checked :
    ConvectionAdmittedAnalyticClosure := by
  exact And.intro source_convection_analytic_certificate_closed
    (constrained_theorem_closure analyticAdmissibleClass)

theorem unrestricted_classical_convection_boundary_carried_checked :
    UnrestrictedClassicalConvectionBoundaryCarried := by
  exact And.intro rfl rfl

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse