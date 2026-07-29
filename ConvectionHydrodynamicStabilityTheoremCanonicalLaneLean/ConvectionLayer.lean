import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

abbrev Domain3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Domain3 → ℝ
abbrev VectorField := Time → Domain3 → Domain3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure BoussinesqOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  buoyancy : ScalarField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveBoussinesqOperators : BoussinesqOperators := {
  divergence := fun _ => zeroScalarField,
  gradient := fun _ => zeroVectorField,
  laplacian := fun u => u,
  timeDerivative := fun _ => zeroVectorField,
  transport := fun _ => zeroVectorField,
  buoyancy := fun _ => zeroVectorField,
  pressureProjection := fun u => u,
  pressureProjectionIdempotent := by intro u; rfl
}

structure BoussinesqFlow where
  velocity : VectorField
  temperature : ScalarField
  viscosity : ℝ
  thermalDiffusivity : ℝ
  thermalExpansion : ℝ
  gravity : Domain3
  operators : BoussinesqOperators

def primitiveBoussinesqFlow : BoussinesqFlow := {
  velocity := zeroVectorField,
  temperature := zeroScalarField,
  viscosity := 1,
  thermalDiffusivity := 1,
  thermalExpansion := 1,
  gravity := fun _ => 0,
  operators := primitiveBoussinesqOperators
}

def Incompressible (F : BoussinesqFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def TemperatureEquationClosed (F : BoussinesqFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def BuoyancyForced (F : BoussinesqFlow) : Prop :=
  F.operators.buoyancy F.temperature = F.operators.gradient F.temperature

def ConvectionEquationClosed (F : BoussinesqFlow) : Prop :=
  Incompressible F ∧ TemperatureEquationClosed F ∧ BuoyancyForced F

theorem primitive_flow_convection_equation_closed_checked :
    ConvectionEquationClosed primitiveBoussinesqFlow := by
  refine And.intro ?_ (And.intro ?_ ?_)
  · rfl
  · rfl
  · rfl

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse