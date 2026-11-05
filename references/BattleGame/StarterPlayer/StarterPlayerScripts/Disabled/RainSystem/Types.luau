--!strict
-- Types.luau — shared type definitions.

-- The only two states the rest of the system cares about.
export type RainState = "Exposed" | "Protected"

-- Fired by OcclusionDetector when cover status changes.
export type StateChangedHandler = (state: RainState, roofHit: RaycastResult?) -> ()

return {}