-- Bounded sampling: computes at most the configured number of output cells.
local Settings = require(game.ReplicatedStorage.Modules.Debree.BuildingDebrisMotion)
local Remains = require(script.Parent.BuildingRemains)
local Debris = {}
Debris.Settings = {EraseVolume=2, EraseThickness=1.5, MaxPieceAxis=10, FrozenPreview=false,
	PreviewGap=0.06, PreviewPartsPerFrame=80, MaxFrozenPreviewParts=6000}

local function volume(s) return s.X*s.Y*s.Z end
function Debris.Classify(size)
	if volume(size)<Debris.Settings.EraseVolume and math.min(size.X,size.Y,size.Z)<Debris.Settings.EraseThickness then return "Erase" end
	return if math.max(size.X,size.Y,size.Z)>Settings.VoxelSize then "Subdivide" else "Whole"
end

local function section(box, entry)
	local n=Vector3.new(math.ceil(box.Size.X/Settings.VoxelSize),math.ceil(box.Size.Y/Settings.VoxelSize),math.ceil(box.Size.Z/Settings.VoxelSize)):Max(Vector3.one)
	local cell=box.Size/n
	if Debris.Classify(cell)=="Erase" then return nil end
	return {Box=box,Entry=entry,Counts=n,Cell=cell,Count=n.X*n.Y*n.Z,Used={},Taken=0,Volume=volume(cell)}
end

local function take(s,rng)
	if s.Taken>=s.Count then return nil end
	-- Sparse partial Fisher-Yates, with no scan over the whole voxel grid.
	local left=s.Count-s.Taken
	local pick=rng:NextInteger(1,left)
	local index=s.Used[pick] or pick
	s.Used[pick]=s.Used[left] or left
	s.Used[left]=nil
	s.Taken+=1
	local i=index-1
	local z=i%s.Counts.Z; i=math.floor(i/s.Counts.Z)
	local y=i%s.Counts.Y; local x=math.floor(i/s.Counts.Y)
	local offset=-s.Box.Size/2+s.Cell*(Vector3.new(x,y,z)+Vector3.one*0.5)
	return {CFrame=s.Box.CFrame*CFrame.new(offset),Size=s.Cell,Kind=if s.Count==1 then "Whole" else "Voxel"}
end

function Debris.Prepare(plan, yieldWork)
	local entries,sections={},{}
	for _,entry in plan.Entries do
		entry.ServerBoxes,entry.ClientBoxes={},{}
		entry.Removed=Remains.RemovedBoxes(entry)
		entry.RemovedVolume=0
		for _,box in entry.Removed do entry.RemovedVolume+=volume(box.Size) end
		if entry.RemovedVolume>0 then table.insert(entries,entry) end
		if yieldWork then yieldWork() end
	end
	table.sort(entries,function(a,b)return a.RemovedVolume>b.RemovedVolume end)
	local eligible={}
	for i=1,math.min(#entries,Settings.SourcePartsPerBuilding) do eligible[entries[i]]=true end
	for _,entry in entries do
		for _,box in entry.Removed do
			local s=section(box,entry)
			if s then s.ServerEligible=eligible[entry];table.insert(sections,s) end
		end
		if yieldWork then yieldWork() end
	end
	table.sort(sections,function(a,b)
		if a.Volume~=b.Volume then return a.Volume>b.Volume end
		return a.Entry.RemovedVolume>b.Entry.RemovedVolume
	end)
	local rng=Random.new(plan.Seed+2317)
	local server,client=0,0
	for _,s in sections do
		if s.ServerEligible then
			while server<Settings.ServerVoxelsPerBuilding and s.Taken<s.Count do
				table.insert(s.Entry.ServerBoxes,take(s,rng));server+=1
			end
		end
		if server>=Settings.ServerVoxelsPerBuilding then break end
	end
	-- Round-robin keeps the client sample spread around the building.
	while client<Settings.ClientVoxelsPerBuilding do
		local progress=false
		for _,s in sections do
			if s.Taken<s.Count then
				table.insert(s.Entry.ClientBoxes,take(s,rng));client+=1;progress=true
				if client>=Settings.ClientVoxelsPerBuilding then break end
			end
		end
		if not progress then break end
		if yieldWork then yieldWork() end
	end
	plan.ServerVoxelCount,plan.ClientVoxelCount=server,client
	return plan
end

function Debris.Sample(box,limit,seed)
	local s=section(box)
	local out={}
	if s then
		local rng=Random.new(seed or 1)
		for _=1,math.min(limit,s.Count) do table.insert(out,take(s,rng)) end
	end
	return out
end

-- Kept for the existing geometry preview API; still bounded.
function Debris.Build(boxes)
	local out={}
	local stats={RemovedVolume=0,ErasedVolume=0,VisibleVolume=0,ErasedPieces=0,WholePieces=0,VoxelPieces=0,SubdividedSections=0}
	for _,box in boxes do
		stats.RemovedVolume+=volume(box.Size)
		if Debris.Classify(box.Size)=="Erase" then stats.ErasedVolume+=volume(box.Size);stats.ErasedPieces+=1
		else
			for _,cell in Debris.Sample(box,math.max(0,Settings.ClientVoxelsPerBuilding-#out),1) do
				table.insert(out,cell);stats.VisibleVolume+=volume(cell.Size)
				if cell.Kind=="Whole" then stats.WholePieces+=1 else stats.VoxelPieces+=1 end
			end
		end
	end
	return out,stats
end
return Debris
