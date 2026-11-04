 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=1461025953

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- Camera Shaker
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	CameraShaker.CameraShakeInstance
	
	cameraShaker = CameraShaker.new(renderPriority, callbackFunction)
	
	CameraShaker:Start()
	CameraShaker:Stop()
	CameraShaker:StopSustained([fadeOutTime])
	CameraShaker:Shake(shakeInstance)
	CameraShaker:ShakeSustain(shakeInstance)
	CameraShaker:ShakeOnce(magnitude, roughness [, fadeInTime, fadeOutTime, posInfluence, rotInfluence])
	CameraShaker:StartShake(magnitude, roughness [, fadeInTime, posInfluence, rotInfluence])
	
	
	
	EXAMPLE:
	
		local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
			camera.CFrame = playerCFrame * shakeCFrame
		end)
		
		camShake:Start()
		
		-- Explosion shake:
		camShake:Shake(CameraShaker.Presets.Explosion)
		
		wait(1)
		
		-- Custom shake:
		camShake:ShakeOnce(3, 1, 0.2, 1.5)

		-- Sustained shake:
		camShake:ShakeSustain(CameraShaker.Presets.Earthquake)

		-- Stop all sustained shakes:
		camShake:StopSustained(1) -- Argument is the fadeout time (defaults to the same as fadein time if not supplied)

		-- Stop only one sustained shake:
		shakeInstance = camShake:ShakeSustain(CameraShaker.Presets.Earthquake)
		wait(2)
		shakeInstance:StartFadeOut(1) -- Argument is the fadeout time
	
	
	NOTE:
	
		This was based entirely on the EZ Camera Shake asset for Unity3D. I was given written
		permission by the developer, Road Turtle Games, to port this to Roblox.
		
		Original asset link: https://assetstore.unity.com/packages/tools/camera/ez-camera-shake-33148

		GitHub repository: https://github.com/Sleitnick/RbxCameraShaker
	
	
--]]



local CameraShaker = {}
CameraShaker.__index = CameraShaker

local profileBegin = debug.profilebegin
local profileEnd = debug.profileend
local profileTag = "CameraShakerUpdate"

local V3 = Vector3.new
local CF = CFrame.new
local ANG = CFrame.Angles
local RAD = math.rad
local v3Zero = V3()

local CameraShakeInstance = require(script.CameraShakeInstance)
local CameraShakeState = CameraShakeInstance.CameraShakeState

local defaultPosInfluence = V3(0.15, 0.15, 0.15)
local defaultRotInfluence = V3(1, 1, 1)


CameraShaker.CameraShakeInstance = CameraShakeInstance
CameraShaker.Presets = require(script.CameraShakePresets)


function CameraShaker.new(renderPriority, callback)
	
	assert(type(renderPriority) == "number", "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
	assert(type(callback) == "function", "Callback must be a function")
	
	local self = setmetatable({
		_running = false;
		_renderName = "CameraShaker";
		_renderPriority = renderPriority;
		_posAddShake = v3Zero;
		_rotAddShake = v3Zero;
		_camShakeInstances = {};
		_removeInstances = {};
		_callback = callback;
	}, CameraShaker)
	
	return self
	
end


function CameraShaker:Start()
	if (self._running) then return end
	self._running = true
	local callback = self._callback
	game:GetService("RunService"):BindToRenderStep(self._renderName, self._renderPriority, function(dt)
		profileBegin(profileTag)
		local cf = self:Update(dt)
		profileEnd()
		callback(cf)
	end)
end


function CameraShaker:Stop()
	if (not self._running) then return end
	game:GetService("RunService"):UnbindFromRenderStep(self._renderName)
	self._running = false
end


function CameraShaker:StopSustained(duration)
	for _,c in pairs(self._camShakeInstances) do
		if (c.fadeOutDuration == 0) then
			c:StartFadeOut(duration or c.fadeInDuration)
		end
	end
end


function CameraShaker:Update(dt)
	
	local posAddShake = v3Zero
	local rotAddShake = v3Zero
	
	local instances = self._camShakeInstances
	
	-- Update all instances:
	for i = 1,#instances do
		
		local c = instances[i]
		local state = c:GetState()
		
		if (state == CameraShakeState.Inactive and c.DeleteOnInactive) then
			self._removeInstances[#self._removeInstances + 1] = i
		elseif (state ~= CameraShakeState.Inactive) then
			local shake = c:UpdateShake(dt)
			posAddShake = posAddShake + (shake * c.PositionInfluence)
			rotAddShake = rotAddShake + (shake * c.RotationInfluence)
		end
		
	end
	
	-- Remove dead instances:
	for i = #self._removeInstances,1,-1 do
		local instIndex = self._removeInstances[i]
		table.remove(instances, instIndex)
		self._removeInstances[i] = nil
	end
	
	return CF(posAddShake) *
			ANG(0, RAD(rotAddShake.Y), 0) *
			ANG(RAD(rotAddShake.X), 0, RAD(rotAddShake.Z))
	
end


function CameraShaker:Shake(shakeInstance)
	assert(type(shakeInstance) == "table" and shakeInstance._camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	return shakeInstance
end


function CameraShaker:ShakeSustain(shakeInstance)
	assert(type(shakeInstance) == "table" and shakeInstance._camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	shakeInstance:StartFadeIn(shakeInstance.fadeInDuration)
	return shakeInstance
end


function CameraShaker:ShakeOnce(magnitude, roughness, fadeInTime, fadeOutTime, posInfluence, rotInfluence)
	local shakeInstance = CameraShakeInstance.new(magnitude, roughness, fadeInTime, fadeOutTime)
	shakeInstance.PositionInfluence = (typeof(posInfluence) == "Vector3" and posInfluence or defaultPosInfluence)
	shakeInstance.RotationInfluence = (typeof(rotInfluence) == "Vector3" and rotInfluence or defaultRotInfluence)
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	return shakeInstance
end


function CameraShaker:StartShake(magnitude, roughness, fadeInTime, posInfluence, rotInfluence)
	local shakeInstance = CameraShakeInstance.new(magnitude, roughness, fadeInTime)
	shakeInstance.PositionInfluence = (typeof(posInfluence) == "Vector3" and posInfluence or defaultPosInfluence)
	shakeInstance.RotationInfluence = (typeof(rotInfluence) == "Vector3" and rotInfluence or defaultRotInfluence)
	shakeInstance:StartFadeIn(fadeInTime)
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	return shakeInstance
end


return CameraShaker
]=]

 

local u1 = {};
u1.__index = u1;
local debug_profilebegin = debug.profilebegin;
local debug_profileend = debug.profileend;
local CFrame_new = CFrame.new;
local CFrame_Angles = CFrame.Angles;
local math_rad = math.rad;
local Vector3_new_ret = Vector3.new();
local script_CameraShakeInstance = require(script.CameraShakeInstance);
local CameraShakeState = script_CameraShakeInstance.CameraShakeState;
u1.CameraShakeInstance = script_CameraShakeInstance;
u1.Presets = require(script.CameraShakePresets);

function u1.new(p2, p3) -- Line: 87
    -- upvalues: Vector3_new_ret (copy), u1 (copy)
    local v4 = type(p2) == "number";
    assert(v4, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)");
    local v5 = type(p3) == "function";
    assert(v5, "Callback must be a function");

    return setmetatable({
        _running = false,
        _renderName = "CameraShaker",
        _renderPriority = p2,
        _posAddShake = Vector3_new_ret,
        _rotAddShake = Vector3_new_ret,
        _camShakeInstances = {},
        _removeInstances = {},
        _callback = p3
    }, u1);
end;

function u1.Start(u6) -- Line: 108
    -- upvalues: debug_profilebegin (copy), debug_profileend (copy)
    if u6._running then
        return;
    end;

    u6._running = true;
    local _callback = u6._callback;
    game:GetService("RunService"):BindToRenderStep(u6._renderName, u6._renderPriority, function(p7) -- Line: 113
        -- upvalues: debug_profilebegin (ref), u6 (copy), debug_profileend (ref), _callback (copy)
        debug_profilebegin("CameraShakerUpdate");
        local v8 = u6:Update(p7);
        debug_profileend();
        _callback(v8);
    end);
end;

function u1.Stop(p9) -- Line: 122
    if not p9._running then
        return;
    end;

    game:GetService("RunService"):UnbindFromRenderStep(p9._renderName);
    p9._running = false;
end;

function u1.StopSustained(p10, p11) -- Line: 128
    for _, v in p10._camShakeInstances do
        if v.fadeOutDuration == 0 then
            v:StartFadeOut(p11 or v.fadeInDuration);
        end;
    end;
end;

function u1.Destroy(p12) -- Line: 136
    p12._running = false;
    game:GetService("RunService"):UnbindFromRenderStep(p12._renderName);
    table.clear(p12._camShakeInstances);
end;

function u1.Update(p13, p14) -- Line: 142
    -- upvalues: Vector3_new_ret (copy), CameraShakeState (copy), CFrame_new (copy), CFrame_Angles (copy), math_rad (copy)
    local v15 = Vector3_new_ret;
    local v16 = Vector3_new_ret;
    local _camShakeInstances = p13._camShakeInstances;

    for i = 1, #_camShakeInstances do
        local v17 = _camShakeInstances[i];
        local State = v17:GetState();
        local v18;

        if State == CameraShakeState.Inactive and v17.DeleteOnInactive then
            p13._removeInstances[#p13._removeInstances + 1] = i;
            v18 = i;
        elseif State == CameraShakeState.Inactive then
            v18 = i;
        else
            local v19 = v17:UpdateShake(p14);
            v15 = v15 + v19 * v17.PositionInfluence;
            v16 = v16 + v19 * v17.RotationInfluence;
            v18 = i;
        end;
    end;

    for i = #p13._removeInstances, 1, -1 do
        table.remove(_camShakeInstances, p13._removeInstances[i]);
        p13._removeInstances[i] = nil;
        local _ = i;
    end;

    return CFrame_new(v15) * CFrame_Angles(0, math_rad(v16.Y), 0) * CFrame_Angles(math_rad(v16.X), 0, (math_rad(v16.Z)));
end;

function u1.Shake(p20, p21) -- Line: 179
    local v22;

    if type(p21) == "table" then
        v22 = p21._camShakeInstance;
    else
        v22 = false;
    end;

    assert(v22, "ShakeInstance must be of type CameraShakeInstance");
    p20._camShakeInstances[#p20._camShakeInstances + 1] = p21;

    return p21;
end;

function u1.ShakeSustain(p23, p24) -- Line: 186
    local v25;

    if type(p24) == "table" then
        v25 = p24._camShakeInstance;
    else
        v25 = false;
    end;

    assert(v25, "ShakeInstance must be of type CameraShakeInstance");
    p23._camShakeInstances[#p23._camShakeInstances + 1] = p24;
    p24:StartFadeIn(p24.fadeInDuration);

    return p24;
end;

function u1.ShakeOnce(p26, p27, p28, p29, p30, p31, p32) -- Line: 194
    -- upvalues: script_CameraShakeInstance (copy)
    local v33 = script_CameraShakeInstance.new(p27, p28, p29, p30);
    v33.PositionInfluence = typeof(p31) == "Vector3" and p31 and p31 or Vector3.new(0.15, 0.15, 0.15);
    v33.RotationInfluence = typeof(p32) == "Vector3" and p32 and p32 or Vector3.new(1, 1, 1);
    p26._camShakeInstances[#p26._camShakeInstances + 1] = v33;

    return v33;
end;

function u1.StartShake(p34, p35, p36, p37, p38, p39) -- Line: 203
    -- upvalues: script_CameraShakeInstance (copy)
    local v40 = script_CameraShakeInstance.new(p35, p36, p37);
    v40.PositionInfluence = typeof(p38) == "Vector3" and p38 and p38 or Vector3.new(0.15, 0.15, 0.15);
    v40.RotationInfluence = typeof(p39) == "Vector3" and p39 and p39 or Vector3.new(1, 1, 1);
    v40:StartFadeIn(p37);
    p34._camShakeInstances[#p34._camShakeInstances + 1] = v40;

    return v40;
end;

return u1;