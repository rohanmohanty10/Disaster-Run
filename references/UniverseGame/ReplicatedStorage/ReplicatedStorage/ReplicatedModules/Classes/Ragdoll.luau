  

 

local u1 = {};
u1.__index = u1;
local Rigging = require(script:WaitForChild("Rigging"));

function u1.new(p2) -- Line: 6
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Character = p2;
    v3.Humanoid = p2:WaitForChild("Humanoid");
    v3.Active = {};
    v3.Rigging = require(script.Rigging);

    return v3;
end;

function u1.GetRigData(p4, p5, p6) -- Line: 19
    -- upvalues: Rigging (copy)
    local v7 = nil;
    local v8 = nil;

    if p4.Humanoid.RigType == Enum.HumanoidRigType.R6 then
        v7 = Rigging.Constants.R6_RAGDOLL_RIG;
        v8 = Rigging.Constants.R6_MOTOR6DS;
    elseif p4.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        v7 = Rigging.Constants.R15_RAGDOLL_RIG;
        v8 = Rigging.Constants.R15_MOTOR6DS;
    end;

    local v9 = {};
    local v10 = {};

    if p5 then
        for i, v in pairs(v7) do
            if table.find(p5, i) and p4.Active[i] ~= nil == p6 then
                v9[i] = v;
            end;
        end;

        for i, v in pairs(v8) do
            if table.find(p5, i) and p4.Active[i] ~= nil == p6 then
                v10[i] = v;
            end;
        end;

        return v9, v10;
    end;

    for i, v in pairs(v7) do
        if p4.Active[i] ~= nil == p6 then
            v9[i] = v;
        end;
    end;

    for i, v in pairs(v8) do
        if p4.Active[i] ~= nil == p6 then
            v10[i] = v;
        end;
    end;

    return v9, v10;
end;

function u1.Enable(p11, p12) -- Line: 61
    -- upvalues: Rigging (copy)
    local v13, v14 = p11:GetRigData(p12, false);
    Rigging.disableMotors(p11.Character, p11.Humanoid.RigType, v14);

    for i, v in pairs(Rigging.createRagdollJoints(p11.Character, p11.Humanoid.RigType, v13)) do
        p11.Active[i] = v;
    end;
end;

function u1.Disable(p15, p16) -- Line: 70
    -- upvalues: Rigging (copy)
    local v17, v18 = p15:GetRigData(p16, true);
    Rigging.enableMotors(p15.Character, p15.Humanoid.RigType, v18);

    for i, _ in pairs(Rigging.removeRagdollJoints(p15.Character, v17)) do
        p15.Active[i] = nil;
    end;
end;

function u1.Destroy(p19) -- Line: 78
    p19:Disable();
    setmetatable(p19, nil);
end;

return u1;