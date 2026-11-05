--!strict
-- ServerStorage > SBGModules > DebreeService > Split   (ModuleScript, server only)
--
-- Pure geometry, no Instances. Divides one block-shaped part into grid cells around a
-- hit volume the way ShatterBox does (KD halving along grid lines):
--   * a box that doesn't touch the hit is kept whole            -> Leftover
--   * a box that touches it is cut in half along its longest axis, again and again,
--     down to single grid cells
--   * a single cell that touches the hit:
--       Core  if the hit reaches far enough into it (Reach), or covers its center (breaks)
--       Edge  if the hit only grazes it                                          (stays)
--   * a box that is completely inside the hit becomes Core cells straight away
--   * with Above, only cells that stick up above that height can break; boxes below it are
--     kept whole like boxes the hit doesn't touch
--   * with a Hollow, cells whose center is inside it stay, so only the shell between it and the
--     hit's outer edge breaks; boxes completely inside it are kept whole
-- The grid is the part's own: Counts cells per axis, each Size / Counts big, so cells
-- always tile the part exactly (2 x 3 x 43 at grid 2 -> 1 x 1 x 21 cells of 2 x 3 x 2.048).
-- All the math happens in the part's own space, so rotated parts split correctly.

local Split = {}

export type Shape = "Box" | "Ball" | "Oval"
-- Hollow: the size of a second volume, same shape and CFrame, inside which nothing breaks
export type Hit = { Shape: Shape, CFrame: CFrame, Size: Vector3, Hollow: Vector3? }
export type Box = { CFrame: CFrame, Size: Vector3 }
export type Result = {
	Core: { Box },
	Edge: { Box },
	Leftover: { Box },
	Counts: Vector3, -- cells per axis actually used (the grid may have been coarsened)
	CellSize: Vector3,
}

-- Boxes whose faces only touch (overlap thinner than this) don't count as intersecting.
local TOUCH = 1e-4
-- Most sub-boxes Divide checks when it keeps what's left of a part in one block (OneBlock).
local MAX_BOX_SEARCH = 200000
-- Added to |rotation| terms so near-parallel axes don't produce false separations (Ericson).
local PARALLEL_EPSILON = 1e-6

-- The hit volume, expressed in the part's own space.
type LocalHit = {
	Ball: boolean,
	Oval: boolean, -- Oval: the box's shape rounded off (U, E as axes and radii)
	A: { { number } }, -- Oval: inside when d . (A d) < 1, d = point - Center
	Center: Vector3,
	Radius: number, -- Ball
	U: { Vector3 }, -- Box: its three unit axes
	E: { number }, -- Box: half extents along U
	R: { { number } }, -- Box: R[i][j] = component i of U[j]
	AbsR: { { number } },
	BoundsHalf: Vector3, -- half size of the hit's axis-aligned bounds
}

local function ToLocalHit(PartCFrame: CFrame, Hit: Hit): LocalHit
	local Relative = PartCFrame:ToObjectSpace(Hit.CFrame)
	local Center = Relative.Position
	if Hit.Shape == "Ball" then
		-- Roblox balls use the smallest axis as the diameter
		local Radius = math.min(Hit.Size.X, Hit.Size.Y, Hit.Size.Z) / 2
		return {
			Ball = true,
			Oval = false,
			Center = Center,
			Radius = Radius,
			U = {},
			E = {},
			R = {},
			AbsR = {},
			A = {},
			BoundsHalf = Vector3.one * Radius,
		}
	end

	-- Box, and Oval (the box's shape with everything rounded off: same center and axes, half
	-- sizes as radii). An Oval keeps the box fields too: they're its bounding box, which
	-- Intersects uses as a cheap first test.
	local U = { Relative.XVector, Relative.YVector, Relative.ZVector }
	local E = { Hit.Size.X / 2, Hit.Size.Y / 2, Hit.Size.Z / 2 }
	local R, AbsR = {}, {}
	for I = 1, 3 do
		R[I], AbsR[I] = {}, {}
		for J = 1, 3 do
			local Component = if I == 1 then U[J].X elseif I == 2 then U[J].Y else U[J].Z
			R[I][J] = Component
			AbsR[I][J] = math.abs(Component) + PARALLEL_EPSILON
		end
	end

	local Oval = Hit.Shape == "Oval"
	local A: { { number } } = {}
	local BoundsHalf: Vector3
	if Oval then
		-- The oval in part space: inside when d . (A d) < 1
		local E2 = { E[1] * E[1], E[2] * E[2], E[3] * E[3] }
		for I = 1, 3 do
			A[I] = {}
			for K = 1, 3 do
				A[I][K] = R[I][1] * R[K][1] / E2[1] + R[I][2] * R[K][2] / E2[2] + R[I][3] * R[K][3] / E2[3]
			end
		end
		-- Exact bounds of a rotated oval (tighter than its box's)
		BoundsHalf = Vector3.new(
			math.sqrt((E[1] * R[1][1]) ^ 2 + (E[2] * R[1][2]) ^ 2 + (E[3] * R[1][3]) ^ 2),
			math.sqrt((E[1] * R[2][1]) ^ 2 + (E[2] * R[2][2]) ^ 2 + (E[3] * R[2][3]) ^ 2),
			math.sqrt((E[1] * R[3][1]) ^ 2 + (E[2] * R[3][2]) ^ 2 + (E[3] * R[3][3]) ^ 2)
		)
	else
		BoundsHalf = Vector3.new(
			E[1] * AbsR[1][1] + E[2] * AbsR[1][2] + E[3] * AbsR[1][3],
			E[1] * AbsR[2][1] + E[2] * AbsR[2][2] + E[3] * AbsR[2][3],
			E[1] * AbsR[3][1] + E[2] * AbsR[3][2] + E[3] * AbsR[3][3]
		)
	end
	return {
		Ball = false,
		Oval = Oval,
		Center = Center,
		Radius = 0,
		U = U,
		E = E,
		R = R,
		AbsR = AbsR,
		A = A,
		BoundsHalf = BoundsHalf,
	}
end

-- Oval: d . (A d), with d = a point minus the oval's center (part space). < 1 inside, 1 on the surface.
local function OvalValue(DX: number, DY: number, DZ: number, A: { { number } }): number
	return DX * (A[1][1] * DX + A[1][2] * DY + A[1][3] * DZ)
		+ DY * (A[2][1] * DX + A[2][2] * DY + A[2][3] * DZ)
		+ DZ * (A[3][1] * DX + A[3][2] * DY + A[3][3] * DZ)
end

-- Steps of the search below. Each step only gets closer; a 40x20x40 oval needs 1 to 3.
local OVAL_STEPS = 8

-- Does the axis-aligned box (center C, half size H) overlap the oval? Walks to the point of
-- the box nearest the oval's center (nearest in the oval's own stretched distance), one axis at
-- a time, and stops as soon as a point is inside. Every point it tries is in the box, so a
-- "yes" is always real.
local function OvalIntersects(C: Vector3, H: Vector3, L: LocalHit): boolean
	local A, O = L.A, L.Center
	local LX, LY, LZ = C.X - H.X - O.X, C.Y - H.Y - O.Y, C.Z - H.Z - O.Z
	local HX, HY, HZ = C.X + H.X - O.X, C.Y + H.Y - O.Y, C.Z + H.Z - O.Z
	local DX, DY, DZ = math.clamp(0, LX, HX), math.clamp(0, LY, HY), math.clamp(0, LZ, HZ)
	for _ = 1, OVAL_STEPS do
		if OvalValue(DX, DY, DZ, A) < 1 then
			return true
		end
		DX = math.clamp(-(A[1][2] * DY + A[1][3] * DZ) / A[1][1], LX, HX)
		DY = math.clamp(-(A[2][1] * DX + A[2][3] * DZ) / A[2][2], LY, HY)
		DZ = math.clamp(-(A[3][1] * DX + A[3][2] * DY) / A[3][3], LZ, HZ)
	end
	return OvalValue(DX, DY, DZ, A) < 1
end


-- Does the axis-aligned box (center C, half size H) overlap the hit?
-- Box hits use the separating axis test (Ericson, "Real-Time Collision Detection" 4.4.1)
-- with the part-space box as the axis-aligned one.
local function Intersects(C: Vector3, H: Vector3, L: LocalHit): boolean
	if L.Ball then
		local Closest = L.Center:Max(C - H):Min(C + H)
		return (Closest - L.Center).Magnitude < L.Radius - TOUCH
	end

	local T = L.Center - C
	local t = { T.X, T.Y, T.Z }
	local h = { H.X, H.Y, H.Z }
	local E, R, A = L.E, L.R, L.AbsR

	-- The box's own three axes
	for I = 1, 3 do
		if math.abs(t[I]) > h[I] + E[1] * A[I][1] + E[2] * A[I][2] + E[3] * A[I][3] - TOUCH then
			return false
		end
	end
	-- The hit's three axes
	for J = 1, 3 do
		local Projected = t[1] * R[1][J] + t[2] * R[2][J] + t[3] * R[3][J]
		if math.abs(Projected) > h[1] * A[1][J] + h[2] * A[2][J] + h[3] * A[3][J] + E[J] - TOUCH then
			return false
		end
	end
	-- The nine cross products (no TOUCH here: these axes can be degenerate)
	if math.abs(t[3] * R[2][1] - t[2] * R[3][1]) > h[2] * A[3][1] + h[3] * A[2][1] + E[2] * A[1][3] + E[3] * A[1][2] then
		return false
	end
	if math.abs(t[3] * R[2][2] - t[2] * R[3][2]) > h[2] * A[3][2] + h[3] * A[2][2] + E[1] * A[1][3] + E[3] * A[1][1] then
		return false
	end
	if math.abs(t[3] * R[2][3] - t[2] * R[3][3]) > h[2] * A[3][3] + h[3] * A[2][3] + E[1] * A[1][2] + E[2] * A[1][1] then
		return false
	end
	if math.abs(t[1] * R[3][1] - t[3] * R[1][1]) > h[1] * A[3][1] + h[3] * A[1][1] + E[2] * A[2][3] + E[3] * A[2][2] then
		return false
	end
	if math.abs(t[1] * R[3][2] - t[3] * R[1][2]) > h[1] * A[3][2] + h[3] * A[1][2] + E[1] * A[2][3] + E[3] * A[2][1] then
		return false
	end
	if math.abs(t[1] * R[3][3] - t[3] * R[1][3]) > h[1] * A[3][3] + h[3] * A[1][3] + E[1] * A[2][2] + E[2] * A[2][1] then
		return false
	end
	if math.abs(t[2] * R[1][1] - t[1] * R[2][1]) > h[1] * A[2][1] + h[2] * A[1][1] + E[2] * A[3][3] + E[3] * A[3][2] then
		return false
	end
	if math.abs(t[2] * R[1][2] - t[1] * R[2][2]) > h[1] * A[2][2] + h[2] * A[1][2] + E[1] * A[3][3] + E[3] * A[3][1] then
		return false
	end
	if math.abs(t[2] * R[1][3] - t[1] * R[2][3]) > h[1] * A[2][3] + h[2] * A[1][3] + E[1] * A[3][2] + E[2] * A[3][1] then
		return false
	end

	-- Box: overlapping. Oval: it overlaps the oval's bounding box; now the oval itself
	return not L.Oval or OvalIntersects(C, H, L)
end

-- Is the axis-aligned box (center C, half size H) completely inside the hit?
local function Contains(C: Vector3, H: Vector3, L: LocalHit): boolean
	local D = C - L.Center

	if L.Oval then
		-- an oval is convex: the box is inside it if all 8 corners are
		for SX = -1, 1, 2 do
			for SY = -1, 1, 2 do
				for SZ = -1, 1, 2 do
					if OvalValue(D.X + SX * H.X, D.Y + SY * H.Y, D.Z + SZ * H.Z, L.A) > 1 + TOUCH then
						return false
					end
				end
			end
		end
		return true
	end

	if L.Ball then
		local Far = Vector3.new(math.abs(D.X) + H.X, math.abs(D.Y) + H.Y, math.abs(D.Z) + H.Z)
		return Far.Magnitude <= L.Radius + TOUCH
	end

	for J = 1, 3 do
		local Axis = L.U[J]
		local Reach = H.X * math.abs(Axis.X) + H.Y * math.abs(Axis.Y) + H.Z * math.abs(Axis.Z)
		if math.abs(D:Dot(Axis)) + Reach > L.E[J] + TOUCH then
			return false
		end
	end
	return true
end

-- Is the point P (part space) inside the hit?
local function ContainsPoint(P: Vector3, L: LocalHit): boolean
	local D = P - L.Center
	if L.Oval then
		return OvalValue(D.X, D.Y, D.Z, L.A) <= 1
	end
	if L.Ball then
		return D.Magnitude <= L.Radius
	end
	for J = 1, 3 do
		if math.abs(D:Dot(L.U[J])) > L.E[J] then
			return false
		end
	end
	return true
end

-- Cells per axis for a part of Size at GridSize: at least 1, and they tile the part exactly.
function Split.CountsFor(Size: Vector3, GridSize: number): Vector3
	return Vector3.new(
		math.max(1, math.floor(Size.X / GridSize + 1e-6)),
		math.max(1, math.floor(Size.Y / GridSize + 1e-6)),
		math.max(1, math.floor(Size.Z / GridSize + 1e-6))
	)
end

-- Cells per axis for a leftover box that was cut from a grid of CellSize, so that
-- re-splitting it lines up with the cells around it.
function Split.CountsFromCell(Size: Vector3, CellSize: Vector3): Vector3
	return Vector3.new(
		math.max(1, math.round(Size.X / CellSize.X)),
		math.max(1, math.round(Size.Y / CellSize.Y)),
		math.max(1, math.round(Size.Z / CellSize.Z))
	)
end

-- Half the side of an axis-aligned cube (in part space) that fits inside the volume, around its
-- center: the cells inside it can't break when the volume is a Hollow.
local function InnerCubeHalf(L: LocalHit): number
	if L.Ball then
		return L.Radius / math.sqrt(3)
	end
	if L.Oval then
		return math.min(L.E[1], L.E[2], L.E[3]) / math.sqrt(3) -- inside the ball of its smallest radius
	end
	local Half = math.huge
	for J = 1, 3 do
		Half = math.min(Half, L.E[J] / (L.AbsR[1][J] + L.AbsR[2][J] + L.AbsR[3][J]))
	end
	return Half
end

-- How many grid cells the hit's bounds cover inside the part (an upper bound on debris),
-- leaving out the cells surely inside the Hollow.
local function EstimateCells(PartSize: Vector3, Counts: Vector3, L: LocalHit, Hollow: LocalHit?): number
	local Cell = PartSize / Counts
	local Half = PartSize / 2
	local function AxisCount(Center: number, BoundsHalf: number, PartHalf: number, CellLength: number, Count: number): number
		local First = math.clamp(math.floor((Center - BoundsHalf + PartHalf) / CellLength), 0, Count)
		local Last = math.clamp(math.ceil((Center + BoundsHalf + PartHalf) / CellLength), 0, Count)
		return math.max(0, Last - First)
	end
	-- cells lying completely within [Center - InnerHalf, Center + InnerHalf] on one axis
	local function AxisInside(Center: number, InnerHalf: number, PartHalf: number, CellLength: number, Count: number): number
		local First = math.clamp(math.ceil((Center - InnerHalf + PartHalf) / CellLength), 0, Count)
		local Last = math.clamp(math.floor((Center + InnerHalf + PartHalf) / CellLength), 0, Count)
		return math.max(0, Last - First)
	end
	local Total = AxisCount(L.Center.X, L.BoundsHalf.X, Half.X, Cell.X, Counts.X)
		* AxisCount(L.Center.Y, L.BoundsHalf.Y, Half.Y, Cell.Y, Counts.Y)
		* AxisCount(L.Center.Z, L.BoundsHalf.Z, Half.Z, Cell.Z, Counts.Z)
	if Hollow then
		local Inner = InnerCubeHalf(Hollow)
		Total -= AxisInside(Hollow.Center.X, Inner, Half.X, Cell.X, Counts.X)
			* AxisInside(Hollow.Center.Y, Inner, Half.Y, Cell.Y, Counts.Y)
			* AxisInside(Hollow.Center.Z, Inner, Half.Z, Cell.Z, Counts.Z)
	end
	return math.max(0, Total)
end

-- Splits a part. Returns nil when the hit doesn't really overlap the part.
--   PartCFrame, PartSize: the part (block) being split
--   Counts: cells per axis (Split.CountsFor / Split.CountsFromCell)
--   Hit: the hit volume in world space
--   MaxCells: if the hit would cover more cells than this, the grid is halved until it doesn't
--   OneBlock: if any cell breaks, what stays is one single box (no Edge, at most one Leftover):
--     the biggest box of cells the hit doesn't break, and every cell outside it breaks too.
--     For see-through parts, where the joins between leftover blocks would show.
--   Reach: a cell breaks once the hit reaches this far into it, as a fraction of the cell's
--     size on each side it overlaps (0 = any touch, 0.5 or nil = only if it covers the center)
--   Above: a world height. Only cells that stick up above it (by more than Reach of their own
--     height) can break; everything lower stays, even inside the hit. nil = no limit
--   Hit.Hollow: cells whose center is inside it stay (see the top). nil = none
function Split.Divide(
	PartCFrame: CFrame,
	PartSize: Vector3,
	Counts: Vector3,
	Hit: Hit,
	MaxCells: number,
	OneBlock: boolean?,
	Reach: number?,
	Above: number?
): Result?
	PartCFrame = PartCFrame:Orthonormalize()
	local L = ToLocalHit(PartCFrame, Hit)
	local HollowSize = Hit.Hollow
	local LH: LocalHit? = if HollowSize
		then ToLocalHit(PartCFrame, { Shape = Hit.Shape, CFrame = Hit.CFrame, Size = HollowSize })
		else nil
	-- The hit has to touch the cell shrunk by Reach on every side
	local Fraction = math.clamp(Reach or 0.5, 0, 0.5)
	local Inner = 1 - 2 * Fraction

	if not Intersects(Vector3.zero, PartSize / 2, L) or (LH and Contains(Vector3.zero, PartSize / 2, LH)) then
		return nil
	end

	local NX, NY, NZ = Counts.X, Counts.Y, Counts.Z
	while EstimateCells(PartSize, Vector3.new(NX, NY, NZ), L, LH) > MaxCells and (NX > 1 or NY > 1 or NZ > 1) do
		NX, NY, NZ = math.max(1, NX // 2), math.max(1, NY // 2), math.max(1, NZ // 2)
	end

	local CellSize = PartSize / Vector3.new(NX, NY, NZ)
	local CX, CY, CZ = CellSize.X, CellSize.Y, CellSize.Z
	local MinCorner = -PartSize / 2

	-- Above: a cell can break only if its top is higher than Line. Heights are in world space,
	-- so tilted parts work too.
	local UpX, UpY, UpZ = math.abs(PartCFrame.XVector.Y), math.abs(PartCFrame.YVector.Y), math.abs(PartCFrame.ZVector.Y)
	local function VerticalHalf(Half: Vector3): number
		return UpX * Half.X + UpY * Half.Y + UpZ * Half.Z
	end
	local CellUp = VerticalHalf(CellSize / 2) -- half a cell's height
	local Line = if Above then Above + 2 * CellUp * Fraction else -math.huge
	local function CellTop(X: number, Y: number, Z: number): number
		local Center = MinCorner + Vector3.new((X + 0.5) * CX, (Y + 0.5) * CY, (Z + 0.5) * CZ)
		return PartCFrame:PointToWorldSpace(Center).Y + CellUp
	end
	local function InHollow(X: number, Y: number, Z: number): boolean
		return LH ~= nil and ContainsPoint(MinCorner + Vector3.new((X + 0.5) * CX, (Y + 0.5) * CY, (Z + 0.5) * CZ), LH)
	end

	local Core: { Box }, Edge: { Box }, Leftover: { Box } = {}, {}, {}
	local Broken: { [number]: boolean } = {} -- Core cells by index, for OneBlock

	local function CellIndex(X: number, Y: number, Z: number): number
		return X + NX * (Y + NY * Z)
	end

	local function Emit(List: { Box }, X0: number, Y0: number, Z0: number, X1: number, Y1: number, Z1: number)
		local Low = MinCorner + Vector3.new(X0 * CX, Y0 * CY, Z0 * CZ)
		local High = MinCorner + Vector3.new(X1 * CX, Y1 * CY, Z1 * CZ)
		table.insert(List, {
			CFrame = PartCFrame * CFrame.new((Low + High) / 2),
			Size = High - Low,
		})
	end

	-- Depth-first over integer cell ranges [X0, X1) x [Y0, Y1) x [Z0, Z1)
	local Stack: { { number } } = { { 0, 0, 0, NX, NY, NZ } }
	while #Stack > 0 do
		local Range = table.remove(Stack) :: { number }
		local X0, Y0, Z0, X1, Y1, Z1 = Range[1], Range[2], Range[3], Range[4], Range[5], Range[6]
		local Low = MinCorner + Vector3.new(X0 * CX, Y0 * CY, Z0 * CZ)
		local High = MinCorner + Vector3.new(X1 * CX, Y1 * CY, Z1 * CZ)
		local Center, Half = (Low + High) / 2, (High - Low) / 2
		-- Above: how high the tops of the box's highest and lowest cells are
		local HighestTop, LowestTop = math.huge, math.huge
		if Above then
			local Y, Up = PartCFrame:PointToWorldSpace(Center).Y, VerticalHalf(Half)
			HighestTop, LowestTop = Y + Up, Y - Up + 2 * CellUp
		end

		if HighestTop <= Line or not Intersects(Center, Half, L) or (LH and Contains(Center, Half, LH)) then
			Emit(Leftover, X0, Y0, Z0, X1, Y1, Z1)
		elseif X1 - X0 == 1 and Y1 - Y0 == 1 and Z1 - Z0 == 1 then
			if LH and ContainsPoint(Center, LH) then
				Emit(Leftover, X0, Y0, Z0, X1, Y1, Z1) -- inside the Hollow: stays
			elseif ContainsPoint(Center, L) or (Inner > 0 and Intersects(Center, Half * Inner, L)) then
				Emit(Core, X0, Y0, Z0, X1, Y1, Z1)
				Broken[CellIndex(X0, Y0, Z0)] = true
			else
				Emit(Edge, X0, Y0, Z0, X1, Y1, Z1)
			end
		elseif LowestTop > Line and Contains(Center, Half, L) and not (LH and Intersects(Center, Half, LH)) then
			for X = X0, X1 - 1 do
				for Y = Y0, Y1 - 1 do
					for Z = Z0, Z1 - 1 do
						Emit(Core, X, Y, Z, X + 1, Y + 1, Z + 1)
						Broken[CellIndex(X, Y, Z)] = true
					end
				end
			end
		else
			-- Cut along the longest axis (in studs) that is more than one cell long
			local LX = if X1 - X0 > 1 then (X1 - X0) * CX else -1
			local LY = if Y1 - Y0 > 1 then (Y1 - Y0) * CY else -1
			local LZ = if Z1 - Z0 > 1 then (Z1 - Z0) * CZ else -1
			if LX >= LY and LX >= LZ then
				local Mid = X0 + (X1 - X0) // 2
				table.insert(Stack, { X0, Y0, Z0, Mid, Y1, Z1 })
				table.insert(Stack, { Mid, Y0, Z0, X1, Y1, Z1 })
			elseif LY >= LZ then
				local Mid = Y0 + (Y1 - Y0) // 2
				table.insert(Stack, { X0, Y0, Z0, X1, Mid, Z1 })
				table.insert(Stack, { X0, Mid, Z0, X1, Y1, Z1 })
			else
				local Mid = Z0 + (Z1 - Z0) // 2
				table.insert(Stack, { X0, Y0, Z0, X1, Y1, Mid })
				table.insert(Stack, { X0, Y0, Mid, X1, Y1, Z1 })
			end
		end
	end

	local function Triangle(N: number): number
		return N * (N + 1) // 2 -- how many [A, B) ranges fit in N cells
	end
	if OneBlock and #Core > 0 and Triangle(NX) * Triangle(NY) * Triangle(NZ) <= MAX_BOX_SEARCH then
		-- Count broken cells in any box in O(1): Prefix[At(X, Y, Z)] = broken cells in [0, X) x [0, Y) x [0, Z)
		local SY, SZ = NY + 1, NZ + 1
		local Prefix: { number } = table.create((NX + 1) * SY * SZ, 0)
		local function At(X: number, Y: number, Z: number): number
			return (X * SY + Y) * SZ + Z + 1
		end
		for X = 1, NX do
			for Y = 1, NY do
				for Z = 1, NZ do
					local Here = if Broken[CellIndex(X - 1, Y - 1, Z - 1)] then 1 else 0
					Prefix[At(X, Y, Z)] = Here
						+ Prefix[At(X - 1, Y, Z)]
						+ Prefix[At(X, Y - 1, Z)]
						+ Prefix[At(X, Y, Z - 1)]
					- Prefix[At(X - 1, Y - 1, Z)]
					- Prefix[At(X - 1, Y, Z - 1)]
					- Prefix[At(X, Y - 1, Z - 1)]
						+ Prefix[At(X - 1, Y - 1, Z - 1)]
				end
			end
		end
		local function BrokenIn(X0: number, Y0: number, Z0: number, X1: number, Y1: number, Z1: number): number
			return Prefix[At(X1, Y1, Z1)]
			- Prefix[At(X0, Y1, Z1)]
			- Prefix[At(X1, Y0, Z1)]
			- Prefix[At(X1, Y1, Z0)]
				+ Prefix[At(X0, Y0, Z1)]
				+ Prefix[At(X0, Y1, Z0)]
				+ Prefix[At(X1, Y0, Z0)]
			- Prefix[At(X0, Y0, Z0)]
		end

		-- The biggest box with no broken cell in it stays; every other cell breaks
		local Best: { number }? = nil
		local BestVolume = 0
		for X0 = 0, NX - 1 do
			for X1 = X0 + 1, NX do
				for Y0 = 0, NY - 1 do
					for Y1 = Y0 + 1, NY do
						for Z0 = 0, NZ - 1 do
							for Z1 = Z0 + 1, NZ do
								local Volume = (X1 - X0) * (Y1 - Y0) * (Z1 - Z0)
								if Volume > BestVolume and BrokenIn(X0, Y0, Z0, X1, Y1, Z1) == 0 then
									Best, BestVolume = { X0, Y0, Z0, X1, Y1, Z1 }, Volume
								end
							end
						end
					end
				end
			end
		end

		Core, Edge, Leftover = {}, {}, {}
		for X = 0, NX - 1 do
			for Y = 0, NY - 1 do
				for Z = 0, NZ - 1 do
					local Kept = Best ~= nil
						and X >= Best[1] and X < Best[4]
						and Y >= Best[2] and Y < Best[5]
						and Z >= Best[3] and Z < Best[6]
					if Kept then
						continue
					elseif CellTop(X, Y, Z) > Line and not InHollow(X, Y, Z) then
						Emit(Core, X, Y, Z, X + 1, Y + 1, Z + 1)
					else
						Emit(Leftover, X, Y, Z, X + 1, Y + 1, Z + 1) -- below Above, or in the Hollow: stays
					end
				end
			end
		end
		if Best then
			Emit(Leftover, Best[1], Best[2], Best[3], Best[4], Best[5], Best[6])
		end
	end

	return {
		Core = Core,
		Edge = Edge,
		Leftover = Leftover,
		Counts = Vector3.new(NX, NY, NZ),
		CellSize = CellSize,
	}
end

-- Exposed for the self-test and for debugging.
Split._ToLocalHit = ToLocalHit
Split._Intersects = Intersects
Split._Contains = Contains
Split._ContainsPoint = ContainsPoint

return Split
