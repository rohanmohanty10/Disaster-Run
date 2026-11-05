--!strict
-- ReplicatedStorage > Modules > Debree > Materials   (ModuleScript, shared by server and client)
--
-- The shared material list for Debree. Pieces send their material as a short string key
-- instead of the Enum name, so the server and every client must use the same list order.
-- Only ever ADD materials to the END of the list: reordering changes every key.
--
-- Key format (the materialIndexKey level of the Create payload):
--   "8"                     -> List[8], no MaterialVariant   (identical to JJS's key)
--   "8|StylizedConBrick"    -> List[8] with MaterialVariant "StylizedConBrick"
-- JJS's format has no MaterialVariant. The "|Variant" suffix is our extension, because
-- the map uses variants on ground tiles and walls and pieces must keep that look.

local Materials = {}

local List: { Enum.Material } = {
	Enum.Material.Plastic, -- 1: also the fallback for anything unknown
	Enum.Material.SmoothPlastic,
	Enum.Material.Neon,
	Enum.Material.Wood,
	Enum.Material.WoodPlanks,
	Enum.Material.Marble,
	Enum.Material.Slate,
	Enum.Material.Concrete,
	Enum.Material.CrackedLava,
	Enum.Material.Basalt,
	Enum.Material.Limestone,
	Enum.Material.Granite,
	Enum.Material.Pavement,
	Enum.Material.Brick,
	Enum.Material.Pebble,
	Enum.Material.Cobblestone,
	Enum.Material.Rock,
	Enum.Material.Sandstone,
	Enum.Material.CorrodedMetal,
	Enum.Material.DiamondPlate,
	Enum.Material.Foil,
	Enum.Material.Metal,
	Enum.Material.Grass,
	Enum.Material.LeafyGrass,
	Enum.Material.Sand,
	Enum.Material.Fabric,
	Enum.Material.Snow,
	Enum.Material.Mud,
	Enum.Material.Ground,
	Enum.Material.Asphalt,
	Enum.Material.Salt,
	Enum.Material.Ice,
	Enum.Material.Glacier,
	Enum.Material.Glass,
	Enum.Material.ForceField,
	Enum.Material.Cardboard,
	Enum.Material.Carpet,
	Enum.Material.CeramicTiles,
	Enum.Material.ClayRoofTiles,
	Enum.Material.RoofShingles,
	Enum.Material.Leather,
	Enum.Material.Plaster,
	Enum.Material.Rubber,
}

local VARIANT_SEPARATOR = "|"

local IndexOf: { [Enum.Material]: number } = {}
for Index, Material in List do
	IndexOf[Material] = Index
end

type Decoded = { Material: Enum.Material, Variant: string }
local DecodedKeys: { [string]: Decoded } = {}

Materials.List = table.freeze(List)

-- Material -> list index. Unknown materials (Air, Water) fall back to Plastic so a piece is never dropped.
function Materials.ToIndex(Material: Enum.Material): number
	return IndexOf[Material] or 1
end

-- List index -> Material. Bad indexes fall back to Plastic.
function Materials.FromIndex(Index: number): Enum.Material
	return List[Index] or Enum.Material.Plastic
end

-- (Material, MaterialVariant) -> payload key.
function Materials.ToKey(Material: Enum.Material, Variant: string?): string
	local IndexKey = tostring(Materials.ToIndex(Material))
	if Variant and Variant ~= "" then
		return IndexKey .. VARIANT_SEPARATOR .. Variant
	end
	return IndexKey
end

-- Payload key -> (Material, MaterialVariant). Results are cached per key, since every
-- Create payload repeats the same few keys.
function Materials.FromKey(Key: string): (Enum.Material, string)
	local Cached = DecodedKeys[Key]
	if not Cached then
		local Split = string.find(Key, VARIANT_SEPARATOR, 1, true)
		local IndexText = if Split then string.sub(Key, 1, Split - 1) else Key
		Cached = {
			Material = Materials.FromIndex(tonumber(IndexText) or 1),
			Variant = if Split then string.sub(Key, Split + 1) else "",
		}
		DecodedKeys[Key] = Cached
	end
	return Cached.Material, Cached.Variant
end

return table.freeze(Materials)
