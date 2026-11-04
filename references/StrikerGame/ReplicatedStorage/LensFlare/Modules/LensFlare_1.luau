 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=89532403908041

-- ! Source from the asset above; the game may have edited it since.

--[=[
--[[
	LensFlare
	10/20/2025
	@gluGPU
	
	OOP module for Lens Flare Effects.
--]]

local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local lensFlareDir = ReplicatedStorage.LensFlare
local assets = lensFlareDir.Assets
local Configuration = require(lensFlareDir.Configuration)

local ERROR_HEADER = "LensFlare:"
local TAG_NAME = "IgnoreLensFlare"

local NUM_RAYS = Configuration.NUMBER_OF_RAYCASTS
local TEST_RADIUS = Configuration.RAYCAST_RADIUS
local TRANSPARENCY_THRESHOLD = Configuration.TRANSPARENCY_THRESHOLD
local BASE_RESOLUTION = Vector2.new(1920, 1080)

local PART_ATTRIBUTES = {
	LensFlareStrength = 1,
	LensFlareDistance = 0,
}

local ATTRIBUTES = {
	ColorBlend = 0,
	Position = vector.create(1, 1, 1),
	PositionMult = 1,
	Rotates = false,
	SizeFade = NumberSequence.new(1),
	SquashFade = NumberSequence.new(0),
	TransparencyFade = NumberSequence.new(0),
}

local ATTACHMENT_PROPERTIES = {
	"Position"
}

local PROPERTIES = {
	"Size",
	"Squash",
	"Transparency",
	"LocalTransparencyModifier",
	"Color",
	"Rotation",
	"ZOffset",
	"Lifetime",
}

local pi2 = math.pi * 2
local rayOffsets: {[number]: {[number]: number}} = table.create(NUM_RAYS)

for i = 1, NUM_RAYS do
	local angle = pi2 * ((i - 1) / NUM_RAYS)
	rayOffsets[i] = {math.cos(angle) * TEST_RADIUS, math.sin(angle) * TEST_RADIUS}
end

local p = Instance.new("ParticleEmitter")
local emit = p.Emit
local clear = p.Clear

export type LensFlare = {
	_id: string,

	Enabled: boolean,

	Camera: Camera,
	Part: BasePart | Attachment,

	Attachments: {Attachment},
	FlareEmitters: {ParticleEmitter},
	_attributeCache: {[Instance]: {[string]: any}},
	_attributeConns: {RBXScriptConnection},
	_propertyCache: {[Instance]: {[string]: any}},
	
	Alpha: number,
	_forceRecompute: boolean,

	RaycastParams: RaycastParams,

	_connections: {
		CollectionServiceConn: RBXScriptConnection
	},
}

local LensFlare = {}
LensFlare.__index = LensFlare



-- util functions

-- Returns value on given numbersequence at time
-- taken from https://create.roblox.com/docs/reference/engine/datatypes/NumberSequence
local function evalNumberSequence(sequence: NumberSequence, time: number)
	-- If time is 0 or 1, return the first or last value respectively
	if time == 0 then
		return sequence.Keypoints[1].Value
	elseif time == 1 then
		return sequence.Keypoints[#sequence.Keypoints].Value
	end

	-- Otherwise, step through each sequential pair of keypoints
	for i = 1, #sequence.Keypoints - 1 do
		local currKeypoint = sequence.Keypoints[i]
		local nextKeypoint = sequence.Keypoints[i + 1]
		if time >= currKeypoint.Time and time < nextKeypoint.Time then
			-- Calculate how far alpha lies between the points
			local alpha = (time - currKeypoint.Time) / (nextKeypoint.Time - currKeypoint.Time)
			-- Return the value between the points using alpha
			return currKeypoint.Value + (nextKeypoint.Value - currKeypoint.Value) * alpha
		end
	end
end



-- // Script API

-- Create a new <code>LensFlare</code> object
function LensFlare.new(camera: Camera, flareStyle: string, part: BasePart | Attachment): LensFlare
	local flareFolder = assets:FindFirstChild(flareStyle)
	assert(flareFolder, `{ERROR_HEADER} No lens flare folder called {flareStyle} under LensFlare.Assets`)

	local assets = flareFolder:GetChildren()

	local self: LensFlare = setmetatable({}, LensFlare)

	local id = HttpService:GenerateGUID(false)

	self._id = id
	self.Enabled = true

	self.Camera = camera
	self.Part = part

	self.Attachments = table.create(#assets)
	self.FlareEmitters = table.create(#assets)
	
	self.Alpha = 0
	self._forceRecompute = false

	local idx = 1
	local cache: {[Instance]: {[string]: any}} = {}
	local conns: {RBXScriptConnection} = {}
	local propsCache: {[Instance]: {[string]: any}} = {}
	
	local partCache: {[string]: any} = {}
	for attributeName: string, defaultValue: any in PART_ATTRIBUTES do
		local attribute = part:GetAttribute(attributeName) or defaultValue
		partCache[attributeName] = attribute
		
		local connection = part:GetAttributeChangedSignal(attributeName):Connect(function()
			local new = part:GetAttribute(attributeName) or defaultValue
			partCache[attributeName] = new
			self._forceRecompute = true
		end)

		table.insert(conns, connection)
	end
	
	cache[part] = partCache
	
	for _, flareAsset: ParticleEmitter in assets do
		if flareAsset:IsA("ParticleEmitter") then
			local attachment = Instance.new("Attachment")
			attachment.Name = `LensFlare_{flareStyle}_{flareAsset.Name}`
			attachment.Parent = camera

			self.Attachments[idx] = attachment
			
			propsCache[attachment] = {attachment.Position}
			
			

			local newEmitter = Instance.fromExisting(flareAsset)
			newEmitter.ZOffset = 0
			newEmitter.Enabled = false
			newEmitter.Parent = attachment

			self.FlareEmitters[idx] = newEmitter
			
			
			-- caching stuff
			local eCache: {[string]: any} = {}
			local color = part:IsA("BasePart") and part.Color or Color3.new(1, 1, 1)
			local hue, saturation = color:ToHSV()
			
			for attributeName: string, defaultValue: any in ATTRIBUTES do
				local attribute = newEmitter:GetAttribute(attributeName) or defaultValue
				eCache[attributeName] = attribute
				
				local connection = newEmitter:GetAttributeChangedSignal(attributeName):Connect(function()
					local new = newEmitter:GetAttribute(attributeName) or defaultValue
					eCache[attributeName] = new
					self._forceRecompute = true
					
					if attributeName == "ColorBlend" then
						eCache._color = ColorSequence.new(
							Color3.fromHSV(hue, new, 1)
						)
					end
				end)
				
				table.insert(conns, connection)
			end
			
			-- Calculate color blend
			if eCache.ColorBlend and eCache.ColorBlend > 0 then
				eCache._color = ColorSequence.new(
					Color3.fromHSV(hue, saturation * eCache.ColorBlend, 1)
				)
				
				if part:IsA("BasePart") then
					table.insert(conns, part:GetPropertyChangedSignal("Color"):Connect(function()
						local color = part.Color
						local hue, saturation = color:ToHSV()
						
						eCache._color = ColorSequence.new(
							Color3.fromHSV(hue, saturation * eCache.ColorBlend, 1)
						)
						self._forceRecompute = true
					end))
				end
			end
			
			
			-- cache previous properties.
			local pCache = {}
			for _, propertyName in PROPERTIES do
				local value = newEmitter[propertyName]
				pCache[propertyName] = value
			end
			
			cache[newEmitter] = eCache
			propsCache[newEmitter] = pCache

			idx += 1
		end
	end
	
	self._attributeCache = cache
	self._attributeConns = conns
	self._propertyCache = propsCache

	-- ray params
	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = {part, CollectionService:GetTagged(TAG_NAME)}
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.IgnoreWater = true

	self.RaycastParams = rayParams

	-- event connections
	self._connections = {
		CollectionServiceConn = CollectionService:GetInstanceAddedSignal(TAG_NAME):Connect(function(object: Instance)
			self.RaycastParams:AddToFilter(object)
		end),
	}
	
	RunService:BindToRenderStep(`LensFlare_{id}`, Enum.RenderPriority.Camera.Value + 10, function(delta: number)
		if not self.Enabled then return end
		self:Update(delta)
	end)

	return self
end

-- Destroy the <code>LensFlare</code> object
function LensFlare.Destroy(self: LensFlare)
	for _, connection: RBXScriptConnection in self._connections do
		connection:Disconnect()
		connection = nil
	end
	
	for _, connection: RBXScriptConnection in self._attributeConns do
		connection:Disconnect()
		connection = nil
	end

	RunService:UnbindFromRenderStep(`LensFlare_{self._id}`)

	for _, emitter in self.FlareEmitters do
		emitter:Destroy()
	end

	for _, attachment in self.Attachments do
		attachment:Destroy()
	end

	table.clear(self)
	setmetatable(self, nil)
end

-- Update the <code>LensFlare</code> emitters
function LensFlare.Update(self: LensFlare, delta: number)
	debug.profilebegin(`LensFlareUpdate_{self._id}`)
	
	local camera = self.Camera
	local part = self.Part
	local partPos = part:IsA("Attachment") and part.WorldPosition or part.Position

	local cameraPos = camera.CFrame.Position

	-- calculate camera values
	local dir = (partPos - cameraPos)
	local dist = vector.magnitude(dir)
	
	local cache = self._attributeCache
	local propsCache = self._propertyCache
	
	local partsCache = cache[part]
	local distSetting: number = partsCache.LensFlareDistance
	local strengthSetting: number = partsCache.LensFlareStrength
	
	if strengthSetting and strengthSetting <= 0 then
		return
	end

	if distSetting and distSetting > 0 and dist > distSetting then
		return
	end
	
	local alpha = math.clamp(vector.angle(camera.CFrame.LookVector, dir) / math.rad(camera.DiagonalFieldOfView) * 2, 0, 1)
	if distSetting and distSetting > 0 then
		alpha += (dist / distSetting)
	end
	
	if alpha >= 1 then
		return
	end
	
	local screenPos = camera:WorldToViewportPoint(partPos)
	local pos = camera:ViewportPointToRay(screenPos.X, screenPos.Y, 1).Origin

	local offsetCFrame = camera.CFrame:ToObjectSpace(CFrame.new(pos))
	local offset = offsetCFrame.Position

	-- Testing for visiblity.
	local rayParams = self.RaycastParams
	local numRaysHit = 0

	local screenSize = camera.ViewportSize
	local normalizedPixels = (screenSize / BASE_RESOLUTION).Magnitude
	
	debug.profilebegin(`LensFlareUpdate_{self._id}_RaycastStep`)
	for i, offsetPoints in rayOffsets do
		local x, y = offsetPoints[1] * normalizedPixels, offsetPoints[2] * normalizedPixels
		
		local ray = camera:ViewportPointToRay(screenPos.X + x, screenPos.Y + y, 1)
		local raycast = workspace:Raycast(ray.Origin, ray.Direction * dist, rayParams)
		
		if raycast then
			local rayInstance = raycast.Instance
			if rayInstance:IsA("BasePart") and (rayInstance.Transparency > TRANSPARENCY_THRESHOLD or rayInstance.LocalTransparencyModifier > TRANSPARENCY_THRESHOLD) then
				rayParams:AddToFilter(rayInstance)
			else
				numRaysHit += 1
			end
		end
	end
	debug.profileend()

	local hitAlpha = numRaysHit / NUM_RAYS

	-- reposition attachments
	local attachments = self.Attachments
	local flareEmitters = self.FlareEmitters
	
	
	local newAlpha = (strengthSetting) * (1 - alpha) * (1 - hitAlpha)
	local lastAlpha = self.Alpha -- This hasn't been updated yet, we can use it as the previous alpha.
	
	if hitAlpha < 1 and alpha < 1 then
		-- If alpha is same as before, don't recompute, just re-emit
		if newAlpha == lastAlpha and not self._forceRecompute then
			for _, emitter in flareEmitters do
				clear(emitter)
				
				local ePropsCache = propsCache[emitter]

				local eLifetime: number = ePropsCache.Lifetime
				local lifetime = NumberRange.new(delta * 3)
				if eLifetime ~= lifetime then
					emitter.Lifetime = lifetime
					ePropsCache.Lifetime = lifetime
				end
				
				emit(emitter, 1)
			end
			
			return
		end
		
		for i = 1, #flareEmitters do
			local attachment = attachments[i]
			local emitter = flareEmitters[i]

			clear(emitter)
			
			local eCache = cache[emitter]
			local ePropsCache = propsCache[emitter]
			
			local eColorBlend: number = eCache.ColorBlend
			local eColor: ColorSequence = eCache._color
			local ePos: vector = eCache.Position
			local ePosMult: number = eCache.PositionMult
			local eRotates: boolean = eCache.Rotates
			local eSizeFade: NumberSequence = eCache.SizeFade
			local eSquashFade: NumberSequence = eCache.SquashFade
			local eTransFade: NumberSequence = eCache.TransparencyFade

			local x, y = offset.X * ePos.x * ePosMult, offset.Y * ePos.y * ePosMult
			local newPos = vector.create(x, y, offset.Z)
			attachment.Position = vector.create(x, y, offset.Z)

			-- set emitter
			local size = NumberSequence.new(evalNumberSequence(eSizeFade, alpha))
			local squash = NumberSequence.new(evalNumberSequence(eSquashFade, alpha))
			local transparency = NumberSequence.new(math.lerp(evalNumberSequence(eTransFade, alpha), 1, hitAlpha))
			local transModifier = 1 - strengthSetting
			
			if size ~= ePropsCache.Size then
				emitter.Size = size
				ePropsCache.Size = size
			end

			if squash ~= ePropsCache.Squash then
				emitter.Squash = squash
				ePropsCache.Squash = squash
			end

			if transparency ~= ePropsCache.Transparency then
				emitter.Transparency = transparency
				ePropsCache.Transparency = transparency
			end

			if transModifier ~= ePropsCache.LocalTransparencyModifier then
				emitter.LocalTransparencyModifier = 1 - strengthSetting
				ePropsCache.LocalTransparencyModifier = transModifier
			end

			if eColor and eColor ~= ePropsCache.Color then
				emitter.Color = eColor
				ePropsCache.Color = eColor
			end

			if eRotates then
				local rotation = NumberRange.new(math.deg(math.atan2(offset.Y, offset.X)))
				if rotation ~= ePropsCache.Rotation then
					emitter.Rotation = rotation
					ePropsCache.Rotation = rotation
				end
			end

			local zOffset = math.min(-attachment.Position.Z * 0.8, 0)
			if zOffset ~= ePropsCache.ZOffset then
				emitter.ZOffset = zOffset
				ePropsCache.ZOffset = zOffset
			end
			
			local eLifetime: number = ePropsCache.Lifetime
			local lifetime = NumberRange.new(delta * 3)
			if eLifetime ~= lifetime then
				emitter.Lifetime = lifetime
				ePropsCache.Lifetime = lifetime
			end

			emit(emitter, 1)
		end
	end
	
	self.Alpha = newAlpha
	
	debug.profileend()
end

return LensFlare
]=]

 

local CollectionService = game:GetService("CollectionService");
local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LensFlare = ReplicatedStorage.LensFlare;
local Assets = LensFlare.Assets;
local Configuration = require(LensFlare.Configuration);
local NUMBER_OF_RAYCASTS = Configuration.NUMBER_OF_RAYCASTS;
local RAYCAST_RADIUS = Configuration.RAYCAST_RADIUS;
local TRANSPARENCY_THRESHOLD = Configuration.TRANSPARENCY_THRESHOLD;
local Vector2_new_ret = Vector2.new(1920, 1080);
local u1 = {
    ColorBlend = 0,
    Position = Vector3.new(1, 1, 1),
    PositionMult = 1,
    Rotates = false,
    SizeFade = NumberSequence.new(1),
    SquashFade = NumberSequence.new(0),
    TransparencyFade = NumberSequence.new(0)
};
local table_create_ret = table.create(NUMBER_OF_RAYCASTS);
local u2 = {
    LensFlareStrength = 1,
    LensFlareDistance = 0
};
local u3 = { "Size", "Squash", "Transparency", "LocalTransparencyModifier", "Color", "Rotation", "ZOffset", "Lifetime" };

for i = 1, NUMBER_OF_RAYCASTS do
    local v4 = 6.283185307179586 * ((i - 1) / NUMBER_OF_RAYCASTS);
    table_create_ret[i] = { math.cos(v4) * RAYCAST_RADIUS, math.sin(v4) * RAYCAST_RADIUS };
    local _ = i;
end;

local ParticleEmitter = Instance.new("ParticleEmitter");
local Emit = ParticleEmitter.Emit;
local Clear = ParticleEmitter.Clear;
local u5 = {};
u5.__index = u5;

local function evalNumberSequence(p6: userdata, p7: number) -- Line: 101
    if p7 == 0 then
        return p6.Keypoints[1].Value;
    end;

    if p7 == 1 then
        return p6.Keypoints[#p6.Keypoints].Value;
    end;

    for i = 1, #p6.Keypoints - 1 do
        local v8 = p6.Keypoints[i];
        local v9 = p6.Keypoints[i + 1];

        if v8.Time <= p7 and p7 < v9.Time then
            return v8.Value + (v9.Value - v8.Value) * ((p7 - v8.Time) / (v9.Time - v8.Time));
        end;

        local _ = i;
    end;
end;

function u5.new(p10: userdata, p11: string, u12: userdata) -- Line: 127
    -- upvalues: Assets (copy), u5 (copy), HttpService (copy), u2 (copy), u1 (copy), u3 (copy), CollectionService (copy), RunService (copy)
    local v13 = Assets:FindFirstChild(p11);
    local v14 = `LensFlare: No lens flare folder called {p11} under LensFlare.Assets`;
    assert(v13, v14);
    local Children = v13:GetChildren();
    local u15 = setmetatable({}, u5);
    local v16 = HttpService:GenerateGUID(false);
    u15._id = v16;
    u15.Enabled = true;
    u15.Camera = p10;
    u15.Part = u12;
    u15.Attachments = table.create(#Children);
    u15.FlareEmitters = table.create(#Children);
    u15.Alpha = 0;
    u15._forceRecompute = false;
    local u17 = {};
    local v18 = {};
    local v19 = {};
    local v20 = 1;
    local v21 = {};

    for i, v in u2 do
        u17[i] = u12:GetAttribute(i) or v;
        local v22 = u12:GetAttributeChangedSignal(i):Connect(function() -- Line: 159
            -- upvalues: u12 (copy), i (copy), v (copy), u17 (copy), u15 (copy)
            u17[i] = u12:GetAttribute(i) or v;
            u15._forceRecompute = true;
        end);
        table.insert(v18, v22);
    end;

    v19[u12] = u17;

    for _, v in Children do
        if v:IsA("ParticleEmitter") then
            local Attachment = Instance.new("Attachment");
            Attachment.Name = `LensFlare_{p11}_{v.Name}`;
            Attachment.Parent = p10;
            u15.Attachments[v20] = Attachment;
            v21[Attachment] = { Attachment.Position };
            local Instance_fromExisting_ret = Instance.fromExisting(v);
            Instance_fromExisting_ret.ZOffset = 0;
            Instance_fromExisting_ret.Enabled = false;
            Instance_fromExisting_ret.Parent = Attachment;
            u15.FlareEmitters[v20] = Instance_fromExisting_ret;
            local u23, v24 = (u12:IsA("BasePart") and u12.Color or Color3.new(1, 1, 1)):ToHSV();
            local u25 = {};

            for i, v2 in u1 do
                u25[i] = Instance_fromExisting_ret:GetAttribute(i) or v2;
                local v27 = Instance_fromExisting_ret:GetAttributeChangedSignal(i):Connect(function() -- Line: 199
                    -- upvalues: Instance_fromExisting_ret (copy), i (copy), v2 (copy), u25 (copy), u15 (copy), u23 (copy)
                    local v26 = Instance_fromExisting_ret:GetAttribute(i) or v2;
                    u25[i] = v26;
                    u15._forceRecompute = true;

                    if i == "ColorBlend" then
                        u25._color = ColorSequence.new(Color3.fromHSV(u23, v26, 1));
                    end;
                end);
                table.insert(v18, v27);
            end;

            if u25.ColorBlend and u25.ColorBlend > 0 then
                u25._color = ColorSequence.new(Color3.fromHSV(u23, v24 * u25.ColorBlend, 1));

                if u12:IsA("BasePart") then
                    local PropertyChangedSignal = u12:GetPropertyChangedSignal("Color");
                    table.insert(v18, PropertyChangedSignal:Connect(function() -- Line: 221
                        -- upvalues: u12 (copy), u25 (copy), u15 (copy)
                        local v28, v29 = u12.Color:ToHSV();
                        u25._color = ColorSequence.new(Color3.fromHSV(v28, v29 * u25.ColorBlend, 1));
                        u15._forceRecompute = true;
                    end));
                end;
            end;

            local v30 = {};

            for _, v2 in u3 do
                v30[v2] = Instance_fromExisting_ret[v2];
            end;

            v19[Instance_fromExisting_ret] = u25;
            v21[Instance_fromExisting_ret] = v30;
            v20 = v20 + 1;
        end;
    end;

    u15._attributeCache = v19;
    u15._attributeConns = v18;
    u15._propertyCache = v21;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterDescendantsInstances = { u12, CollectionService:GetTagged("IgnoreLensFlare") };
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.IgnoreWater = true;
    u15.RaycastParams = RaycastParams_new_ret;
    u15._connections = {
        CollectionServiceConn = CollectionService:GetInstanceAddedSignal("IgnoreLensFlare"):Connect(function(p31: userdata) -- Line: 262
            -- upvalues: u15 (copy)
            u15.RaycastParams:AddToFilter(p31);
        end)
    };
    RunService:BindToRenderStep(`LensFlare_{v16}`, Enum.RenderPriority.Camera.Value + 10, function(p32: number) -- Line: 267
        -- upvalues: u15 (copy)
        if not u15.Enabled then
            return;
        end;

        u15:Update(p32);
    end);

    return u15;
end;

function u5.Destroy(p33: table) -- Line: 276
    -- upvalues: RunService (copy)
    for _, v in p33._connections do
        v:Disconnect();
    end;

    for _, v in p33._attributeConns do
        v:Disconnect();
    end;

    RunService:UnbindFromRenderStep((`LensFlare_{p33._id}`));

    for _, v in p33.FlareEmitters do
        v:Destroy();
    end;

    for _, v in p33.Attachments do
        v:Destroy();
    end;

    table.clear(p33);
    setmetatable(p33, nil);
end;

function u5.Update(p34: table, p35: number) -- Line: 302
    -- upvalues: Vector2_new_ret (copy), table_create_ret (copy), TRANSPARENCY_THRESHOLD (copy), NUMBER_OF_RAYCASTS (copy), Clear (copy), Emit (copy), evalNumberSequence (copy)
    debug.profilebegin((`LensFlareUpdate_{p34._id}`));
    local Camera = p34.Camera;
    local Part = p34.Part;
    local v36 = Part:IsA("Attachment") and Part.WorldPosition or Part.Position;
    local v37 = v36 - Camera.CFrame.Position;
    local vector_magnitude_ret = vector.magnitude(v37);
    local _attributeCache = p34._attributeCache;
    local _propertyCache = p34._propertyCache;
    local v38 = _attributeCache[Part];
    local LensFlareDistance = v38.LensFlareDistance;
    local LensFlareStrength = v38.LensFlareStrength;

    if LensFlareStrength and LensFlareStrength <= 0 then
        return;
    end;

    if LensFlareDistance and (LensFlareDistance > 0 and LensFlareDistance < vector_magnitude_ret) then
        return;
    end;

    local v39 = vector.angle(Camera.CFrame.LookVector, v37) / math.rad(Camera.DiagonalFieldOfView) * 2;
    local math_clamp_ret = math.clamp(v39, 0, 1);

    if LensFlareDistance and LensFlareDistance > 0 then
        math_clamp_ret = math_clamp_ret + vector_magnitude_ret / LensFlareDistance;
    end;

    if math_clamp_ret >= 1 then
        return;
    end;

    local v40 = Camera:WorldToViewportPoint(v36);
    local Origin = Camera:ViewportPointToRay(v40.X, v40.Y, 1).Origin;
    local Position = Camera.CFrame:ToObjectSpace(CFrame.new(Origin)).Position;
    local RaycastParams2 = p34.RaycastParams;
    local Magnitude = (Camera.ViewportSize / Vector2_new_ret).Magnitude;
    debug.profilebegin((`LensFlareUpdate_{p34._id}_RaycastStep`));
    local v41 = 0;

    for _, v in table_create_ret do
        local v42 = Camera:ViewportPointToRay(v40.X + v[1] * Magnitude, v40.Y + v[2] * Magnitude, 1);
        local v43 = workspace:Raycast(v42.Origin, v42.Direction * vector_magnitude_ret, RaycastParams2);

        if v43 then
            local Instance2 = v43.Instance;

            if Instance2:IsA("BasePart") and (TRANSPARENCY_THRESHOLD < Instance2.Transparency or TRANSPARENCY_THRESHOLD < Instance2.LocalTransparencyModifier) then
                RaycastParams2:AddToFilter(Instance2);
            else
                v41 = v41 + 1;
            end;
        end;
    end;

    debug.profileend();
    local v44 = v41 / NUMBER_OF_RAYCASTS;
    local Attachments = p34.Attachments;
    local FlareEmitters = p34.FlareEmitters;
    local v45 = LensFlareStrength * (1 - math_clamp_ret) * (1 - v44);
    local Alpha = p34.Alpha;

    if v44 < 1 and math_clamp_ret < 1 then
        if v45 == Alpha and not p34._forceRecompute then
            for _, v in FlareEmitters do
                Clear(v);
                local v46 = _propertyCache[v];
                local Lifetime = v46.Lifetime;
                local NumberRange_new_ret = NumberRange.new(p35 * 3);

                if Lifetime ~= NumberRange_new_ret then
                    v.Lifetime = NumberRange_new_ret;
                    v46.Lifetime = NumberRange_new_ret;
                end;

                Emit(v, 1);
            end;

            return;
        end;

        for i = 1, #FlareEmitters do
            local v47 = Attachments[i];
            local v48 = FlareEmitters[i];
            Clear(v48);
            local v49 = _attributeCache[v48];
            local v50 = _propertyCache[v48];
            local _ = v49.ColorBlend;
            local _color = v49._color;
            local Position2 = v49.Position;
            local PositionMult = v49.PositionMult;
            local Rotates = v49.Rotates;
            local SizeFade = v49.SizeFade;
            local SquashFade = v49.SquashFade;
            local TransparencyFade = v49.TransparencyFade;
            local v51 = Position.X * Position2.x * PositionMult;
            local v52 = Position.Y * Position2.y * PositionMult;
            vector.create(v51, v52, Position.Z);
            v47.Position = vector.create(v51, v52, Position.Z);
            local NumberSequence_new_ret = NumberSequence.new(evalNumberSequence(SizeFade, math_clamp_ret));
            local NumberSequence_new_ret2 = NumberSequence.new(evalNumberSequence(SquashFade, math_clamp_ret));
            local NumberSequence_new = NumberSequence.new;
            local v53 = evalNumberSequence(TransparencyFade, math_clamp_ret);
            local v54 = NumberSequence_new((math.lerp(v53, 1, v44)));
            local v55 = 1 - LensFlareStrength;

            if NumberSequence_new_ret ~= v50.Size then
                v48.Size = NumberSequence_new_ret;
                v50.Size = NumberSequence_new_ret;
            end;

            if NumberSequence_new_ret2 ~= v50.Squash then
                v48.Squash = NumberSequence_new_ret2;
                v50.Squash = NumberSequence_new_ret2;
            end;

            if v54 ~= v50.Transparency then
                v48.Transparency = v54;
                v50.Transparency = v54;
            end;

            if v55 ~= v50.LocalTransparencyModifier then
                v48.LocalTransparencyModifier = 1 - LensFlareStrength;
                v50.LocalTransparencyModifier = v55;
            end;

            if _color and _color ~= v50.Color then
                v48.Color = _color;
                v50.Color = _color;
            end;

            if Rotates then
                local NumberRange_new = NumberRange.new;
                local math_atan2_ret = math.atan2(Position.Y, Position.X);
                local v56 = NumberRange_new((math.deg(math_atan2_ret)));

                if v56 ~= v50.Rotation then
                    v48.Rotation = v56;
                    v50.Rotation = v56;
                end;
            end;

            local math_min_ret = math.min(-v47.Position.Z * 0.8, 0);

            if math_min_ret ~= v50.ZOffset then
                v48.ZOffset = math_min_ret;
                v50.ZOffset = math_min_ret;
            end;

            local Lifetime = v50.Lifetime;
            local NumberRange_new_ret = NumberRange.new(p35 * 3);

            if Lifetime ~= NumberRange_new_ret then
                v48.Lifetime = NumberRange_new_ret;
                v50.Lifetime = NumberRange_new_ret;
            end;

            Emit(v48, 1);
            local _ = i;
        end;
    end;

    p34.Alpha = v45;
    debug.profileend();
end;

return u5;