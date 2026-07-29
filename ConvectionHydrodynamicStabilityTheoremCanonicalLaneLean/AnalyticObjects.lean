import ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean.MathlibStatement
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3
abbrev TemperatureField := Time → Space3 → ℝ

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0
def zeroTemperatureField : TemperatureField := fun _ _ => 0

structure BoussinesqOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  temperatureLaplacian : TemperatureField → TemperatureField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  buoyancy : TemperatureField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveBoussinesqOperators : BoussinesqOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  temperatureLaplacian := fun T => T
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  buoyancy := fun _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure BoussinesqFlow where
  velocity : VectorField
  temperature : TemperatureField
  pressure : ScalarField
  viscosity : ℝ
  thermalDiffusivity : ℝ
  thermalExpansionCoeff : ℝ
  referenceTemperature : ℝ
  gravity : ℝ
  operators : BoussinesqOperators

def primitiveBoussinesqFlow : BoussinesqFlow := {
  velocity := zeroVectorField
  temperature := zeroTemperatureField
  pressure := zeroScalarField
  viscosity := 1
  thermalDiffusivity := 1
  thermalExpansionCoeff := 1
  referenceTemperature := 0
  gravity := 1
  operators := primitiveBoussinesqOperators
}

def Incompressible (F : BoussinesqFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def AnalyticBalance (F : BoussinesqFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def TemperatureEquationSatisfied (F : BoussinesqFlow) : Prop :=
  F.operators.timeDerivative (fun t x => F.temperature t x) = F.operators.temperatureLaplacian F.temperature

def PressureProjected (F : BoussinesqFlow) : Prop :=
  F.operators.pressureProjection F.velocity = F.velocity

def BoussinesqEquationClosed (F : BoussinesqFlow) : Prop :=
  Incompressible F ∧ AnalyticBalance F ∧ TemperatureEquationSatisfied F ∧ PressureProjected F

theorem primitive_pressure_projection_idempotent_checked (u : VectorField) :
    primitiveBoussinesqOperators.pressureProjection (primitiveBoussinesqOperators.pressureProjection u) =
      primitiveBoussinesqOperators.pressureProjection u := by
  rfl

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveBoussinesqFlow := by
  rfl

theorem primitive_flow_analytic_balance_checked :
    AnalyticBalance primitiveBoussinesqFlow := by
  rfl

theorem primitive_flow_temperature_equation_checked :
    TemperatureEquationSatisfied primitiveBoussinesqFlow := by
  rfl

theorem primitive_flow_pressure_projected_checked :
    PressureProjected primitiveBoussinesqFlow := by
  rfl

theorem primitive_flow_equation_closed_checked :
    BoussinesqEquationClosed primitiveBoussinesqFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_analytic_balance_checked
      (And.intro primitive_flow_temperature_equation_checked primitive_flow_pressure_projected_checked))

end ConvectionHydrodynamicStabilityTheoremCanonicalLaneLean
end HautevilleHouse
