import ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.ConvectionBridge

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

def ConstrainedConvectionClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_convection_endgame (A : AdmissibleClass) :
    ConstrainedConvectionClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse