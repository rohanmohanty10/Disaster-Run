 
 

local RunService = game:GetService("RunService");
require(script.Parent.Types);
local Holder = require(script.Parent.Holder);
local u1 = RunService:IsServer();
local RegisterChange = Holder.RegisterChange;
local u2 = {};

for _, v in Enum.HumanoidStateType:GetEnumItems() do
    u2[v.Value] = v;
end;

local function GetHumanoid(p3) -- Line: 16
    local model = p3.model;

    if model and model:IsA("Model") then
        return model:FindFirstChildWhichIsA("Humanoid", true);
    end;

    return nil;
end;

local function GetDisabledStateMask(p4: userdata) -- Line: 24
    -- upvalues: u2 (copy)
    local v5 = 0;

    for i, v in u2 do
        if v ~= Enum.HumanoidStateType.None and not p4:GetStateEnabled(v) then
            local bit32_lshift_ret = bit32.lshift(1, i);
            v5 = bit32.bor(v5, bit32_lshift_ret);
        end;
    end;

    return v5;
end;

local function StartHumanoidStateWatch(u6) -- Line: 55
    -- upvalues: u1 (copy), RegisterChange (copy), GetDisabledStateMask (copy)
    if not u1 then
        return;
    end;

    local _humanoidStateConn = u6._humanoidStateConn;

    if _humanoidStateConn then
        _humanoidStateConn:Disconnect();
        u6._humanoidStateConn = nil;
    end;

    local _humanoidStateEnabledConn = u6._humanoidStateEnabledConn;

    if _humanoidStateEnabledConn then
        _humanoidStateEnabledConn:Disconnect();
        u6._humanoidStateEnabledConn = nil;
    end;

    if u1 then
        RegisterChange(u6, "_humanoidState", nil);
        RegisterChange(u6, "_humanoidDisabledStates", nil);
    end;

    local model = u6.model;
    local u7;

    if model and model:IsA("Model") then
        u7 = model:FindFirstChildWhichIsA("Humanoid", true);
    else
        u7 = nil;
    end;

    if not u7 then
        return;
    end;

    RegisterChange(u6, "_humanoidState", u7:GetState().Value, true);
    u6._humanoidStateConn = u7.StateChanged:Connect(function(p8, p9) -- Line: 67
        -- upvalues: RegisterChange (ref), u6 (copy)
        RegisterChange(u6, "_humanoidState", p9.Value);
    end);
    RegisterChange(u6, "_humanoidDisabledStates", GetDisabledStateMask(u7), true);
    u6._humanoidStateEnabledConn = u7.StateEnabledChanged:Connect(function() -- Line: 72
        -- upvalues: RegisterChange (ref), u6 (copy), GetDisabledStateMask (ref), u7 (copy)
        RegisterChange(u6, "_humanoidDisabledStates", (GetDisabledStateMask(u7)));
    end);
end;

return {
    Refresh = function(p10: any, p11: boolean?) -- Line: 77, Name: RefreshHumanoidStateWatch
        -- upvalues: u1 (copy), RegisterChange (copy), StartHumanoidStateWatch (copy)
        if not u1 then
            return;
        end;

        local entityConfig = p10.entityConfig;
        local _interpolationMode = p10._interpolationMode;

        if _interpolationMode then
            entityConfig = _interpolationMode;
        elseif entityConfig then
            entityConfig = entityConfig.INTERPOLATION_MODE;
        end;

        if entityConfig == "ALIGN" then
            if p10._humanoidStateConn and not p11 then
                return;
            end;

            StartHumanoidStateWatch(p10);

            return;
        end;

        local _humanoidStateConn = p10._humanoidStateConn;

        if _humanoidStateConn then
            _humanoidStateConn:Disconnect();
            p10._humanoidStateConn = nil;
        end;

        local _humanoidStateEnabledConn = p10._humanoidStateEnabledConn;

        if _humanoidStateEnabledConn then
            _humanoidStateEnabledConn:Disconnect();
            p10._humanoidStateEnabledConn = nil;
        end;

        if u1 then
            RegisterChange(p10, "_humanoidState", nil);
            RegisterChange(p10, "_humanoidDisabledStates", nil);
        end;
    end,

    Stop = function(p12) -- Line: 37, Name: StopHumanoidStateWatch
        -- upvalues: u1 (copy), RegisterChange (copy)
        local _humanoidStateConn = p12._humanoidStateConn;

        if _humanoidStateConn then
            _humanoidStateConn:Disconnect();
            p12._humanoidStateConn = nil;
        end;

        local _humanoidStateEnabledConn = p12._humanoidStateEnabledConn;

        if _humanoidStateEnabledConn then
            _humanoidStateEnabledConn:Disconnect();
            p12._humanoidStateEnabledConn = nil;
        end;

        if u1 then
            RegisterChange(p12, "_humanoidState", nil);
            RegisterChange(p12, "_humanoidDisabledStates", nil);
        end;
    end,

    SetState = function(p13: any, p14: number?) -- Line: 96, Name: SetHumanoidState
        -- upvalues: RegisterChange (copy), u1 (copy), u2 (copy)
        RegisterChange(p13, "_humanoidState", p14);

        if u1 or (p13.isContextOwner or type(p14) ~= "number") then
            return;
        end;

        local model = p13.model;
        local v15;

        if model and model:IsA("Model") then
            v15 = model:FindFirstChildWhichIsA("Humanoid", true);
        else
            v15 = nil;
        end;

        if not v15 then
            return;
        end;

        local v16 = u2[p14];

        if not v16 then
            return;
        end;

        if v16 == Enum.HumanoidStateType.Ragdoll then
            v16 = Enum.HumanoidStateType.Physics;
        end;

        v15:ChangeState(v16);
    end,

    SetDisabledStates = function(p17: any, p18: number?) -- Line: 119, Name: SetHumanoidDisabledStates
        -- upvalues: RegisterChange (copy), u1 (copy), u2 (copy)
        RegisterChange(p17, "_humanoidDisabledStates", p18);

        if u1 or (p17.isContextOwner or type(p18) ~= "number") then
            return;
        end;

        local model = p17.model;
        local v19;

        if model and model:IsA("Model") then
            v19 = model:FindFirstChildWhichIsA("Humanoid", true);
        else
            v19 = nil;
        end;

        if not v19 then
            return;
        end;

        for i, v in u2 do
            if v ~= Enum.HumanoidStateType.None then
                local bit32_lshift_ret = bit32.lshift(1, i);
                v19:SetStateEnabled(v, bit32.band(p18, bit32_lshift_ret) == 0);
            end;
        end;
    end
};