 

 

local u1 = {};
u1.__index = u1;
local l__profilebegin__1 = debug.profilebegin;
local l__profileend__2 = debug.profileend;
local l__new__3 = Vector3.new;
local l__new__4 = CFrame.new;
local l__Angles__5 = CFrame.Angles;
local l__rad__6 = math.rad;
local u2 = l__new__3();
local l__CameraShakeInstance__7 = require(script.CameraShakeInstance);
local l__CameraShakeState__8 = l__CameraShakeInstance__7.CameraShakeState;
u1.CameraShakeInstance = l__CameraShakeInstance__7;
u1.Presets = require(script.CameraShakePresets);
function u1.new(p3, p4, p5) --[[ Line: 87 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v6 = type(p3) == "number";
    assert(v6, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)");
    local v7 = type(p4) == "function";
    assert(v7, "Callback must be a function");
    return setmetatable({
        _running = false,
        _renderName = p5 or "CameraShaker",
        _renderPriority = p3,
        _posAddShake = u2,
        _rotAddShake = u2,
        _camShakeInstances = {},
        _removeInstances = {},
        _callback = p4
    }, u1);
end;
function u1.Start(u8) --[[ Line: 108 ]]
    -- upvalues: l__profilebegin__1 (copy), l__profileend__2 (copy)
    if workspace:FindFirstChild("Skill Tree") or u8._running then
    else
        u8._running = true;
        local l___callback__9 = u8._callback;
        game:GetService("RunService"):BindToRenderStep(u8._renderName, u8._renderPriority, function(p9) --[[ Line: 112 ]]
            -- upvalues: l__profilebegin__1 (ref), u8 (copy), l__profileend__2 (ref), l___callback__9 (copy)
            l__profilebegin__1("CameraShakerUpdate");
            local v10 = u8:Update(p9);
            l__profileend__2();
            l___callback__9(v10);
        end);
    end;
end;
function u1.Stop(p11) --[[ Line: 121 ]]
    if p11._running then
        game:GetService("RunService"):UnbindFromRenderStep(p11._renderName);
        p11._running = false;
    end;
end;
function u1.Destroy(p12) --[[ Line: 127 ]]
    p12:Stop();
end;
function u1.StopSustained(p13, p14) --[[ Line: 133 ]]
    for _, v15 in pairs(p13._camShakeInstances) do
        if v15.fadeOutDuration == 0 then
            v15:StartFadeOut(p14 or v15.fadeInDuration);
        end;
    end;
end;
function u1.DestroySustained(u16, p17) --[[ Line: 141 ]]
    for _, v18 in pairs(u16._camShakeInstances) do
        if v18.fadeOutDuration == 0 then
            v18:StartFadeOut(p17 or v18.fadeInDuration);
        end;
    end;
    delay(p17, function() --[[ Line: 148 ]]
        -- upvalues: u16 (copy)
        u16:Destroy();
    end);
end;
function u1.Update(p19, p20) --[[ Line: 153 ]]
    -- upvalues: u2 (copy), l__CameraShakeState__8 (copy), l__new__4 (copy), l__Angles__5 (copy), l__rad__6 (copy)
    if _G.ScreenShakeEnabled ~= nil and _G.ScreenShakeEnabled == false then
        return CFrame.new();
    end;
    local v21 = u2;
    local v22 = u2;
    local l___camShakeInstances__10 = p19._camShakeInstances;
    for v23 = 1, #l___camShakeInstances__10 do
        local v24 = l___camShakeInstances__10[v23];
        local v25 = v24:GetState();
        if v25 == l__CameraShakeState__8.Inactive and v24.DeleteOnInactive then
            p19._removeInstances[#p19._removeInstances + 1] = v23;
        elseif v25 ~= l__CameraShakeState__8.Inactive then
            local v26 = v24:UpdateShake(p20);
            v21 = v21 + v26 * v24.PositionInfluence;
            v22 = v22 + v26 * v24.RotationInfluence;
        end;
    end;
    for v27 = #p19._removeInstances, 1, -1 do
        table.remove(l___camShakeInstances__10, p19._removeInstances[v27]);
        p19._removeInstances[v27] = nil;
    end;
    return l__new__4(v21) * l__Angles__5(0, l__rad__6(v22.Y), 0) * l__Angles__5(l__rad__6(v22.X), 0, (l__rad__6(v22.Z)));
end;
function u1.Shake(p28, p29) --[[ Line: 194 ]]
    local v30;
    if type(p29) == "table" then
        v30 = p29._camShakeInstance;
    else
        v30 = false;
    end;
    assert(v30, "ShakeInstance must be of type CameraShakeInstance");
    p28._camShakeInstances[#p28._camShakeInstances + 1] = p29;
    return p29;
end;
function u1.ShakeSustain(p31, p32) --[[ Line: 201 ]]
    local v33;
    if type(p32) == "table" then
        v33 = p32._camShakeInstance;
    else
        v33 = false;
    end;
    assert(v33, "ShakeInstance must be of type CameraShakeInstance");
    p31._camShakeInstances[#p31._camShakeInstances + 1] = p32;
    p32:StartFadeIn(p32.fadeInDuration);
    return p32;
end;
function u1.ShakeOnce(p34, p35, p36, p37, p38, p39, p40) --[[ Line: 209 ]]
    -- upvalues: l__CameraShakeInstance__7 (copy)
    local v41 = l__CameraShakeInstance__7.new(p35, p36, p37, p38);
    v41.PositionInfluence = typeof(p39) == "Vector3" and p39 and p39 or Vector3.new(0.15, 0.15, 0.15);
    v41.RotationInfluence = typeof(p40) == "Vector3" and p40 and p40 or Vector3.new(1, 1, 1);
    p34._camShakeInstances[#p34._camShakeInstances + 1] = v41;
    return v41;
end;
function u1.StartShake(p42, p43, p44, p45, p46, p47) --[[ Line: 218 ]]
    -- upvalues: l__CameraShakeInstance__7 (copy)
    local v48 = l__CameraShakeInstance__7.new(p43, p44, p45);
    v48.PositionInfluence = typeof(p46) == "Vector3" and p46 and p46 or Vector3.new(0.15, 0.15, 0.15);
    v48.RotationInfluence = typeof(p47) == "Vector3" and p47 and p47 or Vector3.new(1, 1, 1);
    v48:StartFadeIn(p45);
    p42._camShakeInstances[#p42._camShakeInstances + 1] = v48;
    return v48;
end;
return u1;