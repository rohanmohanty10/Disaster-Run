--!strict
-- ReplicatedStorage > Modules > Debree > Records   (ModuleScript, shared by server and client)
--
-- Packs and unpacks the fixed-size binary records Debree sends to clients.
-- The layouts match JJS's DebreeService wire format byte for byte (little-endian):
--
--   Piece record, 32 bytes  (Create: staticBuf and movedBuf)
--     0   f32 x3   Position
--     12  i16 x3   Orientation in degrees x100 (CFrame:ToOrientation order)
--     18  f32 x3   Size
--     30  u16      Piece ID
--
--   Flying record, 44 bytes  (Create: flyingBuf)
--     0   the 32-byte piece record
--     32  i16 x3   Linear velocity x100   (so at most +/-327.67 studs/s)
--     38  i16 x3   Angular velocity x100  (radians/s)
--
--   Physics record, 21 bytes  (Physics)
--     0   f32 x3   Position
--     12  i16 x3   Orientation in degrees x100
--     18  u16      Piece ID
--     20  u8       1 = settled (final resting place), 0 = moving
--
--   ID list, 2 bytes per ID  (Sound)
--     i16 Piece ID. JJS's client reads these signed, which is why IDs stay <= 32767.
--
-- Record indexes are 1-based: record N starts at byte (N - 1) * size.
-- Readers return exactly what JJS's client reconstructs:
--   CFrame.new(Position) * CFrame.fromOrientation(rad(X / 100), rad(Y / 100), rad(Z / 100))

local Records = {}

Records.PIECE_SIZE = 32
Records.FLYING_SIZE = 44
Records.PHYSICS_SIZE = 21
Records.ID_SIZE = 2
Records.MAX_ID = 32767

local I16_MIN, I16_MAX = -32768, 32767

-- Rounds and clamps into i16 range. NaN becomes 0 instead of garbage.
local function ToI16(Value: number): number
	if Value ~= Value then
		return 0
	end
	return math.clamp(math.round(Value), I16_MIN, I16_MAX)
end

local function WriteTransform(Buffer: buffer, Offset: number, Transform: CFrame)
	local Position = Transform.Position
	buffer.writef32(Buffer, Offset, Position.X)
	buffer.writef32(Buffer, Offset + 4, Position.Y)
	buffer.writef32(Buffer, Offset + 8, Position.Z)

	local RX, RY, RZ = Transform:ToOrientation()
	buffer.writei16(Buffer, Offset + 12, ToI16(math.deg(RX) * 100))
	buffer.writei16(Buffer, Offset + 14, ToI16(math.deg(RY) * 100))
	buffer.writei16(Buffer, Offset + 16, ToI16(math.deg(RZ) * 100))
end

local function ReadTransform(Buffer: buffer, Offset: number): CFrame
	local Position = Vector3.new(
		buffer.readf32(Buffer, Offset),
		buffer.readf32(Buffer, Offset + 4),
		buffer.readf32(Buffer, Offset + 8)
	)
	local RX = math.rad(buffer.readi16(Buffer, Offset + 12) / 100)
	local RY = math.rad(buffer.readi16(Buffer, Offset + 14) / 100)
	local RZ = math.rad(buffer.readi16(Buffer, Offset + 16) / 100)
	return CFrame.new(Position) * CFrame.fromOrientation(RX, RY, RZ)
end

local function WriteSize(Buffer: buffer, Offset: number, Size: Vector3)
	buffer.writef32(Buffer, Offset, Size.X)
	buffer.writef32(Buffer, Offset + 4, Size.Y)
	buffer.writef32(Buffer, Offset + 8, Size.Z)
end

local function ReadSize(Buffer: buffer, Offset: number): Vector3
	return Vector3.new(
		buffer.readf32(Buffer, Offset),
		buffer.readf32(Buffer, Offset + 4),
		buffer.readf32(Buffer, Offset + 8)
	)
end

local function WriteVector16(Buffer: buffer, Offset: number, Vector: Vector3)
	buffer.writei16(Buffer, Offset, ToI16(Vector.X * 100))
	buffer.writei16(Buffer, Offset + 2, ToI16(Vector.Y * 100))
	buffer.writei16(Buffer, Offset + 4, ToI16(Vector.Z * 100))
end

local function ReadVector16(Buffer: buffer, Offset: number): Vector3
	return Vector3.new(
		buffer.readi16(Buffer, Offset) / 100,
		buffer.readi16(Buffer, Offset + 2) / 100,
		buffer.readi16(Buffer, Offset + 4) / 100
	)
end

-- How many whole records of RecordSize are in Buffer.
function Records.Count(Buffer: buffer, RecordSize: number): number
	return buffer.len(Buffer) // RecordSize
end

------------------------------------------------------------------------
-- Piece record (32 bytes)
------------------------------------------------------------------------

function Records.WritePiece(Buffer: buffer, Index: number, Transform: CFrame, Size: Vector3, Id: number)
	local Offset = (Index - 1) * Records.PIECE_SIZE
	WriteTransform(Buffer, Offset, Transform)
	WriteSize(Buffer, Offset + 18, Size)
	buffer.writeu16(Buffer, Offset + 30, Id)
end

function Records.ReadPiece(Buffer: buffer, Index: number): (CFrame, Vector3, number)
	local Offset = (Index - 1) * Records.PIECE_SIZE
	return ReadTransform(Buffer, Offset), ReadSize(Buffer, Offset + 18), buffer.readu16(Buffer, Offset + 30)
end

------------------------------------------------------------------------
-- Flying record (44 bytes)
------------------------------------------------------------------------

function Records.WriteFlying(
	Buffer: buffer,
	Index: number,
	Transform: CFrame,
	Size: Vector3,
	Id: number,
	LinearVelocity: Vector3,
	AngularVelocity: Vector3
)
	local Offset = (Index - 1) * Records.FLYING_SIZE
	WriteTransform(Buffer, Offset, Transform)
	WriteSize(Buffer, Offset + 18, Size)
	buffer.writeu16(Buffer, Offset + 30, Id)
	WriteVector16(Buffer, Offset + 32, LinearVelocity)
	WriteVector16(Buffer, Offset + 38, AngularVelocity)
end

function Records.ReadFlying(Buffer: buffer, Index: number): (CFrame, Vector3, number, Vector3, Vector3)
	local Offset = (Index - 1) * Records.FLYING_SIZE
	return ReadTransform(Buffer, Offset),
		ReadSize(Buffer, Offset + 18),
		buffer.readu16(Buffer, Offset + 30),
		ReadVector16(Buffer, Offset + 32),
		ReadVector16(Buffer, Offset + 38)
end

------------------------------------------------------------------------
-- Physics record (21 bytes)
------------------------------------------------------------------------

function Records.WritePhysics(Buffer: buffer, Index: number, Transform: CFrame, Id: number, Settled: boolean)
	local Offset = (Index - 1) * Records.PHYSICS_SIZE
	WriteTransform(Buffer, Offset, Transform)
	buffer.writeu16(Buffer, Offset + 18, Id)
	buffer.writeu8(Buffer, Offset + 20, if Settled then 1 else 0)
end

function Records.ReadPhysics(Buffer: buffer, Index: number): (CFrame, number, boolean)
	local Offset = (Index - 1) * Records.PHYSICS_SIZE
	return ReadTransform(Buffer, Offset), buffer.readu16(Buffer, Offset + 18), buffer.readu8(Buffer, Offset + 20) == 1
end

------------------------------------------------------------------------
-- ID list (2 bytes per ID)
------------------------------------------------------------------------

function Records.WriteIds(Ids: { number }): buffer
	local Buffer = buffer.create(#Ids * Records.ID_SIZE)
	for Index, Id in Ids do
		buffer.writei16(Buffer, (Index - 1) * Records.ID_SIZE, Id)
	end
	return Buffer
end

function Records.ReadIds(Buffer: buffer): { number }
	local Count = Records.Count(Buffer, Records.ID_SIZE)
	local Ids = table.create(Count)
	for Index = 1, Count do
		Ids[Index] = buffer.readi16(Buffer, (Index - 1) * Records.ID_SIZE)
	end
	return Ids
end

------------------------------------------------------------------------
-- Self-test: Records.SelfTest() -> (passed, report)
------------------------------------------------------------------------

type Sample = {
	Transform: CFrame,
	Size: Vector3,
	Id: number,
	Linear: Vector3,
	Angular: Vector3,
	Settled: boolean,
}

local POSITION_TOLERANCE = 0.01 -- studs; f32 at map coordinates (thousands of studs) is about 0.0005 off
-- Packing rounds each axis to 0.005 degrees (at most ~0.011 degrees in total, measured).
-- Pieces pointing within ~0.05 degrees of straight up or down (gimbal lock) can be off by up
-- to ~0.05 degrees more, from Roblox's own CFrame:ToOrientation, even with no packing at all.
-- Both are invisible: 0.05 degrees moves the tip of a 10-stud piece by 0.009 studs.
local ROTATION_TOLERANCE = math.rad(0.06)
local SIZE_TOLERANCE = 1e-4
local VELOCITY_TOLERANCE = 0.01 -- i16 x100 rounds to 0.005 per axis

-- How far apart two rotations are, in radians (for small angles). This compares the
-- rotated axes directly. ToAxisAngle can't be used here: CFrames store rotation as
-- 32-bit floats, so its smallest measurable angle is about 0.028 degrees, which is
-- coarser than the 0.005-degree packing error being tested.
local function RotationError(A: CFrame, B: CFrame): number
	return math.max(
		(A.XVector - B.XVector).Magnitude,
		(A.YVector - B.YVector).Magnitude,
		(A.ZVector - B.ZVector).Magnitude
	)
end

local function RandomSample(Rng: Random): Sample
	local Position = Vector3.new(Rng:NextNumber(-5000, 5000), Rng:NextNumber(-500, 500), Rng:NextNumber(-5000, 5000))
	return {
		Transform = CFrame.new(Position) * CFrame.fromOrientation(
			Rng:NextNumber(-math.pi / 2, math.pi / 2),
			Rng:NextNumber(-math.pi, math.pi),
			Rng:NextNumber(-math.pi, math.pi)
		),
		Size = Vector3.new(Rng:NextNumber(0.05, 60), Rng:NextNumber(0.05, 60), Rng:NextNumber(0.05, 60)),
		Id = Rng:NextInteger(1, Records.MAX_ID),
		Linear = Vector3.new(Rng:NextNumber(-300, 300), Rng:NextNumber(-300, 300), Rng:NextNumber(-300, 300)),
		Angular = Vector3.new(Rng:NextNumber(-50, 50), Rng:NextNumber(-50, 50), Rng:NextNumber(-50, 50)),
		Settled = Rng:NextNumber() < 0.5,
	}
end

function Records.SelfTest(): (boolean, string)
	local Rng = Random.new(1)
	local Count = 500
	local Failures: { string } = {}

	local function Check(Condition: boolean, Message: string)
		if not Condition and #Failures < 10 then
			table.insert(Failures, Message)
		end
	end

	local Samples: { Sample } = table.create(Count)
	for Index = 1, Count do
		Samples[Index] = RandomSample(Rng)
	end
	-- Edge cases: identity, gimbal lock (pitch +/-90), the ends of every range
	Samples[1].Transform = CFrame.identity
	Samples[2].Transform = CFrame.new(1, 2, 3) * CFrame.fromOrientation(math.pi / 2, 0.7, -0.3)
	Samples[3].Transform = CFrame.new(-1, -2, -3) * CFrame.fromOrientation(-math.pi / 2, math.pi, -math.pi)
	Samples[4].Id = 1
	Samples[5].Id = Records.MAX_ID

	local PieceBuffer = buffer.create(Count * Records.PIECE_SIZE)
	local FlyingBuffer = buffer.create(Count * Records.FLYING_SIZE)
	local PhysicsBuffer = buffer.create(Count * Records.PHYSICS_SIZE)
	for Index, S in Samples do
		Records.WritePiece(PieceBuffer, Index, S.Transform, S.Size, S.Id)
		Records.WriteFlying(FlyingBuffer, Index, S.Transform, S.Size, S.Id, S.Linear, S.Angular)
		Records.WritePhysics(PhysicsBuffer, Index, S.Transform, S.Id, S.Settled)
	end
	Check(Records.Count(PieceBuffer, Records.PIECE_SIZE) == Count, "piece record count")
	Check(Records.Count(FlyingBuffer, Records.FLYING_SIZE) == Count, "flying record count")
	Check(Records.Count(PhysicsBuffer, Records.PHYSICS_SIZE) == Count, "physics record count")

	for Index, S in Samples do
		local Transform, Size, Id = Records.ReadPiece(PieceBuffer, Index)
		Check((Transform.Position - S.Transform.Position).Magnitude <= POSITION_TOLERANCE, `piece {Index} position`)
		Check(RotationError(Transform, S.Transform) <= ROTATION_TOLERANCE, `piece {Index} rotation`)
		Check((Size - S.Size).Magnitude <= SIZE_TOLERANCE, `piece {Index} size`)
		Check(Id == S.Id, `piece {Index} id`)

		local FTransform, FSize, FId, Linear, Angular = Records.ReadFlying(FlyingBuffer, Index)
		Check((FTransform.Position - S.Transform.Position).Magnitude <= POSITION_TOLERANCE, `flying {Index} position`)
		Check(RotationError(FTransform, S.Transform) <= ROTATION_TOLERANCE, `flying {Index} rotation`)
		Check((FSize - S.Size).Magnitude <= SIZE_TOLERANCE and FId == S.Id, `flying {Index} size/id`)
		Check((Linear - S.Linear).Magnitude <= VELOCITY_TOLERANCE, `flying {Index} linear velocity`)
		Check((Angular - S.Angular).Magnitude <= VELOCITY_TOLERANCE, `flying {Index} angular velocity`)

		local PTransform, PId, Settled = Records.ReadPhysics(PhysicsBuffer, Index)
		Check((PTransform.Position - S.Transform.Position).Magnitude <= POSITION_TOLERANCE, `physics {Index} position`)
		Check(RotationError(PTransform, S.Transform) <= ROTATION_TOLERANCE, `physics {Index} rotation`)
		Check(PId == S.Id and Settled == S.Settled, `physics {Index} id/flag`)
	end

	-- Velocities clamp at the i16 limits instead of wrapping around
	local ClampBuffer = buffer.create(Records.FLYING_SIZE)
	Records.WriteFlying(ClampBuffer, 1, CFrame.identity, Vector3.one, 1, Vector3.new(1000, -1000, 0 / 0), Vector3.zero)
	local _, _, _, Clamped = Records.ReadFlying(ClampBuffer, 1)
	Check(math.abs(Clamped.X - 327.67) < 1e-3, "velocity clamps at +327.67")
	Check(math.abs(Clamped.Y + 327.68) < 1e-3, "velocity clamps at -327.68")
	Check(Clamped.Z == 0, "NaN velocity is written as 0")

	-- ID lists
	local ReadBack = Records.ReadIds(Records.WriteIds({ 1, 2, 300, Records.MAX_ID }))
	Check(#ReadBack == 4 and ReadBack[1] == 1 and ReadBack[3] == 300 and ReadBack[4] == Records.MAX_ID, "id list round trip")
	Check(buffer.len(Records.WriteIds({})) == 0 and #Records.ReadIds(buffer.create(0)) == 0, "empty id list")

	if #Failures > 0 then
		return false, "Records self-test FAILED:\n  " .. table.concat(Failures, "\n  ")
	end
	return true, `Records self-test passed ({Count} piece, flying and physics records; clamping; NaN; id lists)`
end

return table.freeze(Records)
