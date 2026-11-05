


local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ContentProvider = game:GetService("ContentProvider")
local logger = require(script.mod.logger)
local utility = require(script.mod.utility)
local beam = require(script.effects.beam)
local spin = require(script.effects.spin)
local mesh = require(script.effects.mesh)
local bezier = require(script.effects.bezier)
local screen = require(script.effects.screen)
local particle = require(script.effects.particle)
local tween_property = require(script.effects.tween_property)
local shockwave_ring = require(script.effects.shockwave_ring)
local shockwave_line = require(script.effects.shockwave_line)
local shockwave_debris = require(script.effects.shockwave_debris)
local Promise = require(script.pkg.Promise)
local v1 = script:FindFirstAncestorOfClass("Plugin")
local v2 = RunService:IsServer() or v1
local t = {
	scope = {},
	setup = false
}
local function assembleMeshVFX(p1, p2) --[[ assembleMeshVFX | Line: 115 | Upvalues: t (copy), logger (copy), utility (copy) ]]
	if not t.setup then
		logger.error("API not initialized")
	end
	local v1 = utility.getRanomId()
	if not p1:IsA("Part") then
		local v2 = p1:Clone()
		v2.Archivable = false
		v2.Locked = true
		v2.Parent = workspace.Thrown
		game.Debris:AddItem(v2, 8)
		table.insert(p2, v2)
		return v2
	end
	local v3 = t.caches.shared_part:get(v1)
	v3.CFrame = p1.CFrame
	local v4 = v3._getReal()
	utility.copyProperties(p1, v4, utility.COPY_PART_PROPERTIES)
	utility.copyProperties(p1, v4, utility.COPY_EXTENDED_PART_PROPERTIES)
	local v5 = p1:Clone()
	for v6, v7 in v5:GetChildren() do
		v7.Parent = v4
	end
	v5:Destroy()
	local function f8() --[[ Line: 139 | Upvalues: t (ref), v1 (copy) ]]
		t.caches.shared_part:free(v1)
	end
	table.insert(p2, f8)
	return v3
end
local v3 = table.create(64)
local v4 = table.create(64)
local v5 = false
local v6 = coroutine.create(function() --[[ Line: 167 | Upvalues: v3 (copy), v4 (copy), v5 (ref) ]]
end)
local v7 = setmetatable({}, {
	__mode = "k"
})
local function makeAbstr(p1) --[[ makeAbstr | Line: 199 | Upvalues: v7 (copy), v3 (copy), v4 (copy), v5 (ref), v6 (copy) ]]
	local v1 = v7[p1]
	if v1 then
		return v1
	else
		local t = {
			__newindex = function(p12, p2, p3) --[[ __newindex | Line: 205 | Upvalues: v3 (ref), p1 (copy), v4 (ref), v5 (ref), v6 (ref) ]]
				if p2 == "CFrame" then
					table.insert(v3, p1)
					table.insert(v4, p3)
					if not v5 then
						v5 = true
						task.defer(v6)
					end
				else
					p1[p2] = p3
				end
			end,
			__index = function(p12, p2) --[[ __index | Line: 219 | Upvalues: p1 (copy) ]]
				local v1 = p1[p2]
				if typeof(v1) == "function" then
					return function(p12, ...) --[[ Line: 223 | Upvalues: v1 (copy), p1 (ref) ]]
						return v1(p1, ...)
					end
				else
					return v1
				end
			end
		}
		local v2 = setmetatable({
			_getReal = function() --[[ _getReal | Line: 232 | Upvalues: p1 (copy) ]]
				return p1
			end
		}, t)
		v7[p1] = v2
		return v2
	end
end
local function createPartCache(p1) --[[ createPartCache | Line: 240 | Upvalues: makeAbstr (copy) ]]
	local t = {}
	return {
		get = function(p12, p2) --[[ get | Line: 245 | Upvalues: t (copy), makeAbstr (ref), p1 (copy) ]]
			local v1 = t[p2]
			if v1 then
				return makeAbstr(v1)
			else
				local v2 = p1:Clone()
				v2.Archivable = false
				v2.Parent = workspace.Thrown
				t[p2] = v2
				return makeAbstr(v2)
			end
		end,
		free = function(p1, p2) --[[ free | Line: 260 | Upvalues: t (copy) ]]
			local v1 = t[p2]
			if v1 then
				t[p2] = nil
				v1:Destroy()
			end
		end,
		destroy = function(p1) --[[ destroy | Line: 271 | Upvalues: t (copy) ]]
			for v1, v2 in t do
				v2:Destroy()
				t[v1] = nil
			end
		end
	}
end
function t.init(p1) --[[ init | Line: 281 | Upvalues: t (copy), v2 (copy), utility (copy), logger (copy), RunService (copy), v1 (copy), createPartCache (copy), bezier (copy), shockwave_ring (copy), shockwave_line (copy), shockwave_debris (copy), ContentProvider (copy), CollectionService (copy), mesh (copy), assembleMeshVFX (copy) ]]
	if t.setup then
		return
	end
	if v2 then
		task.spawn(function() --[[ Line: 287 | Upvalues: utility (ref), logger (ref) ]]
			local count = 0
			local v1, v2
			repeat
				count = count + 1
				v1, v2 = pcall(utility.setCollisionGroups, utility.COLLISION_GROUPS)
				if not v1 then
					task.wait(count)
				end
			until v1 or count >= 5
			if v1 then
				return
			end
			logger.warn((("couldn\'t register necessary collision groups after %* tries with the last error being: %*"):format(count, v2)))
		end)
	end
	t.setup = true
	if RunService:IsServer() and not v1 then
		return
	end
	shared.vfx = t
	local Part = Instance.new("Part")
	Part.Transparency = 1
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.Locked = true
	Part.CollisionGroup = "ForgeMouseIgnore"
	local v12 = createPartCache(Part)
	t.caches = {
		shared_part = v12
	}
	local scope = t.scope
	local function f2() --[[ Line: 340 | Upvalues: v12 (ref) ]]
		v12:destroy()
	end
	table.insert(scope, f2)
	bezier.init(v12)
	shockwave_ring.init(v12)
	shockwave_line.init(v12)
	shockwave_debris.init(v12)
	local t2 = {}
	local t3 = {}
	local function preload(p1) --[[ preload | Line: 355 | Upvalues: t2 (copy), ContentProvider (ref) ]]
		if p1 ~= "" and not t2[p1] then
			t2[p1] = true
			task.spawn(function() --[[ Line: 362 | Upvalues: ContentProvider (ref), p1 (copy) ]]
				pcall(function() --[[ Line: 363 | Upvalues: ContentProvider (ref), p1 (ref) ]]
					ContentProvider:PreloadAsync({ p1 })
				end)
			end)
		end
	end
	local function loadTextures(p1) --[[ loadTextures | Line: 369 | Upvalues: utility (ref), t2 (copy), ContentProvider (ref), v1 (ref), CollectionService (ref), t3 (copy) ]]
		if p1:IsDescendantOf(workspace.Terrain) then
			return
		end
		if utility.isMeshVFX(p1) then
			local Start = p1:FindFirstChild("Start")
			if not (Start and Start:IsA("BasePart")) then
				return
			end
			local t = {}
			local function refresh() --[[ refresh | Line: 383 | Upvalues: utility (ref), p1 (copy), Start (copy), t2 (ref), ContentProvider (ref), v1 (ref), CollectionService (ref) ]]
				local v12, v2 = utility.getMeshDecals(p1, Start)
				local function add(p1) --[[ add | Line: 386 | Upvalues: t2 (ref), ContentProvider (ref) ]]
					local v1 = typeof(p1) == "Instance" and p1.Texture or p1
					if v1 == "" then
						return
					end
					if t2[v1] then
						return
					end
					t2[v1] = true
					task.spawn(function() --[[ Line: 362 | Upvalues: ContentProvider (ref), v1 (copy) ]]
						pcall(function() --[[ Line: 363 | Upvalues: ContentProvider (ref), v1 (ref) ]]
							ContentProvider:PreloadAsync({ v1 })
						end)
					end)
				end
				for v3, v4 in v12 do
					local v5 = typeof(v4) == "Instance" and v4.Texture or v4
					if v5 ~= "" and not t2[v5] then
						t2[v5] = true
						task.spawn(function() --[[ Line: 362 | Upvalues: ContentProvider (ref), v5 (copy) ]]
							pcall(function() --[[ Line: 363 | Upvalues: ContentProvider (ref), v5 (ref) ]]
								ContentProvider:PreloadAsync({ v5 })
							end)
						end)
					end
				end
				for v6, v7 in v2 do
					local v8 = false
					if v1 then
						for v9, v10 in CollectionService:GetTags(v6) do
							if v10:match("^_local_flipbook_") then
								v8 = true
								break
							end
						end
					end
					for v122, v13 in v7 do
						local v11
						local v16 = ("%*%*"):format(if v8 then "rbxtemp://" else "rbxassetid://", v13)
						local v17
						if typeof(v16) == "Instance" then
							v11 = v16.Texture
							if not v11 then
								v17 = v16
								v11 = v16
							end
						else
							v17 = v16
							v11 = v16
						end
						if v11 ~= "" and not t2[v11] then
							t2[v11] = true
							task.spawn(function() --[[ Line: 362 | Upvalues: ContentProvider (ref), v11 (copy) ]]
								pcall(function() --[[ Line: 363 | Upvalues: ContentProvider (ref), v11 (ref) ]]
									ContentProvider:PreloadAsync({ v11 })
								end)
							end)
						end
					end
				end
			end
			refresh()
			if v1 then
				local v12 = utility.reboundfn(1, refresh)
				table.insert(t, Start.DescendantAdded:Connect(v12))
				table.insert(t, Start.DescendantRemoving:Connect(v12))
			end
			t3[p1] = t
		else
			local t = {}
			local function refresh() --[[ refresh | Line: 426 | Upvalues: t2 (ref), ContentProvider (ref), p1 (copy) ]]
				local function check(p1) --[[ check | Line: 427 | Upvalues: t2 (ref), ContentProvider (ref) ]]
					if not p1:IsA("ParticleEmitter") then
						return
					end
					local Texture = p1.Texture
					if Texture == "" then
						return
					end
					if t2[Texture] then
						return
					end
					t2[Texture] = true
					task.spawn(function() --[[ Line: 362 | Upvalues: ContentProvider (ref), Texture (copy) ]]
						pcall(function() --[[ Line: 363 | Upvalues: ContentProvider (ref), Texture (ref) ]]
							ContentProvider:PreloadAsync({ Texture })
						end)
					end)
				end
				local v1 = p1
				if v1:IsA("ParticleEmitter") then
					local Texture = v1.Texture
					if Texture ~= "" and not t2[Texture] then
						t2[Texture] = true
						task.spawn(function() --[[ Line: 362 | Upvalues: ContentProvider (ref), Texture (copy) ]]
							pcall(function() --[[ Line: 363 | Upvalues: ContentProvider (ref), Texture (ref) ]]
								ContentProvider:PreloadAsync({ Texture })
							end)
						end)
					end
				end
				for v2, v3 in p1:GetDescendants() do
					if v3:IsA("ParticleEmitter") then
						local Texture = v3.Texture
						if Texture ~= "" and not t2[Texture] then
							t2[Texture] = true
							task.spawn(function() --[[ Line: 362 | Upvalues: ContentProvider (ref), Texture (copy) ]]
								pcall(function() --[[ Line: 363 | Upvalues: ContentProvider (ref), Texture (ref) ]]
									ContentProvider:PreloadAsync({ Texture })
								end)
							end)
						end
					end
				end
			end
			refresh()
			if v1 then
				local v2 = utility.reboundfn(1, refresh)
				table.insert(t, p1.DescendantAdded:Connect(v2))
				table.insert(t, p1.DescendantRemoving:Connect(v2))
			end
			t3[p1] = t
		end
	end
	for v3, v4 in CollectionService:GetTagged(utility.TEXTURE_LOAD_TAG) do
		loadTextures(v4)
	end
	CollectionService:GetInstanceAddedSignal(utility.TEXTURE_LOAD_TAG):Connect(loadTextures)
	CollectionService:GetInstanceRemovedSignal(utility.TEXTURE_LOAD_TAG):Connect(function(p1) --[[ Line: 460 | Upvalues: t3 (copy), utility (ref) ]]
		local v1 = t3[p1]
		if not v1 then
			return
		end
		utility.cleanupScope(v1)
		t3[p1] = nil
	end)
	local scope_2 = t.scope
	local function f5() --[[ Line: 469 | Upvalues: t3 (copy), utility (ref) ]]
		for v1, v2 in t3 do
			utility.cleanupScope(v2)
		end
	end
	table.insert(scope_2, f5)
	local t4 = {}
	local t5 = {}
	local v6 = 0
	local v7 = nil
	local function tickEntry(p1, p2, p3) --[[ tickEntry | Line: 482 | Upvalues: utility (ref), t (ref), mesh (ref), assembleMeshVFX (ref), bezier (ref) ]]
		if p2.speed == 0 then
			return
		end
		if p3 - p2.last <= 1 / p2.rate / p2.speed then
			return
		end
		p2.last = p3
		local t2 = {
			depth = 0
		}
		local function cleanup() --[[ cleanup | Line: 489 | Upvalues: utility (ref), t2 (copy) ]]
			utility.cleanupScope(t2)
		end
		table.insert(t.scope, cleanup)
		if p2.isMesh then
			local Start = p1:FindFirstChild("Start")
			if Start then
				for i = 1, p2.emitCount do
					utility.try(("failed to emit mesh \'%*\' with error: %%s"):format((p1:GetFullName())), mesh.emit, p1, assembleMeshVFX(Start, t2), t2, 1, true)
				end
			else
				p1:RemoveTag(utility.ENABLED_VFX_TAG)
			end
		elseif p2.isBezier then
			local Part = p1:FindFirstChildOfClass("Part")
			if Part then
				local v1 = Part:Clone()
				v1.Locked = true
				table.insert(t2, v1)
				utility.try(("failed to emit bezier \'%*\' with error: %%s"):format((p1:GetFullName())), bezier.emit, p1, v1, t2, true)
			end
		end
		local v2 = table.find(t.scope, cleanup)
		if not v2 then
			utility.cleanupScope(t2)
			return
		end
		table.remove(t.scope, v2)
		utility.cleanupScope(t2)
	end
	local function ensureMaster() --[[ ensureMaster | Line: 522 | Upvalues: v7 (ref), v6 (ref), RunService (ref), t5 (copy), tickEntry (copy) ]]
		if v7 then
			return
		end
		if v6 ~= 0 then
			v7 = RunService.Heartbeat:Connect(function() --[[ Line: 525 | Upvalues: t5 (ref), tickEntry (ref) ]]
				local v1 = os.clock()
				for k, v in pairs(t5) do
					if v.enabled then
						tickEntry(k, v, v1)
					end
				end
			end)
		end
	end
	local function maybeStopMaster() --[[ maybeStopMaster | Line: 535 | Upvalues: v7 (ref), v6 (ref) ]]
		if not v7 or v6 ~= 0 then
			return
		end
		v7:Disconnect()
		v7 = nil
	end
	local function removeEnabledEffect(p1) --[[ removeEnabledEffect | Line: 542 | Upvalues: t4 (copy), utility (ref), t5 (copy), v6 (ref), v7 (ref) ]]
		local v1 = t4[p1]
		if v1 then
			utility.cleanupScope(v1)
		end
		t4[p1] = nil
		local v2 = t5[p1]
		if v2 and v2.enabled then
			v6 = v6 - 1
		end
		t5[p1] = nil
		if not v7 or v6 ~= 0 then
			return
		end
		v7:Disconnect()
		v7 = nil
	end
	local function v8(p1) --[[ addEnabledEffect | Line: 554 | Upvalues: utility (ref), t4 (copy), v8 (copy), t5 (copy), v6 (ref), v7 (ref), RunService (ref), tickEntry (copy) ]]
		local v1 = utility.isMeshVFX(p1)
		local v2 = p1:HasTag(utility.BEZIER_TAG)
		if not (v1 or v2) then
			return
		end
		local t = {}
		t4[p1] = t
		local function f3() --[[ Line: 564 | Upvalues: p1 (copy), t4 (ref), v8 (ref), utility (ref), t5 (ref), v6 (ref), v7 (ref) ]]
			if p1:IsDescendantOf(workspace) or p1.Parent and p1.Parent:HasTag("AllowEmitting") then
				if not t4[p1] then
					v8(p1)
				end
			else
				local v1 = p1
				local v2 = t4[v1]
				if v2 then
					utility.cleanupScope(v2)
				end
				t4[v1] = nil
				local v3 = t5[v1]
				if v3 and v3.enabled then
					v6 = v6 - 1
				end
				t5[v1] = nil
				if not v7 or v6 ~= 0 then
					return
				end
				v7:Disconnect()
				v7 = nil
			end
		end
		table.insert(t, p1.AncestryChanged:Connect(f3))
		if not p1:IsDescendantOf(workspace) and (if p1.Parent then not p1.Parent:HasTag("AllowEmitting") else false) then
			return
		end
		local t2 = {
			last = 0,
			isMesh = v1,
			isBezier = v2,
			rate = utility.getAttribute(p1, "Rate", 5),
			speed = p1:GetAttribute("SpeedOverride") or 1,
			enabled = utility.getAttribute(p1, "Enabled", true),
			emitCount = utility.getAttribute(p1, "EmitCount", 1)
		}
		t5[p1] = t2
		local v5, v62, v72, v82, v9, v10, v11
		if not t2.enabled then
			v5 = p1:GetAttributeChangedSignal("Rate")
			v62 = function() --[[ Line: 594 | Upvalues: t2 (copy), utility (ref), p1 (copy) ]]
				t2.rate = utility.getAttribute(p1, "Rate", 5)
			end
			table.insert(t, v5:Connect(v62))
			v72 = p1:GetAttributeChangedSignal("SpeedOverride")
			table.insert(t, v72:Connect(function() --[[ Line: 597 | Upvalues: t2 (copy), p1 (copy) ]]
				t2.speed = p1:GetAttribute("SpeedOverride") or 1
			end))
			v82 = p1:GetAttributeChangedSignal("EmitCount")
			v9 = function() --[[ Line: 600 | Upvalues: t2 (copy), utility (ref), p1 (copy) ]]
				t2.emitCount = utility.getAttribute(p1, "EmitCount", 1)
			end
			table.insert(t, v82:Connect(v9))
			v10 = p1:GetAttributeChangedSignal("Enabled")
			v11 = function() --[[ Line: 603 | Upvalues: utility (ref), p1 (copy), t2 (copy), v6 (ref), v7 (ref), RunService (ref), t5 (ref), tickEntry (ref) ]]
				local v1 = utility.getAttribute(p1, "Enabled", true)
				if v1 and not t2.enabled then
					t2.enabled = true
					v6 = v6 + 1
					if v7 then
						return
					end
					if v6 ~= 0 then
						v7 = RunService.Heartbeat:Connect(function() --[[ Line: 525 | Upvalues: t5 (ref), tickEntry (ref) ]]
							local v1 = os.clock()
							for k2, v in pairs(t5) do
								if v.enabled then
									tickEntry(k2, v, v1)
								end
							end
						end)
					end
				else
					if v1 or not t2.enabled then
						return
					end
					t2.enabled = false
					v6 = v6 - 1
					if not v7 or v6 ~= 0 then
						return
					end
					v7:Disconnect()
					v7 = nil
				end
			end
			table.insert(t, v10:Connect(v11))
			return
		end
		v6 = v6 + 1
		if v7 or v6 == 0 then
			v5 = p1:GetAttributeChangedSignal("Rate")
			v62 = function() --[[ Line: 594 | Upvalues: t2 (copy), utility (ref), p1 (copy) ]]
				t2.rate = utility.getAttribute(p1, "Rate", 5)
			end
			table.insert(t, v5:Connect(v62))
			v72 = p1:GetAttributeChangedSignal("SpeedOverride")
			table.insert(t, v72:Connect(function() --[[ Line: 597 | Upvalues: t2 (copy), p1 (copy) ]]
				t2.speed = p1:GetAttribute("SpeedOverride") or 1
			end))
			v82 = p1:GetAttributeChangedSignal("EmitCount")
			v9 = function() --[[ Line: 600 | Upvalues: t2 (copy), utility (ref), p1 (copy) ]]
				t2.emitCount = utility.getAttribute(p1, "EmitCount", 1)
			end
			table.insert(t, v82:Connect(v9))
			v10 = p1:GetAttributeChangedSignal("Enabled")
			v11 = function() --[[ Line: 603 | Upvalues: utility (ref), p1 (copy), t2 (copy), v6 (ref), v7 (ref), RunService (ref), t5 (ref), tickEntry (ref) ]]
				local v1 = utility.getAttribute(p1, "Enabled", true)
				if v1 and not t2.enabled then
					t2.enabled = true
					v6 = v6 + 1
					if v7 then
						return
					end
					if v6 ~= 0 then
						v7 = RunService.Heartbeat:Connect(function() --[[ Line: 525 | Upvalues: t5 (ref), tickEntry (ref) ]]
							local v1 = os.clock()
							for k2, v in pairs(t5) do
								if v.enabled then
									tickEntry(k2, v, v1)
								end
							end
						end)
					end
				else
					if v1 or not t2.enabled then
						return
					end
					t2.enabled = false
					v6 = v6 - 1
					if not v7 or v6 ~= 0 then
						return
					end
					v7:Disconnect()
					v7 = nil
				end
			end
			table.insert(t, v10:Connect(v11))
			return
		end
		v7 = RunService.Heartbeat:Connect(function() --[[ Line: 525 | Upvalues: t5 (ref), tickEntry (ref) ]]
			local v1 = os.clock()
			for k, v in pairs(t5) do
				if v.enabled then
					tickEntry(k, v, v1)
				end
			end
		end)
		v5 = p1:GetAttributeChangedSignal("Rate")
		v62 = function() --[[ Line: 594 | Upvalues: t2 (copy), utility (ref), p1 (copy) ]]
			t2.rate = utility.getAttribute(p1, "Rate", 5)
		end
		table.insert(t, v5:Connect(v62))
		v72 = p1:GetAttributeChangedSignal("SpeedOverride")
		table.insert(t, v72:Connect(function() --[[ Line: 597 | Upvalues: t2 (copy), p1 (copy) ]]
			t2.speed = p1:GetAttribute("SpeedOverride") or 1
		end))
		v82 = p1:GetAttributeChangedSignal("EmitCount")
		v9 = function() --[[ Line: 600 | Upvalues: t2 (copy), utility (ref), p1 (copy) ]]
			t2.emitCount = utility.getAttribute(p1, "EmitCount", 1)
		end
		table.insert(t, v82:Connect(v9))
		v10 = p1:GetAttributeChangedSignal("Enabled")
		v11 = function() --[[ Line: 603 | Upvalues: utility (ref), p1 (copy), t2 (copy), v6 (ref), v7 (ref), RunService (ref), t5 (ref), tickEntry (ref) ]]
			local v1 = utility.getAttribute(p1, "Enabled", true)
			if v1 and not t2.enabled then
				t2.enabled = true
				v6 = v6 + 1
				if v7 then
					return
				end
				if v6 ~= 0 then
					v7 = RunService.Heartbeat:Connect(function() --[[ Line: 525 | Upvalues: t5 (ref), tickEntry (ref) ]]
						local v1 = os.clock()
						for k2, v in pairs(t5) do
							if v.enabled then
								tickEntry(k2, v, v1)
							end
						end
					end)
				end
			else
				if v1 or not t2.enabled then
					return
				end
				t2.enabled = false
				v6 = v6 - 1
				if not v7 or v6 ~= 0 then
					return
				end
				v7:Disconnect()
				v7 = nil
			end
		end
		table.insert(t, v10:Connect(v11))
	end
	for v9, v10 in CollectionService:GetTagged(utility.ENABLED_VFX_TAG) do
		v8(v10)
	end
	CollectionService:GetInstanceAddedSignal(utility.ENABLED_VFX_TAG):Connect(v8)
	CollectionService:GetInstanceRemovedSignal(utility.ENABLED_VFX_TAG):Connect(removeEnabledEffect)
	local scope_3 = t.scope
	local function f11() --[[ Line: 624 | Upvalues: v7 (ref), t4 (copy), utility (ref) ]]
		if v7 then
			v7:Disconnect()
			v7 = nil
		end
		for v1, v2 in t4 do
			utility.cleanupScope(v2)
		end
	end
	table.insert(scope_3, f11)
end
function t.deinit() --[[ deinit | Line: 631 | Upvalues: t (copy), RunService (copy), v1 (copy), utility (copy), bezier (copy), shockwave_ring (copy), shockwave_line (copy), shockwave_debris (copy) ]]
	if not t.setup then
		return
	end
	t.setup = false
	shared.vfx = nil
	if not RunService:IsServer() or v1 then
		utility.cleanupScope(t.scope)
		bezier.deinit()
		shockwave_ring.deinit()
		shockwave_line.deinit()
		shockwave_debris.deinit()
	end
end
function t.emit(p1, ...) --[[ emit | Line: 652 | Upvalues: t (copy), logger (copy), RunService (copy), Promise (copy), utility (copy), particle (copy), beam (copy), bezier (copy), mesh (copy), assembleMeshVFX (copy), spin (copy), tween_property (copy), shockwave_ring (copy), shockwave_debris (copy), shockwave_line (copy), screen (copy) ]]
	if not t.setup then
		logger.error("not initialized")
	end
	if not RunService:IsServer() and (shared.cull and shared.cull.work) then
		local v1 = nil
		local v2 = p1
		if typeof(p1) == "table" and type(p1._getReal) == "function" then
			v2 = p1._getReal()
		end
		if typeof(v2) == "Instance" then
			if v2:IsA("BasePart") then
				v1 = v2.Position
			elseif v2:IsA("Attachment") then
				v1 = v2.WorldPosition
			elseif v2:IsA("Model") then
				if v2.PrimaryPart then
					v1 = v2.PrimaryPart.Position
				else
					local _CullAnchor = v2:FindFirstChild("_CullAnchor")
					if _CullAnchor and _CullAnchor:IsA("BasePart") then
						v1 = _CullAnchor.Position
					else
						local v3 = v2:FindFirstChildWhichIsA("BasePart", true) or v2:FindFirstChildWhichIsA("Attachment", true)
						if v3 then
							v1 = v3:IsA("BasePart") and v3.Position or v3.WorldPosition
						end
					end
				end
			elseif v2:IsA("Folder") or v2:IsA("Configuration") then
				local _CullAnchor = v2:FindFirstChild("_CullAnchor")
				if _CullAnchor and _CullAnchor:IsA("BasePart") then
					v1 = _CullAnchor.Position
				else
					local v5 = v2:FindFirstChildWhichIsA("BasePart", true) or v2:FindFirstChildWhichIsA("Attachment", true)
					if v5 then
						v1 = v5:IsA("BasePart") and v5.Position or v5.WorldPosition
					end
				end
			end
		end
		if v1 then
			local CurrentCamera = workspace.CurrentCamera
			local v7 = CurrentCamera.CFrame.Position - v1
			math.sqrt((v7:Dot(v7)))
			local _, _2 = CurrentCamera:WorldToViewportPoint(v1)
			if typeof(v2) ~= "Instance" or not v2:GetFullName() then
				typeof(v2)
			end
			if not shared.cull.work(v1) then
				return {
					Finished = Promise.resolve()
				}
			end
		else
			local v9 = typeof(p1)
			if v9 ~= "Instance" and v9 == "table" then
				local _ = p1[1]
			end
		end
	end
	local t2 = {}
	local t3 = {}
	local v10 = 1
	local function emit(p1, p2) --[[ emit | Line: 719 | Upvalues: Promise (ref), utility (ref), t3 (copy), t2 (copy), particle (ref), v10 (ref), beam (ref), bezier (ref), mesh (ref), assembleMeshVFX (ref), spin (ref), tween_property (ref), shockwave_ring (ref), shockwave_debris (ref), shockwave_line (ref) ]]
		return Promise.new(function(p12) --[[ Line: 720 | Upvalues: p2 (copy), p1 (copy), utility (ref), t3 (ref), t2 (ref), particle (ref), v10 (ref), beam (ref), bezier (ref), Promise (ref), mesh (ref), assembleMeshVFX (ref), spin (ref), tween_property (ref), shockwave_ring (ref), shockwave_debris (ref), shockwave_line (ref) ]]
			(function() --[[ run | Line: 721 | Upvalues: p2 (ref), p1 (ref), utility (ref), t3 (ref), t2 (ref), particle (ref), v10 (ref), beam (ref), bezier (ref), Promise (ref), mesh (ref), assembleMeshVFX (ref), spin (ref), tween_property (ref), shockwave_ring (ref), shockwave_debris (ref), shockwave_line (ref) ]]
				local t = {
					depth = p2
				}
				if p1:IsA("ParticleEmitter") then
					if p1.Texture == "" then
						return
					end
					if p1:IsDescendantOf(workspace) then
						utility.try(("failed to emit particle \'%*\' with error: %%s"):format((p1:GetFullName())), particle.emit, p1, p1, t, v10)
						utility.cleanupScope(t)
					else
						local v1, v2 = utility.cloneParticleAncestry(p1, t3)
						if not v1 then
							return
						end
						table.insert(t, v2)
						local v3 = p1:Clone()
						v3.Archivable = false
						v3.Parent = v1
						game.Debris:AddItem(v3, 30)
						if not t2[v2] then
							v2.Parent = workspace.Thrown
						end
						if t2[v2] then
							local v4 = t2
							v4[v2] = v4[v2] + 1
						else
							t2[v2] = 1
						end
						utility.try(("failed to emit particle \'%*\' with error: %%s"):format((p1:GetFullName())), particle.emit, p1, v3, t, v10)
						local v5 = t2
						v5[v2] = v5[v2] - 1
						if t2[v2] <= 0 then
							utility.cleanupScope(t)
						end
					end
				elseif p1:IsA("Beam") then
					local v6 = p1:Clone()
					v6.Archivable = false
					v6.Parent = workspace.Thrown
					game.Debris:AddItem(v6, 30)
					table.insert(t, v6)
					utility.try(("failed to emit beam \'%*\' with error: %%s"):format((p1:GetFullName())), beam.emit, p1, v6, t, v10)
					utility.cleanupScope(t)
				elseif p1:IsA("Trail") then
					p1.Enabled = true
				elseif p1:HasTag(utility.BEZIER_TAG) then
					local Part = p1:FindFirstChildOfClass("Part")
					if not Part then
						return
					end
					if p1:GetAttribute("Enabled") then
						p1:SetAttribute("Enabled", false)
					end
					local v7 = Part:Clone()
					v7.Locked = true
					table.insert(t, v7)
					utility.try(("failed to emit bezier \'%*\' with error: %%s"):format((p1:GetFullName())), bezier.emit, p1, v7, t)
					utility.cleanupScope(t)
				elseif utility.isMeshVFX(p1) then
					local Start = p1:FindFirstChild("Start")
					if not Start then
						return
					end
					if p1:GetAttribute("Enabled") then
						p1:SetAttribute("Enabled", false)
					end
					local t4 = {}
					for i = 1, utility.getAttribute(p1, "EmitCount", 1) do
						local function f9(p12) --[[ Line: 832 | Upvalues: utility (ref), p1 (ref), mesh (ref), assembleMeshVFX (ref), Start (copy), t (copy), v10 (ref) ]]
							utility.try(("failed to emit mesh \'%*\' with error: %%s"):format((p1:GetFullName())), mesh.emit, p1, assembleMeshVFX(Start, t), t, v10)
							p12()
						end
						table.insert(t4, Promise.new(f9))
					end
					Promise.all(t4):await()
					utility.cleanupScope(t)
				elseif p1:IsA("Model") then
					if utility.lock(p1) then
						return
					end
					utility.try(("failed to emit spinning model \'%*\' with error: %%s"):format((p1:GetFullName())), spin.emit, p1, t)
					utility.cleanupScope(t)
					utility.unlock(p1)
				elseif p1:IsA("RayValue") then
					if not p1:HasTag(utility.SCREENSHAKE_TAG) then
						if not p1.Parent or utility.lock(p1) then
							return
						end
						utility.try(("failed to emit tween property \'%*\' with error: %%s"):format((p1:GetFullName())), tween_property.emit, p1.Parent, p1, t)
						utility.unlock(p1)
					end
					utility.cleanupScope(t)
				end
				if not p1:IsA("Part") then
					return
				end
				local v102 = utility.findFirstClassWithTag(p1, "Attachment", utility.SHOCKWAVE_TAG)
				if not v102 then
					return
				end
				local v11 = p1.Parent.Name
				if v11 == "Rings" then
					utility.try(("failed to emit shockwave ring \'%*\' with error: %%s"):format((p1:GetFullName())), shockwave_ring.emit, v102, p1, t)
					utility.cleanupScope(t)
					return
				end
				if v11 == "Debris" then
					utility.try(("failed to emit shockwave debris \'%*\' with error: %%s"):format((p1:GetFullName())), shockwave_debris.emit, v102, p1, t)
					utility.cleanupScope(t)
					return
				end
				if v11 ~= "Lines" then
					return
				end
				utility.try(("failed to emit shockwave line \'%*\' with error: %%s"):format((p1:GetFullName())), shockwave_line.emit, v102, p1, t)
				utility.cleanupScope(t)
			end)()
			p12()
		end)
	end
	local t4 = { ... }
	if typeof(p1) == "number" then
		v10 = p1
	else
		table.insert(t4, p1)
	end
	local t5 = {}
	local function v11(p1, p2, p3) --[[ emitAll | Line: 940 | Upvalues: utility (ref), screen (ref), v11 (copy), t5 (copy), Promise (ref), emit (copy) ]]
		for v1, v2 in p2 do
			if v2:IsA("BasePart") and (v2:GetAttribute("Enabled") and not utility.findFirstClassWithTag(v2, "Attachment", utility.SHOCKWAVE_TAG)) then
				if not utility.lock(v2) then
					local v3 = v2:FindFirstAncestorOfClass("Model")
					if not v3 or v3:GetAttribute("SpinRotation") == Vector3.new(0, 0, 0) and (v3:GetAttribute("Scale_Start") == 1 and v3:GetAttribute("Scale_End") == 1) then
						local v4 = coroutine.running()
						local t = {
							depth = p1
						}
						if utility.try(("failed to emit screen effect \'%*\' with error: %%s"):format((v2:GetFullName())), screen.emit, v2, t) then
							if #v2:GetDescendants() == 0 then
								utility.cleanupScope(t)
								return
							end
							local t2 = {}
							v11(p1 + 1, v2:GetChildren(), t2)
							local function f7() --[[ Line: 986 | Upvalues: utility (ref), v2 (copy), v4 (copy), t (copy) ]]
								utility.unlock(v2, v4)
								utility.cleanupScope(t)
							end
							table.insert(t5, Promise.all(t2):finally(f7))
						end
					end
				end
				continue
			end
			table.insert(p3, emit(v2, p1))
			if not (v2:HasTag(utility.BEZIER_TAG) or (utility.isMeshVFX(v2) or (v2:IsA("Beam") or (v2:IsA("Trail") or (v2:IsA("ParticleEmitter") or v2:IsA("BasePart") and utility.findFirstClassWithTag(v2, "Attachment", utility.SHOCKWAVE_TAG)))))) then
				v11(p1 + 1, v2:GetChildren(), p3)
			end
		end
	end
	v11(0, t4, t5)
	return {
		Finished = Promise.all(t5)
	}
end
return t