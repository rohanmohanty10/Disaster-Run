-- ReplicatedStorage/Modules/VoxelSerializer.lua
local VoxelSerializer = {}

-- Per-voxel layout (31 bytes):
--   f32 x,y,z            position                 (12)
--   i16 qx,qy,qz,qw      rotation quat * 32767    (8)  -- FULL 3D orientation
--   u16 sx,sy,sz         size * 100               (6)
--   u8  r,g,b            color                    (3)
--   u8  transparency     transparency * 255       (1)  -- keeps glass see-through
--   u8  paletteIndex     material+variant         (1)
-- Header:
--   u16 voxelCount
--   u8  paletteCount
--   palette[]: u16 materialValue, u8 variantLen, [variantLen bytes]
--
-- Rotation is stored as a quantized unit quaternion (4x i16), so absorbed pieces
-- keep their real orientation instead of snapping upright. Every client decodes
-- the same bytes through the same math, so poses are identical across clients.

local SIZE_SCALE = 100
local QUAT_SCALE = 32767
local VOXEL_STRIDE = 31

-- Enum.Material values exceed 255 (Plastic=256, Wood=512, Concrete=816...),
-- which is why material is u16, not u8. Cache value->EnumItem for decode.
local materialByValue = {}
for _, m in Enum.Material:GetEnumItems() do
	materialByValue[m.Value] = m
end

local function writeI16Clamped(b, o, v)
	buffer.writei16(b, o, math.clamp(math.round(v), -32767, 32767))
end

-- Rotation part of a CFrame -> unit quaternion (qx, qy, qz, qw).
local function cframeToQuat(cf)
	local axis, angle = cf:ToAxisAngle()
	local half = angle * 0.5
	local s = math.sin(half)
	local qx, qy, qz, qw = axis.X * s, axis.Y * s, axis.Z * s, math.cos(half)
	local mag = math.sqrt(qx * qx + qy * qy + qz * qz + qw * qw)
	if mag < 1e-8 then
		return 0, 0, 0, 1
	end
	return qx / mag, qy / mag, qz / mag, qw / mag
end

function VoxelSerializer.encode(snapshots)
	local n = #snapshots

	-- dedup (material, variant) pairs into a palette; voxels reference by u8 index
	local palette, paletteIndex = {}, {}
	for _, s in snapshots do
		local key = s.Material.Value .. "|" .. (s.MaterialVariant or "")
		if paletteIndex[key] == nil then
			local idx = #palette                       -- 0-based
			palette[idx + 1] = { mat = s.Material.Value, variant = s.MaterialVariant or "" }
			paletteIndex[key] = idx
		end
	end

	local headerSize = 3                                -- u16 count + u8 paletteCount
	for _, p in palette do
		headerSize += 3 + #p.variant                   -- u16 mat + u8 len + bytes
	end

	local b = buffer.create(headerSize + n * VOXEL_STRIDE)
	local o = 0

	buffer.writeu16(b, o, n); o += 2
	buffer.writeu8(b, o, #palette); o += 1
	for _, p in palette do
		buffer.writeu16(b, o, p.mat); o += 2
		buffer.writeu8(b, o, #p.variant); o += 1
		if #p.variant > 0 then
			buffer.writestring(b, o, p.variant); o += #p.variant
		end
	end

	for _, s in snapshots do
		local pos = s.CFrame.Position
		buffer.writef32(b, o, pos.X); o += 4
		buffer.writef32(b, o, pos.Y); o += 4
		buffer.writef32(b, o, pos.Z); o += 4

		local qx, qy, qz, qw = cframeToQuat(s.CFrame)
		writeI16Clamped(b, o, qx * QUAT_SCALE); o += 2
		writeI16Clamped(b, o, qy * QUAT_SCALE); o += 2
		writeI16Clamped(b, o, qz * QUAT_SCALE); o += 2
		writeI16Clamped(b, o, qw * QUAT_SCALE); o += 2

		buffer.writeu16(b, o, math.clamp(math.round(s.Size.X * SIZE_SCALE), 0, 65535)); o += 2
		buffer.writeu16(b, o, math.clamp(math.round(s.Size.Y * SIZE_SCALE), 0, 65535)); o += 2
		buffer.writeu16(b, o, math.clamp(math.round(s.Size.Z * SIZE_SCALE), 0, 65535)); o += 2

		buffer.writeu8(b, o, math.clamp(math.round(s.Color.R * 255), 0, 255)); o += 1
		buffer.writeu8(b, o, math.clamp(math.round(s.Color.G * 255), 0, 255)); o += 1
		buffer.writeu8(b, o, math.clamp(math.round(s.Color.B * 255), 0, 255)); o += 1

		buffer.writeu8(b, o, math.clamp(math.round((s.Transparency or 0) * 255), 0, 255)); o += 1

		buffer.writeu8(b, o, paletteIndex[s.Material.Value .. "|" .. (s.MaterialVariant or "")]); o += 1
	end

	return b
end

function VoxelSerializer.decode(b)
	local o = 0
	local n = buffer.readu16(b, o); o += 2
	local paletteCount = buffer.readu8(b, o); o += 1

	local palette = table.create(paletteCount)
	for i = 1, paletteCount do
		local matVal = buffer.readu16(b, o); o += 2
		local len = buffer.readu8(b, o); o += 1
		local variant = ""
		if len > 0 then
			variant = buffer.readstring(b, o, len); o += len
		end
		palette[i] = {
			materialEnum = materialByValue[matVal] or Enum.Material.Plastic,
			variant = variant,
		}
	end

	local out = table.create(n)
	for i = 1, n do
		local px = buffer.readf32(b, o); o += 4
		local py = buffer.readf32(b, o); o += 4
		local pz = buffer.readf32(b, o); o += 4

		local qx = buffer.readi16(b, o) / QUAT_SCALE; o += 2
		local qy = buffer.readi16(b, o) / QUAT_SCALE; o += 2
		local qz = buffer.readi16(b, o) / QUAT_SCALE; o += 2
		local qw = buffer.readi16(b, o) / QUAT_SCALE; o += 2

		local sx = buffer.readu16(b, o) / SIZE_SCALE; o += 2
		local sy = buffer.readu16(b, o) / SIZE_SCALE; o += 2
		local sz = buffer.readu16(b, o) / SIZE_SCALE; o += 2

		local r = buffer.readu8(b, o); o += 1
		local g = buffer.readu8(b, o); o += 1
		local bl = buffer.readu8(b, o); o += 1

		local transparency = buffer.readu8(b, o) / 255; o += 1

		local pal = palette[buffer.readu8(b, o) + 1]; o += 1  -- index is 0-based

		out[i] = {
			-- CFrame.new(pos, quaternion) — Roblox normalizes the quaternion internally
			CFrame = CFrame.new(px, py, pz, qx, qy, qz, qw),
			Size = Vector3.new(sx, sy, sz),
			Color = Color3.fromRGB(r, g, bl),
			Transparency = transparency,
			Material = pal.materialEnum,
			MaterialVariant = pal.variant,
		}
	end

	return out
end

return VoxelSerializer