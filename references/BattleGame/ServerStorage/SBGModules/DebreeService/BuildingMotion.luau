-- Replicated, interactive server rubble plus bounded client carry effects.
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Players=game:GetService("Players")
local PhysicsService=game:GetService("PhysicsService")
local RunService=game:GetService("RunService")
local Settings=require(ReplicatedStorage.Modules.Debree.BuildingDebrisMotion)
local Records=require(ReplicatedStorage.Modules.Debree.Records)
local Motion={}
local Remote,Root
local States,Native,Trees={},{},{}
local Carrying,Ended={},{}
local NextId,NextPacket,Active,Total=0,0,0,0
local Started=false
local Clock=0

local function volume(s)return s.X*s.Y*s.Z end
local function send(payload,player)
	if player then Remote:FireClient(player,payload)
	else
		local stream=require(script.Parent.Stream)
		for _,p in Players:GetPlayers() do if stream.IsReady(p) then Remote:FireClient(p,payload) end end
	end
end
local function deadline(state)return workspace:GetServerTimeNow()+math.max(0,state.Expires-time()) end
local function identify(state)
	if state.MotionClosed then return false end
	if state.MotionId then return true end
	NextId+=1;state.MotionId=NextId;state.MotionPackets={};state.ServerParts={}
	States[NextId]=state
	return true
end
local function waveOf(context,state)
	context=context or {}
	local dir=context.Direction or Vector3.new(0,0,-1)
	dir=Vector3.new(dir.X,0,dir.Z)
	dir=if dir.Magnitude>0.001 then dir.Unit else Vector3.new(0,0,-1)
	local now=workspace:GetServerTimeNow()
	return {Direction=dir,Speed=context.Speed or 120,Depth=context.Depth or 157,
		Front=context.Front or (state.Plan.Low+state.Plan.High)/2,At=context.At or now,EndAt=context.EndAt or now+3,ContactAt=context.ContactAt or now}
end

-- Carried rubble goes back to its normal (player-collidable) group once the wave lets go.
local function endCarry(part,record)
	local carry=record.Carry
	if not carry then return end
	record.Carry=nil;Carrying[part]=nil
	if carry.Force then carry.Force:Destroy() end
	if carry.Attachment then carry.Attachment:Destroy() end
	if part.Parent then part.CollisionGroup=Settings.ServerCollisionGroup end
end

local function serverPart(state,item)
	if Active>=Settings.MaxActiveServerVoxels or Total>=Settings.MaxServerVoxels
		or (state.ServerCreated or 0)>=Settings.ServerVoxelsPerBuilding then return false end
	local box,wave=item.Box,item.Wave
	local part=Instance.new("Part")
	part.Name="BuildingVoxel"
	part.Size=box.Size;part.CFrame=box.CFrame
	part.Color=item.Color;part.Material=item.Material;part.MaterialVariant=item.Variant;part.Transparency=item.Transparency
	part.TopSurface=Enum.SurfaceType.Smooth;part.BottomSurface=Enum.SurfaceType.Smooth
	part.Anchored=false;part.CanCollide=true;part.CanQuery=true;part.CanTouch=true
	part.CollisionGroup=Settings.ServerCarryCollisionGroup
	part:SetAttribute("TsunamiServerDebris",true);part:SetAttribute("DebreeIgnore",true)
	part:SetAttribute("BuildingId",state.MotionId)
	local record={State=state,Moving=true,Still=0,Born=time()}
	Native[part]=record;state.ServerParts[part]=true
	state.ServerCreated=(state.ServerCreated or 0)+1;Active+=1;Total+=1
	part.Destroying:Once(function()
		Native[part]=nil;Carrying[part]=nil;state.ServerParts[part]=nil;Total=math.max(0,Total-1)
		if record.Moving then Active=math.max(0,Active-1);record.Moving=false end
	end)
	part.Parent=Root
	part:SetNetworkOwner(nil)
	part:ApplyImpulse((wave.Direction*wave.Speed*Settings.ServerSpeedRatio+Vector3.yAxis*Settings.ServerLift)*part.AssemblyMass)
	part.AssemblyAngularVelocity=Vector3.yAxis:Cross(wave.Direction)*0.8
	-- Carried by the wave with a force (physics replication keeps it smooth on clients), then
	-- released to fall and settle naturally. While carried it can't hit players.
	local attachment=Instance.new("Attachment");attachment.Parent=part
	local force=Instance.new("VectorForce")
	force.RelativeTo=Enum.ActuatorRelativeTo.World;force.ApplyAtCenterOfMass=true
	force.Attachment0=attachment;force.Force=Vector3.zero;force.Parent=part
	record.Carry={Wave=wave,Force=force,Attachment=attachment,Seed=math.random()*1000,
		Until=workspace:GetServerTimeNow()+Settings.ServerCarryMin+math.random()*(Settings.ServerCarryMax-Settings.ServerCarryMin),
		Ratio=Settings.ServerCarryRatioMin+math.random()*(Settings.ServerCarryRatioMax-Settings.ServerCarryRatioMin)}
	Carrying[part]=record
	return true
end

local function stepCarry()
	if next(Carrying)==nil then return end
	local now=workspace:GetServerTimeNow()
	local gravity=workspace.Gravity
	for part,record in Carrying do
		local carry=record.Carry
		local wave=carry.Wave
		local dir=wave.Direction
		local pos=part.Position
		local behind=(wave.Front+dir*(wave.Speed*(now-wave.At))-pos):Dot(dir)
		if now>=carry.Until or now>=wave.EndAt or behind>wave.Depth or part.Anchored then
			table.insert(Ended,part)
		else
			local v=part.AssemblyLinearVelocity
			local side=dir:Cross(Vector3.yAxis)
			local inWater=if behind>=-6 then 1 else 0.25
			local n=math.noise(pos.X/30,pos.Z/30,now*0.8+carry.Seed)
			local forward=math.clamp((wave.Speed*carry.Ratio-v:Dot(dir))*Settings.ServerCarryDrag,-120,120)
			local vertical=math.clamp(gravity*Settings.ServerBuoyancy+n*Settings.ServerTurbulence-v.Y*Settings.ServerVerticalDrag,-120,gravity)
			carry.Force.Force=(dir*forward-side*v:Dot(side)*Settings.SideDrag+Vector3.yAxis*vertical)*part.AssemblyMass*inWater
		end
	end
	for _,part in Ended do
		local record=Carrying[part]
		if record then endCarry(part,record) end
	end
	table.clear(Ended)
end

function Motion.Queue(state,boxes,group,serverBoxes,context)
	if not Settings.Enabled then return end
	if not identify(state) then return end
	state.MotionPending=state.MotionPending or {}
	local wave=waveOf(context,state)
	for _,list in {{Boxes=boxes or {},Server=false},{Boxes=serverBoxes or {},Server=true}} do
		for _,box in list.Boxes do
			table.insert(state.MotionPending,{Box=box,Server=list.Server,Wave=wave,Color=group.Color,
				Material=group.Material,Variant=group.Variant,Transparency=group.Transparency})
		end
	end
end

function Motion.Flush(state)
	if state.MotionClosed or not state.MotionId then return end
	if time()>=state.Expires then Motion.Clear(state);return end
	state.MotionPackets=state.MotionPackets or {}
	local resetAt=deadline(state)
	for _,packet in state.MotionPackets do packet.ResetAt=resetAt end
	local pending=state.MotionPending or {}
	state.MotionPending=nil
	table.sort(pending,function(a,b)return volume(a.Box.Size)>volume(b.Box.Size) end)
	local buckets={}
	for _,item in pending do
		if item.Server and serverPart(state,item) then continue end
		if (state.ClientSent or 0)>=(state.ClientLimit or Settings.ClientVoxelsPerBuilding) then continue end
		if workspace:GetServerTimeNow()>item.Wave.EndAt+Settings.SinkLifetime then continue end
		state.ClientSent=(state.ClientSent or 0)+1
		local key=tostring(item.Material)..":"..item.Variant..":"..tostring(item.Color)..":"..item.Transparency..":"..tostring(item.Wave.Direction)..":"..item.Wave.EndAt
		buckets[key]=buckets[key] or {};table.insert(buckets[key],item)
	end
	for _,list in buckets do
		for first=1,#list,120 do
			local last=math.min(first+119,#list)
			local geometry=buffer.create((last-first+1)*Records.PIECE_SIZE)
			for i=first,last do local box=list[i].Box;Records.WritePiece(geometry,i-first+1,box.CFrame,box.Size,i-first+1) end
			NextPacket+=1
			local sample=list[first]
			local packet={Kind="Add",BuildingId=state.MotionId,PacketId=NextPacket,ResetAt=resetAt,Wave=sample.Wave,
				Geometry=geometry,Color=sample.Color,Material=sample.Material,Variant=sample.Variant,
				Transparency=sample.Transparency,Category=state.Category or "Building",ContactAt=sample.Wave.ContactAt,PieceKind="Voxel",Seed=state.Plan.Seed+NextPacket*137}
			table.insert(state.MotionPackets,packet);send(packet)
		end
	end
	if not state.LastDeadline or math.abs(state.LastDeadline-resetAt)>0.1 then
		send({Kind="Deadline",BuildingId=state.MotionId,ResetAt=resetAt});state.LastDeadline=resetAt
	end
end

function Motion.Clear(state)
	local id=state.MotionId
	state.MotionClosed=true
	state.MotionId=nil
	if id then States[id]=nil end
	local parts=state.ServerParts or {}
	for part in parts do part:Destroy() end
	state.ServerParts={}
	state.MotionPackets={}
	state.MotionPending=nil
	if id then send({Kind="Clear",BuildingId=id}) end
end

function Motion.Snapshot(player)
	local now=workspace:GetServerTimeNow()
	for _,state in States do
		if time()<state.Expires then
			for _,packet in state.MotionPackets or {} do
				if now<packet.Wave.EndAt+Settings.SinkLifetime then
					local copy=table.clone(packet);copy.ResetAt=deadline(state);copy.Snapshot=true;send(copy,player)
				end
			end
		end
	end
end

local function restoreTree(model,info)
	Trees[model]=nil
	for _,snapshot in info.Parts do if snapshot.Part.Parent then snapshot.Part.Anchored=true end end
	for _,weld in info.Welds do weld:Destroy() end
	for _,snapshot in info.Parts do
		local part=snapshot.Part
		if part.Parent then
			part.CFrame=snapshot.CFrame;part.AssemblyLinearVelocity=Vector3.zero;part.AssemblyAngularVelocity=Vector3.zero
			part.CanCollide=snapshot.CanCollide;part.CanQuery=snapshot.CanQuery;part.CanTouch=snapshot.CanTouch
			part.CollisionGroup=snapshot.CollisionGroup;part.Massless=snapshot.Massless;part.RootPriority=snapshot.RootPriority
			part.Anchored=snapshot.Anchored
			if snapshot.WindShake then part:AddTag("WindShake") end
		end
	end
	if info.Parent.Parent and model.Parent then model.Parent=info.Parent end
end

function Motion.PushTree(record,context,resetTime)
	local model=record.Model
	if Trees[model] or not model.Parent or model:GetAttribute("IsDestroyed") then return false end
	local parts={}
	local root,best=nil,-math.huge
	for _,part in record.Parts do
		if part:IsDescendantOf(model) then
			if not part.Anchored then return false end -- another ability already owns this tree
			table.insert(parts,part)
			local score=part.Size.Y/math.max(0.1,part.Size.X*part.Size.Z)
			if score>best then root,best=part,score end
		end
	end
	if not root then return false end
	local info={Parent=model.Parent,Parts={},Welds={},Root=root,ResetAt=time()+resetTime,Still=0,Moving=true}
	Trees[model]=info
	table.sort(parts,function(a,b)return volume(a.Size)>volume(b.Size) end)
	local collide={[root]=true}
	local n=1
	for _,part in parts do if n>=Settings.TreeCollisionParts then break end;if not collide[part] then collide[part]=true;n+=1 end end
	for _,part in parts do
		table.insert(info.Parts,{Part=part,CFrame=part.CFrame,Anchored=part.Anchored,CanCollide=part.CanCollide,
			CanQuery=part.CanQuery,CanTouch=part.CanTouch,CollisionGroup=part.CollisionGroup,Massless=part.Massless,RootPriority=part.RootPriority,WindShake=part:HasTag("WindShake")})
		part:RemoveTag("WindShake")
		if part~=root then
			local weld=Instance.new("WeldConstraint");weld.Name="TsunamiTreeWeld";weld.Part0=root;weld.Part1=part;weld.Parent=root
			table.insert(info.Welds,weld)
		end
		part.CollisionGroup=Settings.TreeCollisionGroup
		part.CanCollide=collide[part]==true;part.CanQuery=collide[part]==true;part.CanTouch=part==root
		part.Massless=part~=root;part.RootPriority=if part==root then 127 else -127
	end
	model.Parent=Root
	for _,part in parts do part.Anchored=false end
	root:SetNetworkOwner(nil)
	root:ApplyImpulse((context.Direction*context.Speed*Settings.TreeSpeedRatio+Vector3.yAxis*Settings.TreeLift)*root.AssemblyMass)
	root.AssemblyAngularVelocity=Vector3.yAxis:Cross(context.Direction)*1.3
	return true
end

local function tickMotion(dt)
	Clock+=dt;if Clock<0.2 then return end
	local interval=Clock;Clock=0
	for part,record in Native do
		if time()>=record.State.Expires or part.Position.Y<workspace.FallenPartsDestroyHeight+40 then part:Destroy()
		elseif record.Moving then
			local still=part.AssemblyLinearVelocity.Magnitude<Settings.ServerSettleSpeed and part.AssemblyAngularVelocity.Magnitude<Settings.ServerSettleAngularSpeed
			record.Still=if still then record.Still+interval else 0
			if record.Still>=Settings.ServerSettleSeconds then
				endCarry(part,record)
				part.Anchored=true;record.Moving=false;Active=math.max(0,Active-1)
			elseif time()-record.Born>Settings.ServerMaxMoveSeconds then part:Destroy() end
		end
	end
	local treeCount,movingTrees=0,0
	for model,info in Trees do
		treeCount+=1
		if not model.Parent or time()>=info.ResetAt then restoreTree(model,info)
		elseif info.Root.Position.Y<workspace.FallenPartsDestroyHeight+50 then
			info.Root.Anchored=true;model.Parent=game.ServerStorage
		elseif info.Moving then
			movingTrees+=1
			local still=info.Root.AssemblyLinearVelocity.Magnitude<1.5 and info.Root.AssemblyAngularVelocity.Magnitude<0.8
			info.Still=if still then info.Still+interval else 0
			if info.Still>=0.6 then info.Root.Anchored=true;info.Moving=false end
		end
	end
	for id,state in States do if time()>=state.Expires then Motion.Clear(state) end end
	Root:SetAttribute("ActiveServerVoxels",Active);Root:SetAttribute("ServerVoxels",Total)
	Root:SetAttribute("Trees",treeCount);Root:SetAttribute("MovingTrees",movingTrees)
end

function Motion.Start()
	if Started then return end;Started=true
	local folder=ReplicatedStorage.Remotes.Debree
	Remote=folder:FindFirstChild("BuildingMotion")
	if not Remote then Remote=Instance.new("RemoteEvent");Remote.Name="BuildingMotion";Remote.Parent=folder end
	Root=Instance.new("Folder");Root.Name="TsunamiServerDebris";Root.Parent=workspace.World.Visuals
	for _,name in {Settings.CollisionGroup,Settings.ServerCollisionGroup,Settings.TreeCollisionGroup} do
		if not PhysicsService:IsCollisionGroupRegistered(name) then PhysicsService:RegisterCollisionGroup(name) end
		PhysicsService:CollisionGroupSetCollidable(name,name,false)
	end
	PhysicsService:CollisionGroupSetCollidable(Settings.ServerCollisionGroup,Settings.TreeCollisionGroup,false)
	local carryGroup=Settings.ServerCarryCollisionGroup
	if not PhysicsService:IsCollisionGroupRegistered(carryGroup) then PhysicsService:RegisterCollisionGroup(carryGroup) end
	PhysicsService:CollisionGroupSetCollidable(carryGroup,carryGroup,false)
	PhysicsService:CollisionGroupSetCollidable(carryGroup,Settings.TreeCollisionGroup,false)
	if PhysicsService:IsCollisionGroupRegistered("Players") then
		PhysicsService:CollisionGroupSetCollidable(carryGroup,"Players",false)
	end
	RunService.PreSimulation:Connect(stepCarry)
	RunService.Heartbeat:Connect(tickMotion)
end
return Motion
