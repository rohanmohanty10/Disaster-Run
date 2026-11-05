--!strict
-- ServerStorage > SBGModules > DebreeService > Registry   (ModuleScript, server only)
--
-- Every live piece, looked up by ID or by its server physics part, plus the ID allocator.
-- IDs are 1..MaxId (u16 on the wire, <= 32767 because JJS's client reads sound IDs as i16).
-- Fresh IDs are handed out first; freed IDs are reused oldest-first, so an ID that was
-- just removed isn't reused while stray Physics packets for it could still be arriving.

local Registry = {}

export type Kind = "Static" | "Debris"
export type Mode = "Ground" | "Wall"

-- One original map part that has been broken. It is hidden until the reset.
export type Group = {
	Original: BasePart,
	OriginalParent: Instance,
	PrimaryOf: Model?, -- the Model whose PrimaryPart this was, so the reset can restore it
	Mode: Mode,
	CellSize: Vector3,
	Shrink: Vector3, -- per-axis debris scale (ground pieces keep their full thickness)
	ResetAt: number,
	Pieces: { [number]: Piece },
	-- Look, copied from the original, and the Create payload keys for it
	Color: Color3,
	Material: Enum.Material,
	Variant: string,
	Transparency: number,
	TransparencyKey: string,
	MaterialKey: string,
	ColorKey: string,
}

export type Piece = {
	Id: number,
	Body: Part, -- the server's physics copy, under the server camera (never replicated)
	Kind: Kind, -- Static = full-size leftover box, Debris = shrunk grid cell
	Group: Group,
	RestCFrame: CFrame, -- where the cell was cut; ground debris re-jitters around this
	StillFor: number,
	MovingFor: number,
	LastLaunch: number,
	SentCFrame: CFrame, -- last transform the clients were sent
	LastSentAt: number,
	SettledAt: number,
	ResendIndex: number, -- which Config.SettleResends entry is next (0 = the first send)
	Ghosts: { NoCollisionConstraint }, -- temporary no-collides with things it was cut overlapping
	Slick: boolean, -- riding on another launched piece with StackedFriction
}

Registry.MaxId = 32767

local Pieces: { [number]: Piece } = {}
local ByBody: { [BasePart]: Piece } = {}
local Live = 0

local NextFresh = 1
local FreeQueue: { [number]: number } = {}
local FreeHead, FreeTail = 1, 1 -- queue holds FreeQueue[FreeHead .. FreeTail - 1]

-- How many more IDs can be handed out right now.
function Registry.Available(): number
	return (Registry.MaxId - NextFresh + 1) + (FreeTail - FreeHead)
end

-- Reserve an ID, or nil when every ID is in use.
function Registry.Allocate(): number?
	if NextFresh <= Registry.MaxId then
		NextFresh += 1
		return NextFresh - 1
	end
	if FreeHead < FreeTail then
		local Id = FreeQueue[FreeHead]
		FreeQueue[FreeHead] = nil
		FreeHead += 1
		return Id
	end
	return nil
end

-- Give an ID back without ever having used it (for example when a split is abandoned).
function Registry.Release(Id: number)
	FreeQueue[FreeTail] = Id
	FreeTail += 1
end

function Registry.Add(Piece: Piece)
	assert(Pieces[Piece.Id] == nil, `Debree: piece id {Piece.Id} is already in use`)
	Pieces[Piece.Id] = Piece
	ByBody[Piece.Body] = Piece
	Live += 1
end

-- Forget a piece and free its ID. Destroying its body is the caller's job.
function Registry.Remove(Piece: Piece)
	if Pieces[Piece.Id] ~= Piece then
		return
	end
	Pieces[Piece.Id] = nil
	ByBody[Piece.Body] = nil
	Live -= 1
	Registry.Release(Piece.Id)
end

function Registry.Get(Id: number): Piece?
	return Pieces[Id]
end

function Registry.FromBody(Part: BasePart): Piece?
	return ByBody[Part]
end

function Registry.Count(): number
	return Live
end

-- Every live piece, keyed by ID. Read it; don't modify it.
function Registry.All(): { [number]: Piece }
	return Pieces
end

-- Clears everything. Only for the self-test.
function Registry._Reset(MaxId: number)
	Registry.MaxId = MaxId
	table.clear(Pieces)
	table.clear(ByBody)
	table.clear(FreeQueue)
	Live, NextFresh, FreeHead, FreeTail = 0, 1, 1, 1
end

return Registry
