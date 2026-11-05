--!nonstrict
-- Checkpoint 1: geometry only. Returns exact-sized, grounded remnants; no flying debris.
local Split = require(script.Parent.Split)
local Remains = {}

Remains.Settings = {
	FallbackHeight = 15, -- studs above Map.Floor when no first-floor slab is identifiable
	MinFloorHeight = 5,
	MaxFloorHeight = 18,
	ExtraHeight = 5,
	SectionWidth = 3.5,
	HeightStep = 1,
	BreachWidth = 7,
	SupportTolerance = 0.18,
}

local function extent(cf, size)
	return (cf.RightVector:Abs() * size.X + cf.UpVector:Abs() * size.Y + cf.LookVector:Abs() * size.Z) / 2
end

-- Keep the original Map.Floor block surfaces available even while destruction hides them.
local FloorReferences = setmetatable({}, {__mode="k"})

function Remains.PrepareFloor(floorFolder)
	if not floorFolder then return nil end
	local reference={Parts={},Top=-math.huge}
	for _,part in floorFolder:GetDescendants() do
		if part:IsA("Part") and part.Shape==Enum.PartType.Block then
			local half=part.Size/2
			local e=extent(part.CFrame,part.Size)
			local low,high=part.Position-e,part.Position+e
			table.insert(reference.Parts,{CFrame=part.CFrame,Half=half,Low=low,High=high})
			reference.Top=math.max(reference.Top,high.Y)
		end
	end
	table.sort(reference.Parts,function(a,b)return a.High.Y>b.High.Y end)
	FloorReferences[floorFolder]=reference
	return reference
end

local function referenceGround(reference,x,z,top)
	local best
	for _,box in reference.Parts do
		if (not best or box.High.Y>best) and x>=box.Low.X-0.001 and x<=box.High.X+0.001
			and z>=box.Low.Z-0.001 and z<=box.High.Z+0.001 then
			local origin=box.CFrame:PointToObjectSpace(Vector3.new(x,top,z))
			local direction=box.CFrame:VectorToObjectSpace(-Vector3.yAxis)
			local p,d,h={origin.X,origin.Y,origin.Z},{direction.X,direction.Y,direction.Z},{box.Half.X,box.Half.Y,box.Half.Z}
			local enter,leave=0,math.huge
			local valid=true
			for axis=1,3 do
				if math.abs(d[axis])<1e-8 then
					if math.abs(p[axis])>h[axis]+0.001 then valid=false;break end
				else
					local a,b=(-h[axis]-p[axis])/d[axis],(h[axis]-p[axis])/d[axis]
					enter=math.max(enter,math.min(a,b));leave=math.min(leave,math.max(a,b))
					if enter>leave then valid=false;break end
				end
			end
			if valid and leave>=0 then best=math.max(best or -math.huge,top-enter) end
		end
	end
	return best
end


local function median(values)
	table.sort(values)
	return values[math.ceil(#values / 2)]
end

local function mergeBoxes(entry)
	local boxes = entry.Boxes
	for axis = 1, 3 do
		local groups = {}
		local a, b = axis % 3 + 1, (axis + 1) % 3 + 1
		for _, box in boxes do
			local p = entry.CFrame:PointToObjectSpace(box.CFrame.Position)
			local pos, dims = {p.X,p.Y,p.Z}, {box.Size.X,box.Size.Y,box.Size.Z}
			local key = ""
			for _, value in { pos[a], pos[b], dims[a], dims[b] } do key ..= math.round(value*1000)..":" end
			groups[key] = groups[key] or {}
			table.insert(groups[key], {Pos=pos, Dims=dims})
		end
		boxes = {}
		for _, list in groups do
			table.sort(list, function(x,y) return x.Pos[axis] < y.Pos[axis] end)
			local current
			local function flush()
				if current then table.insert(boxes, { CFrame=entry.CFrame*CFrame.new(Vector3.new(table.unpack(current.Pos))), Size=Vector3.new(table.unpack(current.Dims)) }) end
			end
			for _, box in list do
				if current and math.abs(current.Pos[axis]+current.Dims[axis]/2 - (box.Pos[axis]-box.Dims[axis]/2)) < 0.001 then
					local low = current.Pos[axis]-current.Dims[axis]/2
					local high = box.Pos[axis]+box.Dims[axis]/2
					current.Pos[axis], current.Dims[axis] = (low+high)/2, high-low
				else flush(); current = box end
			end
			flush()
		end
	end
	entry.Boxes = boxes
end

function Remains.BuildingOf(instance)
	local found
	while instance and instance ~= workspace do
		if instance:IsA("Model") and instance:GetAttribute("Building") == true then
			found = instance -- outermost marked model; nested labels must not process twice
		end
		instance = instance.Parent
	end
	return found
end

-- Exact complement of the surviving boxes, in the source part's local axes.
-- This prevents debris from copying the lower walls that remain standing.
function Remains.RemovedBoxes(entry)
	if entry.Ignore then return {} end
	local pieces = { { Low=-entry.Size/2, High=entry.Size/2 } }
	local epsilon = 0.0001
	for _, kept in entry.Boxes do
		local center = entry.CFrame:PointToObjectSpace(kept.CFrame.Position)
		local cutLow, cutHigh = center-kept.Size/2, center+kept.Size/2
		local nextPieces = {}
		local function add(low, high)
			local size = high-low
			if math.min(size.X,size.Y,size.Z) > epsilon then table.insert(nextPieces, {Low=low,High=high}) end
		end
		for _, piece in pieces do
			local low, high = piece.Low, piece.High
			local il, ih = low:Max(cutLow), high:Min(cutHigh)
			local overlap = ih-il
			if math.min(overlap.X,overlap.Y,overlap.Z) <= epsilon then
				table.insert(nextPieces, piece)
			else
				add(low, Vector3.new(il.X,high.Y,high.Z))
				add(Vector3.new(ih.X,low.Y,low.Z), high)
				add(Vector3.new(il.X,low.Y,low.Z), Vector3.new(ih.X,il.Y,high.Z))
				add(Vector3.new(il.X,ih.Y,low.Z), Vector3.new(ih.X,high.Y,high.Z))
				add(Vector3.new(il.X,il.Y,low.Z), Vector3.new(ih.X,ih.Y,il.Z))
				add(Vector3.new(il.X,il.Y,ih.Z), Vector3.new(ih.X,ih.Y,high.Z))
			end
		end
		pieces = nextPieces
		if #pieces == 0 then break end
	end
	local removed = { CFrame=entry.CFrame, Boxes={} }
	for _, piece in pieces do
		table.insert(removed.Boxes, { CFrame=entry.CFrame*CFrame.new((piece.Low+piece.High)/2), Size=piece.High-piece.Low })
	end
	mergeBoxes(removed)
	return removed.Boxes
end


function Remains.Plan(model, floorFolder, existingBodies, options)
	options=options or {}
	local yieldWork=options.Yield or function() end
	assert(model and model:IsA("Model"), "BuildingRemains: expected a building Model")
	assert(floorFolder, "BuildingRemains: Map.Floor is missing")
	local settings = Remains.Settings
	local originalParts = {}
	local low = Vector3.one * math.huge
	local high = Vector3.one * -math.huge
	local sourceParts = table.clone(options.SourceParts or model:GetDescendants())
	for _, body in existingBodies or {} do table.insert(sourceParts, body) end
	for _, part in sourceParts do
		if part:IsA("BasePart") then
			local e = extent(part.CFrame, part.Size)
			low = low:Min(part.Position - e)
			high = high:Max(part.Position + e)
			table.insert(originalParts, part)
		end
	end
	assert(#originalParts > 0, "BuildingRemains: building contains no parts")
	local center, size = (low + high) / 2, high - low
	local ray = RaycastParams.new()
	ray.FilterType = Enum.RaycastFilterType.Include
	ray.FilterDescendantsInstances = { floorFolder }
	ray.RespectCanCollide = false
	local reference=FloorReferences[floorFolder] or Remains.PrepareFloor(floorFolder)
	local groundCache = options.GroundCache or {}
	local function groundAt(x, z)
		local key = math.floor(x / 2) .. ":" .. math.floor(z / 2)
		if groundCache[key] then return groundCache[key] end
		local top=math.max(high.Y+100,reference.Top+1)
		local hit=workspace:Raycast(Vector3.new(x,top,z),Vector3.new(0,-math.max(size.Y+1200,top-low.Y+1200),0),ray)
		local ground=if hit then hit.Position.Y else referenceGround(reference,x,z,top)
		if ground then groundCache[key]=ground end
		return ground
	end
	local grounds = {}
	for _, x in { -0.35, 0, 0.35 } do
		for _, z in { -0.35, 0, 0.35 } do
			local y = groundAt(center.X + size.X * x, center.Z + size.Z * z)
			if y then table.insert(grounds, y) end
		end
	end
	if #grounds == 0 then return nil, "no original Map.Floor surface beneath " .. model:GetFullName() end
	local groundY = median(grounds)
	local baseHeight = settings.FallbackHeight
	local detected = false
	local firstFloor = math.huge
	for _, part in originalParts do
		yieldWork()
		local e = extent(part.CFrame, part.Size)
		local height = part.Position.Y + e.Y - groundY
		-- Broad, horizontal structural slabs, not thin trim or tall wall panels.
		if e.Y * 2 <= 3 and e.X * 2 >= size.X * 0.4 and e.Z * 2 >= size.Z * 0.4
			and height >= settings.MinFloorHeight and height <= settings.MaxFloorHeight then
			firstFloor = math.min(firstFloor, height)
		end
	end
	if firstFloor < math.huge then baseHeight, detected = firstFloor, true end
	local override = model:GetAttribute("TsunamiRemainHeight")
	if typeof(override) == "number" then baseHeight = math.clamp(override, 3, 60) end
	baseHeight = math.min(baseHeight, math.max(3, size.Y - 3))
	local seed = options.Seed or model:GetAttribute("TsunamiRemainSeed")
	if typeof(seed) ~= "number" then seed = math.abs(math.round(center.X * 73 + center.Z * 131)) % 100000 end
	local rng = Random.new(seed)
	local phase = rng:NextNumber(10, 1000)
	-- Broad ground-level breaches on two different facades, consistently shared by all parts.
	local function breach(side)
		local along = rng:NextNumber(-0.23, 0.23)
		if side == 1 or side == 3 then
			return { X = center.X + size.X * along, Z = center.Z + size.Z * (side == 1 and -0.47 or 0.47), RX = settings.BreachWidth * 0.7, RZ = math.max(5, size.Z * 0.2) }
		end
		return { X = center.X + size.X * (side == 2 and 0.47 or -0.47), Z = center.Z + size.Z * along, RX = math.max(5, size.X * 0.2), RZ = settings.BreachWidth * 0.7 }
	end
	local side = rng:NextInteger(1, 4)
	local breaches = { breach(side), breach(side % 4 + 1) }
	local function heightAt(x, z)
		local ground = groundAt(x, z) or groundY
		local n = math.clamp(0.5 + math.noise(x / 13, z / 13, phase) * 1.5, 0, 1)
		local detail = math.noise(x / 3.7, z / 3.7, phase + 40)
		local height = baseHeight - 5 + n * (5 + settings.ExtraHeight) + detail * 2
		for _, b in breaches do
			local distance = math.sqrt(((x - b.X) / b.RX)^2 + ((z - b.Z) / b.RZ)^2)
			local weight = math.clamp((distance - 0.65) / 0.8, 0, 1)
			height *= weight
		end
		if height < 0.75 then return ground - 1 end
		height = math.clamp(math.floor(height / settings.HeightStep) * settings.HeightStep, 0, baseHeight + settings.ExtraHeight)
		return ground + height
	end

	local entries, candidates = {}, {}
	local function add(entry, cf, boxSize)
		if math.min(boxSize.X, boxSize.Y, boxSize.Z) < 0.06 then return end
		local e = extent(cf, boxSize)
		local box = { CFrame = cf, Size = boxSize, Low = cf.Position - e, High = cf.Position + e, Entry = entry }
		table.insert(candidates, box)
		yieldWork()
	end
	for _, part in originalParts do
		yieldWork()
		local entry = { Original = part, CFrame = part.CFrame, Size = part.Size, Boxes = {} }
		table.insert(entries, entry)
		if part:GetAttribute("DebreeIgnore") == true then
			entry.Ignore = true
			add(entry, part.CFrame, part.Size)
		elseif part.Transparency < 1 then
			local cf, dimensions = part.CFrame, part.Size
			local e = extent(cf, dimensions)
			if cf.Position.Y - e.Y <= groundY + baseHeight + settings.ExtraHeight + 2 then
				local vectors = { cf.RightVector, cf.UpVector, -cf.LookVector }
				local sizes = { dimensions.X, dimensions.Y, dimensions.Z }
				local vertical = 1
				for axis = 2, 3 do if math.abs(vectors[axis].Y) > math.abs(vectors[vertical].Y) then vertical = axis end end
				if math.abs(vectors[vertical].Y) > 0.999 then
					local a = vertical % 3 + 1
					local b = a % 3 + 1
					local na = math.max(1, math.ceil(sizes[a] / settings.SectionWidth))
					local nb = math.max(1, math.ceil(sizes[b] / settings.SectionWidth))
					for ia = 1, na do for ib = 1, nb do
						local offsets = { 0, 0, 0 }
						offsets[a] = -sizes[a]/2 + (ia - 0.5) * sizes[a]/na
						offsets[b] = -sizes[b]/2 + (ib - 0.5) * sizes[b]/nb
						local at = cf:PointToWorldSpace(Vector3.new(table.unpack(offsets)))
						local bottom = cf.Position.Y - sizes[vertical]/2
						local top = math.min(cf.Position.Y + sizes[vertical]/2, heightAt(at.X, at.Z))
						if top > bottom + 0.06 then
							local dims = table.clone(sizes)
							dims[a], dims[b], dims[vertical] = sizes[a]/na, sizes[b]/nb, top-bottom
							offsets[vertical] = ((bottom + top)/2 - cf.Position.Y) / vectors[vertical].Y
							add(entry, cf * CFrame.new(Vector3.new(table.unpack(offsets))), Vector3.new(table.unpack(dims)))
						end
					end end
				else
					-- Tilted blocks keep their actual rotation; clipped boundary cells use a finer grid.
					local counts = { math.ceil(dimensions.X/2), math.ceil(dimensions.Y/2), math.ceil(dimensions.Z/2) }
					local cell = dimensions / Vector3.new(table.unpack(counts))
					for x=1,counts[1] do for y=1,counts[2] do for z=1,counts[3] do
						local cellCF = cf * CFrame.new(-dimensions/2 + cell * (Vector3.new(x,y,z)-Vector3.one*0.5))
						local ce = extent(cellCF, cell)
						if cellCF.Position.Y + ce.Y <= heightAt(cellCF.X, cellCF.Z) then add(entry, cellCF, cell) end
					end end end
				end
			end
		end
	end

	-- Keep only geometry connected to a grounded remnant. A spatial hash avoids all-pairs scans.
	local buckets, grounded, queue = {}, {}, {}
	local tolerance = settings.SupportTolerance
	local function eachBucket(box, callback)
		local l, h = box.Low - Vector3.one*tolerance, box.High + Vector3.one*tolerance
		for x=math.floor(l.X/6),math.floor(h.X/6) do
			for y=math.floor(l.Y/6),math.floor(h.Y/6) do
				for z=math.floor(l.Z/6),math.floor(h.Z/6) do callback(x..":"..y..":"..z) end
			end
		end
	end
	for i, box in candidates do
		yieldWork()
		eachBucket(box, function(key)
			buckets[key] = buckets[key] or {}
			table.insert(buckets[key], i)
		end)
		local g = groundAt(box.CFrame.X, box.CFrame.Z) or groundY
		if box.Low.Y <= g + 0.75 then grounded[i] = true; table.insert(queue, i) end
	end
	local head = 1
	while head <= #queue do
		yieldWork()
		local box = candidates[queue[head]]
		head += 1
		local seen = {}
		eachBucket(box, function(key)
			for _, other in buckets[key] or {} do
				if not grounded[other] and not seen[other] then
					seen[other] = true
					local b = candidates[other]
					if box.Low.X <= b.High.X+tolerance and box.High.X >= b.Low.X-tolerance
						and box.Low.Y <= b.High.Y+tolerance and box.High.Y >= b.Low.Y-tolerance
						and box.Low.Z <= b.High.Z+tolerance and box.High.Z >= b.Low.Z-tolerance then
						local hit = Split._ToLocalHit(box.CFrame, { CFrame=b.CFrame, Size=b.Size+Vector3.one*tolerance, Shape="Box" })
						if Split._Intersects(Vector3.zero, box.Size/2, hit) then
							grounded[other] = true
							table.insert(queue, other)
						end
					end
				end
			end
		end)
	end
	local kept, unsupported = 0, 0
	for i, box in candidates do
		if grounded[i] then table.insert(box.Entry.Boxes, { CFrame=box.CFrame, Size=box.Size }); kept += 1
		else unsupported += 1 end
	end
	kept = 0
	for _, entry in entries do mergeBoxes(entry); kept += #entry.Boxes end
	return { Model=model, Entries=entries, GroundY=groundY, BaseHeight=baseHeight, DetectedFloor=detected, Seed=seed,
		KeptBoxes=kept, UnsupportedRemoved=unsupported, Low=low, High=high }
end

return Remains
