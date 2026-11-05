-- Cache, prepare three remains variants, and schedule each source exactly once per cast.
local RunService=game:GetService("RunService")
local Settings=require(game.ReplicatedStorage.Modules.Debree.BuildingDebrisMotion)
local Remains=require(script.Parent.BuildingRemains)
local Debris=require(script.Parent.BuildingDebris)
local Split=require(script.Parent.Split)
local Cache={}
local Buildings,Decor,Trees={},{},{}
local PartsSeen,ModelsSeen={},{}
local PartExtents={}
local Casts={}
local Destroyable,Floor,Callbacks
local Started=false
local PendingBuild,BuildHead={},1
local Rng=Random.new()
local LastCast
local Stats={MapScans=0,PreparedVariants=0,Buildings=0,Trees=0,Decor=0,CandidatesTested=0,Processed=0,DuplicateJobs=0,MaxWorkMs=0,WorkTotalMs=0,WorkFrames=0,Errors=0,MaxPrepareSliceMs=0,PrepareTotalMs=0,Preparing=0,BuildingJobs=0,TreeJobs=0,DecorJobs=0}

local function extent(cf,size)
	return (cf.RightVector:Abs()*size.X+cf.UpVector:Abs()*size.Y+cf.LookVector:Abs()*size.Z)/2
end
local function tickBudget(ms)
	local start=os.clock()
	return function(force)
		local elapsed=(os.clock()-start)*1000
		if force or elapsed>=ms then
			Stats.MaxPrepareSliceMs=math.max(Stats.MaxPrepareSliceMs,elapsed)
			Stats.PrepareTotalMs+=elapsed
			task.wait()
			start=os.clock()
		end
	end
end

local function treeOf(thing)
	while thing and thing~=Destroyable do
		if thing:IsA("Model") and thing:GetAttribute("SpecialType")=="Tree" then return thing end
		thing=thing.Parent
	end
end
local function ignored(part)
	local at=part
	while at and at~=Destroyable do
		if at:GetAttribute("DebreeIgnore")==true or at:HasTag("Throwable") then return true end
		if at:IsA("Model") and at:FindFirstChildOfClass("Humanoid") then return true end
		at=at.Parent
	end
	return part:IsA("Seat") or part:IsA("VehicleSeat") or part:IsA("SpawnLocation")
end

local function enqueue(record)
	if record.Queued then return end
	record.Queued=true
	table.insert(PendingBuild,record)
end
local function add(part)
	if not part:IsA("BasePart") or PartsSeen[part] or ignored(part) then return end
	if Floor and part:IsDescendantOf(Floor) then return end
	PartsSeen[part]=true
	PartExtents[part]=extent(part.CFrame,part.Size)
	local building=Remains.BuildingOf(part)
	local tree=treeOf(part)
	if tree then
		if not Trees[tree] then Trees[tree]={Model=tree,Parts={},Low=Vector3.one*math.huge,High=Vector3.one*-math.huge};Stats.Trees+=1 end
		local rec=Trees[tree];table.insert(rec.Parts,part)
		local e=extent(part.CFrame,part.Size);rec.Low=rec.Low:Min(part.Position-e);rec.High=rec.High:Max(part.Position+e)
	elseif building then
		local rec=Buildings[building]
		if not rec then
			rec={Model=building,Parts={},Variants={},Version=0,LastVariant=0,GroundCache={},Low=Vector3.one*math.huge,High=Vector3.one*-math.huge}
			Buildings[building]=rec;Stats.Buildings+=1
		end
		table.insert(rec.Parts,part)
		local e=extent(part.CFrame,part.Size);rec.Low=rec.Low:Min(part.Position-e);rec.High=rec.High:Max(part.Position+e)
		rec.Version+=1
		rec.Failure=nil
		enqueue(rec)
	else
		Decor[part]={Original=part,CFrame=part.CFrame,Size=part.Size}
		Stats.Decor+=1
	end
end

local function prepareWorker()
	while Started do
		local record=PendingBuild[BuildHead]
		if not record then task.wait(0.1);continue end
		BuildHead+=1;record.Queued=false
		Stats.Preparing=1
		local version=record.Version
		local source=table.clone(record.Parts)
		local variants={}
		local explicit=record.Model:GetAttribute("TsunamiRemainSeed")
		local count=if typeof(explicit)=="number" then 1 else math.max(1,Settings.RemainVariants)
		local yieldWork=tickBudget(Settings.PrepareBudgetMs)
		for i=1,count do
			local seed=if typeof(explicit)=="number" then explicit else Rng:NextInteger(1,10000000)
			local ok,plan,reason=pcall(Remains.Plan,record.Model,Floor,nil,{SourceParts=source,Seed=seed,Yield=yieldWork,GroundCache=record.GroundCache})
			if ok and plan then
				Debris.Prepare(plan,yieldWork)
				table.insert(variants,plan)
				if record.Version==version then record.Variants=table.clone(variants) end
				Stats.PreparedVariants+=1
			else
				record.Failure=tostring(if ok then reason else plan)
				warn("Tsunami cache: "..record.Failure)
				break
			end
			yieldWork(true)
		end
		if record.Version~=version then enqueue(record) end
		Stats.Preparing=0
		if BuildHead>#PendingBuild then PendingBuild={};BuildHead=1 end
	end
end

function Cache.GetPlan(model)
	local record=Buildings[model]
	if not record then return nil,"building is absent from tsunami cache" end
	while #record.Variants==0 and not record.Failure and model.Parent do task.wait() end
	if #record.Variants==0 then return nil,record.Failure end
	local index=Rng:NextInteger(1,#record.Variants)
	if #record.Variants>1 and index==record.LastVariant then index=index%#record.Variants+1 end
	record.LastVariant=index
	local template=record.Variants[index]
	local plan=table.clone(template)
	plan.Entries={}
	for _,entry in template.Entries do table.insert(plan.Entries,table.clone(entry)) end
	return plan
end

local function hitTime(cf,size,wave,footprint,cachedExtent)
	local e=cachedExtent or extent(cf,size)
	local side=wave.Side
	local relative=cf.Position-wave.Start
	local lateral=math.abs(relative:Dot(side))
	local radius=math.abs(side.X)*e.X+math.abs(side.Z)*e.Z
	if lateral> wave.Width/2+radius then return nil end
	local along=relative:Dot(wave.Direction)
	local reach=math.abs(wave.Direction.X)*e.X+math.abs(wave.Direction.Z)*e.Z
	if along+reach < -wave.Depth/2 or along-reach>wave.Distance-30+wave.Depth/2 then return nil end
	if not footprint and (cf.Y+e.Y<wave.LowY or cf.Y-e.Y>wave.HighY) then return nil end
	local interior=lateral+radius<=wave.Width/2 and along-reach>=-wave.Depth/2 and along+reach<=wave.Distance-30+wave.Depth/2
	if not interior then
		local corridor=if footprint then wave.BuildingCorridor else wave.Corridor
		if not Split._Intersects(Vector3.zero,size/2,Split._ToLocalHit(cf,corridor)) then return nil end
	end
	return math.clamp(along-reach-wave.Depth/2,0,math.max(0,wave.Distance-30))/wave.Speed
end

local function earliest(cf,size,waves,footprint,cachedExtent)
	local best,which
	for _,wave in waves do
		local at=hitTime(cf,size,wave,footprint,cachedExtent)
		if at and (not best or at<best) then best,which=at,wave end
	end
	return best,which
end

local function context(cast,job)
	local wave=job.Wave
	local now=workspace:GetServerTimeNow()
	local travel=math.clamp((now-cast.StartedAt)*wave.Speed,0,wave.Distance-30)
	return {Direction=wave.Direction,Speed=wave.Speed,Depth=wave.Depth,
		Front=wave.Start+wave.Direction*(travel+wave.Depth/2),At=now,
		EndAt=cast.StartedAt+math.max(0,wave.Distance-30)/wave.Speed,Seed=cast.Seed,
		ContactAt=cast.StartedAt+job.At}
end

-- Heap of sorted lanes: buildings never sit behind thousands of decoration jobs.
local function laneAt(lane) return lane.Jobs[lane.Head].At end
local function push(heap,lane)
	local i=#heap+1
	while i>1 do
		local parent=math.floor(i/2)
		if laneAt(heap[parent])<=laneAt(lane) then break end
		heap[i]=heap[parent];i=parent
	end
	heap[i]=lane
end
local function pop(heap)
	local top,last=heap[1],table.remove(heap)
	if #heap>0 then
		local i=1
		while i*2<=#heap do
			local child=i*2
			if child<#heap and laneAt(heap[child+1])<laneAt(heap[child]) then child+=1 end
			if laneAt(last)<=laneAt(heap[child]) then break end
			heap[i]=heap[child];i=child
		end
		heap[i]=last
	end
	return top
end
local function publish(cast,jobs,critical)
	if cast.Cancelled or #jobs==0 then return end
	table.sort(jobs,function(a,b)
		if a.At~=b.At then return a.At<b.At end
		return (a.Priority or 0)>(b.Priority or 0)
	end)
	cast.TotalJobs+=#jobs
	push(if critical then cast.Critical else cast.Decor,{Jobs=jobs,Head=1})
end

function Cache.PrepareCast(waves)
	local cast={Waves=waves,Critical={},Decor={},TotalJobs=0,CompletedJobs=0,Seen={},Seed=Rng:NextInteger(1,10000000),ClientDecor=0}
	LastCast=cast
	for _,wave in waves do
		wave.Distance=(wave.Target-wave.Start).Magnitude
		wave.Side=wave.Direction:Cross(Vector3.yAxis)
		wave.LowY=math.min(wave.Start.Y,wave.Target.Y)-wave.Below
		wave.HighY=math.max(wave.Start.Y,wave.Target.Y)+wave.Above
		local middle=(wave.Start+wave.Target)/2+Vector3.yAxis*((wave.Above-wave.Below)/2)
		local cf=CFrame.lookAlong(middle,wave.Direction)
		wave.Corridor={CFrame=cf,Size=Vector3.new(wave.Width,wave.HighY-wave.LowY,wave.Distance+wave.Depth),Shape="Box"}
		wave.BuildingCorridor={CFrame=cf,Size=Vector3.new(wave.Width,10000,wave.Distance+wave.Depth),Shape="Box"}
	end
	function cast:Start(at) self.StartedAt=at or workspace:GetServerTimeNow();Casts[self]=true end
	function cast:Cancel() self.Cancelled=true;Casts[self]=nil;self.Critical={};self.Decor={};self.Seen={} end
	local function addJob(jobs,key,cf,size,kind,state,entry)
		if cast.Cancelled or cast.Seen[key] then return end
		cast.Seen[key]=true;Stats.CandidatesTested+=1
		local at,wave=earliest(cf,size,waves,kind=="Building",PartExtents[key])
		if at then table.insert(jobs,{Key=key,At=at,Wave=wave,Kind=kind,State=state,Entry=entry}) end
	end
	task.spawn(function()
		local yieldWork=tickBudget(Settings.PrepareBudgetMs)
		-- Publish tree hits immediately; building preparation cannot hold them up.
		local treeJobs={}
		for model,record in Trees do
			if model.Parent then addJob(treeJobs,model,CFrame.new((record.Low+record.High)/2),record.High-record.Low,"Tree",record) end
		end
		publish(cast,treeJobs,true)
		local ordered={}
		for model,record in Buildings do
			local at=earliest(CFrame.new((record.Low+record.High)/2),record.High-record.Low,waves,true)
			if model.Parent and at then table.insert(ordered,{Model=model,Record=record,At=at}) end
		end
		table.sort(ordered,function(a,b)return a.At<b.At end)
		for _,item in ordered do
			if cast.Cancelled then return end
			local state=Callbacks.BuildingState(item.Model)
			if state then
				local contact,firstWave
				-- First real source-part contact triggers the entire marked model.
				for _,entry in state.Plan.Entries do
					if not entry.Ignore and entry.Original.Transparency<1 then
						local at,wave=earliest(entry.CFrame,entry.Size,waves,true,PartExtents[entry.Original])
						if at and (not contact or at<contact) then contact,firstWave=at,wave end
					end
					yieldWork()
				end
				local jobs={}
				if contact then
					-- Progressive failure: each part goes when the wave front reaches its leading edge
					-- (projected along the first wave's travel), so the facade facing the wave breaks first
					-- and the collapse sweeps through the building instead of popping all at once.
					local dir,origin=firstWave.Direction,firstWave.Start
					local sweepSpeed=firstWave.Speed*(Settings.BuildingSweepRatio or 1)
					local jitter=Settings.BuildingCrumbleJitter or 0
					local leading={}
					local firstEdge=math.huge
					for _,entry in state.Plan.Entries do
						if not entry.Ignore and not entry.Done and not cast.Seen[entry.Original] then
							local e=PartExtents[entry.Original] or extent(entry.CFrame,entry.Size)
							local reach=math.abs(dir.X)*e.X+math.abs(dir.Z)*e.Z
							local edge=(entry.CFrame.Position-origin):Dot(dir)-reach
							leading[entry]=edge
							if edge<firstEdge then firstEdge=edge end
						end
					end
					for _,entry in state.Plan.Entries do
						local edge=leading[entry]
						if edge then
							cast.Seen[entry.Original]=true;Stats.CandidatesTested+=1
							local at=contact+math.max(0,edge-firstEdge)/sweepSpeed+Rng:NextNumber(0,jitter)
							table.insert(jobs,{Key=entry.Original,At=at,Wave=firstWave,Kind="Building",State=state,Entry=entry,Priority=entry.RemovedVolume or 0})
						end
					end
				end
				publish(cast,jobs,true)
			end
			yieldWork()
		end
		cast.CriticalReady=true
		cast.Ready=cast.DecorReady==true
	end)
	task.spawn(function()
		local yieldWork=tickBudget(Settings.PrepareBudgetMs)
		local jobs={}
		for part,record in Decor do
			if cast.Cancelled then return end
			if part:IsDescendantOf(Destroyable) then addJob(jobs,part,part.CFrame,part.Size,"Decor",record) end
			yieldWork()
		end
		publish(cast,jobs,false)
		cast.DecorReady=true
		cast.Ready=cast.CriticalReady==true
	end)
	return cast
end

local function runDue(kind,budgetMs,maxJobs)
	local start=os.clock()
	local jobs=0
	while jobs<maxJobs and (os.clock()-start)*1000<budgetMs do
		local chosen,lane,absoluteAt
		for cast in Casts do
			if cast.Cancelled then Casts[cast]=nil;continue end
			local first=cast[kind][1]
			if first then
				local at=cast.StartedAt+laneAt(first)
				if not absoluteAt or at<absoluteAt then chosen,lane,absoluteAt=cast,first,at end
			end
		end
		local now=workspace:GetServerTimeNow()
		if not chosen or absoluteAt>now then break end
		pop(chosen[kind])
		local job=lane.Jobs[lane.Head]
		lane.Head+=1
		if lane.Head<=#lane.Jobs then push(chosen[kind],lane) end
		chosen.Processed=chosen.Processed or {}
		if chosen.Processed[job.Key] then Stats.DuplicateJobs+=1;continue end
		chosen.Processed[job.Key]=true;chosen.CompletedJobs+=1;jobs+=1
		local delay=math.max(0,now-absoluteAt)*1000
		local label=job.Kind
		Stats[label.."DelayTotalMs"]=(Stats[label.."DelayTotalMs"] or 0)+delay
		Stats[label.."DelaySamples"]=(Stats[label.."DelaySamples"] or 0)+1
		Stats[label.."MaxDelayMs"]=math.max(Stats[label.."MaxDelayMs"] or 0,delay)
		local ok,result=pcall(Callbacks.Apply,chosen,job,context(chosen,job))
		if not ok then Stats.Errors+=1;warn("Tsunami destruction: "..tostring(result)) end
		if ok and result and result~=0 then
			Stats[job.Kind.."Jobs"]+=1
			if job.Kind=="Building" then
				chosen.BuildingStarted=chosen.BuildingStarted or {}
				if not chosen.BuildingStarted[job.State] then
					chosen.BuildingStarted[job.State]=true
					Stats.BuildingFirstDelayMaxMs=math.max(Stats.BuildingFirstDelayMaxMs or 0,delay)
					Stats.BuildingFirstDelayTotalMs=(Stats.BuildingFirstDelayTotalMs or 0)+delay
					Stats.BuildingFirstSamples=(Stats.BuildingFirstSamples or 0)+1
				end
			end
		end
		if job.Kind=="Building" and lane.Head>#lane.Jobs then
			Stats.BuildingCompletionMaxMs=math.max(Stats.BuildingCompletionMaxMs or 0,(workspace:GetServerTimeNow()-absoluteAt)*1000)
		end
		Stats.Processed+=1
	end
	return jobs,(os.clock()-start)*1000
end

local function step()
	local critical,criticalMs=runDue("Critical",Settings.CriticalWorkBudgetMs,Settings.CriticalJobsPerFrame)
	local decor,decorMs=runDue("Decor",Settings.DecorWorkBudgetMs,Settings.DecorJobsPerFrame)
	for cast in Casts do
		if cast.Ready and #cast.Critical==0 and #cast.Decor==0 then
			Casts[cast]=nil;cast.Finished=true;cast.Seen={};cast.Processed=nil
		end
	end
	if critical+decor>0 then
		local ms=criticalMs+decorMs
		Stats.WorkFrames+=1;Stats.WorkTotalMs+=ms;Stats.MaxWorkMs=math.max(Stats.MaxWorkMs,ms)
	end
end

function Cache.Stats()
	local out=table.clone(Stats)
	if LastCast then out.LastCast={Ready=LastCast.Ready==true,Cancelled=LastCast.Cancelled==true,Started=LastCast.StartedAt~=nil,Jobs=LastCast.TotalJobs,Completed=LastCast.CompletedJobs} end
	out.PendingPlans=math.max(0,#PendingBuild-BuildHead+1)
	out.ActiveCasts=0;for _ in Casts do out.ActiveCasts+=1 end
	return out
end
function Cache.Buildings() return Buildings end
function Cache.Start(destroyable,floor,callbacks)
	if Started then return end
	Started=true;Destroyable=destroyable;Floor=floor;Callbacks=callbacks
	-- This is the only full descendant enumeration in this subsystem.
	Stats.MapScans+=1
	for _,part in Destroyable:GetDescendants() do add(part) end
	Destroyable.DescendantAdded:Connect(function(part)
		if not PartsSeen[part] then task.defer(add,part) end
	end)
	task.spawn(prepareWorker)
	RunService.Heartbeat:Connect(step)
end
return Cache
