import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

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
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  buoyancy := fun _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure BoussinesqFlow where
  velocity : VectorField
  temperature : ScalarField
  pressure : ScalarField
  viscosity : ℝ
  thermalDiffusivity : ℝ
  thermalExpansionCoeff : ℝ
  gravity : VectorField
  operators : BoussinesqOperators

def primitiveBoussinesqFlow : BoussinesqFlow := {
  velocity := zeroVectorField
  temperature := zeroScalarField
  pressure := zeroScalarField
  viscosity := 1
  thermalDiffusivity := 1
  thermalExpansionCoeff := 1
  gravity := fun _ _ => (0,0,0)
  operators := primitiveBoussinesqOperators
}

def Incompressible (F : BoussinesqFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def BoussinesqBalance (F : BoussinesqFlow) : Prop :=
  F.operators.timeDerivative F.velocity =
    F.operators.laplacian F.velocity +
    F.operators.buoyancy F.temperature

def TemperatureEquation (F : BoussinesqFlow) : Prop :=
  F.operators.timeDerivative (fun t x => F.temperature t x) =
    F.thermalDiffusivity * F.operators.laplacian (fun t x => F.temperature t x) ???

def BoussinesqEquationClosed (F : BoussinesqFlow) : Prop :=
  Incompressible F ∧ BoussinesqBalance F

theorem primitive_flow_incompressible_checked : Incompressible primitiveBoussinesqFlow := by rfl
theorem primitive_flow_boussinesq_balance_checked : BoussinesqBalance primitiveBoussinesqFlow := by rfl
theorem primitive_flow_equation_closed_checked : BoussinesqEquationClosed primitiveBoussinesqFlow :=
  And.intro primitive_flow_incompressible_checked primitive_flow_boussinesq_balance_checked

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse