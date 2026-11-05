  

 

local RunService = game:GetService("RunService");
local Parent = script.Parent.Parent.Parent.Parent;
local Chassis = Parent.Chassis;
local RightNitroEmitterAttachment = Chassis.RightNitroEmitterAttachment;
local LeftNitroEmitterAttachment = Chassis.LeftNitroEmitterAttachment;
local getAverageWheelSlip = require(script.Parent.getAverageWheelSlip);
local u1 = false;
local v2 = {
    startNitro = function() -- Line: 14, Name: startNitro
        -- upvalues: u1 (ref), RightNitroEmitterAttachment (copy), LeftNitroEmitterAttachment (copy)
        if u1 then
            return;
        end;

        u1 = true;

        for _, child in RightNitroEmitterAttachment:GetChildren() do
            child.Enabled = true;
        end;

        for _, child in LeftNitroEmitterAttachment:GetChildren() do
            child.Enabled = true;
        end;
    end,

    stopNitro = function() -- Line: 30, Name: stopNitro
        -- upvalues: u1 (ref), RightNitroEmitterAttachment (copy), LeftNitroEmitterAttachment (copy)
        if not u1 then
            return;
        end;

        u1 = false;

        for _, child in RightNitroEmitterAttachment:GetChildren() do
            child.Enabled = false;
        end;

        for _, child in LeftNitroEmitterAttachment:GetChildren() do
            child.Enabled = false;
        end;
    end
};
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Include;
u3.FilterDescendantsInstances = { workspace.Map };

local function onHeartbeat(p4) -- Line: 50
    -- upvalues: Parent (copy), getAverageWheelSlip (copy), u3 (copy)
    if not (Parent and Parent:IsDescendantOf(game)) then
        return;
    end;

    local v5 = getAverageWheelSlip();

    for _, child in Parent.Wheels:GetChildren() do
        local v6 = workspace:Raycast(child.Wheel.Position, Vector3.new(0, -4, 0), u3);

        for _, descendant in child.Mount.TireFX:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                local v7;

                if math.abs(v5) > 35 then
                    v7 = v6;
                else
                    v7 = false;
                end;

                descendant.Enabled = v7;
            end;
        end;
    end;
end;

function v2.initialize() -- Line: 70
    -- upvalues: Parent (copy), RunService (copy), onHeartbeat (copy)
    for _, descendant in Parent.Wheels:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    local u8 = RunService.Heartbeat:Connect(onHeartbeat);
    Parent.AncestryChanged:Connect(function(p9, p10) -- Line: 78
        -- upvalues: u8 (copy)
        if not p10 then
            u8:Disconnect();
        end;
    end);
end;

v2.initialize();

return v2;