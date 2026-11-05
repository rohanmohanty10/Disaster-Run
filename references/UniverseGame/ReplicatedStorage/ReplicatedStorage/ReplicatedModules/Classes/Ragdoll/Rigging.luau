  

 

local RunService = game:GetService("RunService");
local Constants = require(script:WaitForChild("Constants"));
local v1 = {
    Constants = Constants
};
local REFERENCE_GRAVITY = Constants.REFERENCE_GRAVITY;
local DEFAULT_MAX_FRICTION_TORQUE = Constants.DEFAULT_MAX_FRICTION_TORQUE;
local _ = Constants.HEAD_LIMITS;
local _ = Constants.WAIST_LIMITS;
local _ = Constants.ANKLE_LIMITS;
local _ = Constants.ELBOW_LIMITS;
local _ = Constants.WRIST_LIMITS;
local _ = Constants.KNEE_LIMITS;
local _ = Constants.SHOULDER_LIMITS;
local _ = Constants.HIP_LIMITS;
local _ = Constants.R6_HEAD_LIMITS;
local _ = Constants.R6_SHOULDER_LIMITS;
local _ = Constants.R6_HIP_LIMITS;
local _ = Constants.V3_ZERO;
local _ = Constants.V3_UP;
local _ = Constants.V3_DOWN;
local _ = Constants.V3_RIGHT;
local _ = Constants.V3_LEFT;
local R15_ADDITIONAL_ATTACHMENTS = Constants.R15_ADDITIONAL_ATTACHMENTS;
local R15_RAGDOLL_RIG = Constants.R15_RAGDOLL_RIG;
local R15_NO_COLLIDES = Constants.R15_NO_COLLIDES;
local R15_MOTOR6DS = Constants.R15_MOTOR6DS;
local R6_ADDITIONAL_ATTACHMENTS = Constants.R6_ADDITIONAL_ATTACHMENTS;
local R6_RAGDOLL_RIG = Constants.R6_RAGDOLL_RIG;
local R6_NO_COLLIDES = Constants.R6_NO_COLLIDES;
local R6_MOTOR6DS = Constants.R6_MOTOR6DS;
local BALL_SOCKET_NAME = Constants.BALL_SOCKET_NAME;
local NO_COLLIDE_NAME = Constants.NO_COLLIDE_NAME;

local function indexParts(p2) -- Line: 47
    local v3 = {};

    for _, child in ipairs(p2:GetChildren()) do
        if child:IsA("BasePart") then
            local name = child.name;

            if not v3[name] then
                v3[name] = child;
            end;
        end;
    end;

    return v3;
end;

local function getDescendants(p4, p5) -- Line: 61
    local u6 = {};
    local u7 = 0;
    local u8 = p5 or 0;

    local function get(p9) -- Line: 66
        -- upvalues: u6 (copy), u7 (ref), u8 (copy), get (copy)
        for _, child in pairs(p9:GetChildren()) do
            table.insert(u6, child);

            if child:IsA("Model") and u7 < u8 then
                get(child);
                u7 = u7 + 1;
            elseif not child:IsA("Model") then
                get(child);
            end;
        end;
    end;

    get(p4);

    return u6;
end;

local function createRigJoints(p10, p11) -- Line: 83
    -- upvalues: BALL_SOCKET_NAME (copy), REFERENCE_GRAVITY (copy), DEFAULT_MAX_FRICTION_TORQUE (copy)
    local v12 = {};

    for i, v in pairs(p11) do
        local v13, v14, v15, v16 = unpack(v);
        local v17 = p10[v13];
        local v18 = p10[v14];

        if v17 and v18 then
            local v19 = v17:FindFirstChild(v15);
            local v20 = v18:FindFirstChild(v15);

            if not v17:GetAttribute("NoRig") and (not v18:GetAttribute("NoRig") and (v19 and (v20 and (v19:IsA("Attachment") and v20:IsA("Attachment"))))) then
                local v21 = v18:FindFirstChild(BALL_SOCKET_NAME);

                if not v21 then
                    v21 = Instance.new("BallSocketConstraint");
                    v21.Name = BALL_SOCKET_NAME;
                    v21:SetAttribute("Joint", i);
                end;

                v21.Attachment0 = v19;
                v21.Attachment1 = v20;
                v21.LimitsEnabled = true;
                v21.UpperAngle = v16.UpperAngle;
                v21.TwistLimitsEnabled = true;
                v21.TwistLowerAngle = v16.TwistLowerAngle;
                v21.TwistUpperAngle = v16.TwistUpperAngle;
                local v22 = workspace.Gravity / REFERENCE_GRAVITY;
                local ReferenceMass = v16.ReferenceMass;
                local v23 = ReferenceMass and (v18:GetMass() / ReferenceMass or 1) or 1;
                v21.MaxFrictionTorque = (v16.FrictionTorque or DEFAULT_MAX_FRICTION_TORQUE) * v23 * v22;
                v21.Parent = v18;
                v12[i] = v21;
            end;
        end;
    end;

    return v12;
end;

local function createAdditionalAttachments(p24, p25) -- Line: 130
    for _, v in ipairs(p25) do
        local v26, v27, v28, v29 = unpack(v);
        local v30 = p24[v26];

        if v30 then
            local v31 = v30:FindFirstChild(v27);

            if not v31 or v31:IsA("Attachment") then
                if v29 then
                    local v32 = v30:FindFirstChild(v29);

                    if v32 and v32:IsA("Attachment") then
                        v28 = v32.CFrame * v28;
                    end;
                end;

                if v31 then
                    v31.CFrame = v28;
                else
                    local Attachment = Instance.new("Attachment");
                    Attachment.Name = v27;
                    Attachment.CFrame = v28;
                    Attachment.Parent = v30;
                end;
            end;
        end;
    end;
end;

local function createNoCollides(p33, p34) -- Line: 158
    -- upvalues: NO_COLLIDE_NAME (copy)
    local v35 = {};

    for _, v in ipairs(p34) do
        local v36, v37 = unpack(v);
        local v38 = p33[v36];
        local v39 = p33[v37];

        if v38 and v39 then
            local v40 = v35[v39];

            if not v40 then
                v40 = {};
                v35[v39] = v40;
            end;

            v40[v38] = true;
        end;
    end;

    local v41 = {};

    for i, v in pairs(v35) do
        local v42 = {};

        for _, child in ipairs(i:GetChildren()) do
            if child:IsA("NoCollisionConstraint") and child.Name == NO_COLLIDE_NAME then
                local Part0 = child.Part0;

                if child.Part1 == i and v[Part0] then
                    v[Part0] = nil;
                else
                    table.insert(v42, child);
                end;
            end;
        end;

        v41[i] = v42;
    end;

    for i, v in pairs(v35) do
        local v43 = v41[i];

        for i2, _ in pairs(v) do
            local v44 = table.remove(v43) or Instance.new("NoCollisionConstraint");
            v44.Name = NO_COLLIDE_NAME;
            v44.Part0 = i2;
            v44.Part1 = i;
            v44.Parent = i;
        end;
    end;
end;

local function isAttachmentInPart(p45, p46) -- Line: 217
    return p45 and p45.Parent == p46 and true or false;
end;

local function checkValidAttachment(p47, p48, p49, p50) -- Line: 221
    return p49 and p49.Parent == p47 and (p50 and p50.Parent == p48) and true or (p49 and p49.Parent == p48 and (p50 and p50.Parent == p47) and true or false);
end;

local function hasValidConstraint(p51, p52) -- Line: 233
    for _, child in ipairs(p52:GetChildren()) do
        if child:IsA("BallSocketConstraint") then
            local Attachment0 = child.Attachment0;
            local Attachment1 = child.Attachment1;
            local v53;

            if Attachment0 and Attachment0.Parent == p51 and (Attachment1 and Attachment1.Parent == p52) then
                v53 = true;
            elseif Attachment0 and Attachment0.Parent == p52 and true or false then
                v53 = Attachment1 and Attachment1.Parent == p51 and true or false;
            else
                v53 = false;
            end;

            if v53 then
                return true;
            end;
        end;
    end;

    return false;
end;

local function hasRagdollJoint(p54) -- Line: 248
    return true;
end;

local function disableMotorSet(p55, p56) -- Line: 268
    local v57 = {};

    for _, v in pairs(p56) do
        if v[1] and v[2] then
            local v58 = p55:FindFirstChild(v[2]);

            if v58 then
                local v59 = v58:FindFirstChild(v[1]);

                if v59 and v59:IsA("Motor6D") then
                    table.insert(v57, v59);
                    v59.Enabled = false;
                end;
            end;
        end;
    end;

    return v57;
end;

local function enableMotorSet(p60, p61) -- Line: 286
    local v62 = {};

    for _, v in pairs(p61) do
        if v[1] and v[2] then
            local v63 = p60:FindFirstChild(v[2]);

            if v63 then
                local v64 = v63:FindFirstChild(v[1]);

                if v64 and (v64:IsA("Motor6D") and not v64:GetAttribute("Disabled")) then
                    table.insert(v62, v64);
                    v64.Enabled = true;
                end;
            end;
        end;
    end;

    return v62;
end;

function v1.createRagdollJoints(p65, p66, p67, p68) -- Line: 304
    -- upvalues: indexParts (copy), createAdditionalAttachments (copy), R6_ADDITIONAL_ATTACHMENTS (copy), createRigJoints (copy), R6_RAGDOLL_RIG (copy), createNoCollides (copy), R6_NO_COLLIDES (copy), R15_ADDITIONAL_ATTACHMENTS (copy), R15_RAGDOLL_RIG (copy), R15_NO_COLLIDES (copy)
    local v69 = indexParts(p65);

    if p66 == Enum.HumanoidRigType.R6 then
        createAdditionalAttachments(v69, R6_ADDITIONAL_ATTACHMENTS);
        local v70 = createRigJoints(v69, p67 or R6_RAGDOLL_RIG);
        createNoCollides(v69, p68 or R6_NO_COLLIDES);

        return v70;
    end;

    if p66 == Enum.HumanoidRigType.R15 then
        createAdditionalAttachments(v69, R15_ADDITIONAL_ATTACHMENTS);
        local v71 = createRigJoints(v69, p67 or R15_RAGDOLL_RIG);
        createNoCollides(v69, p68 or R15_NO_COLLIDES);

        return v71;
    end;

    error("unknown rig type", 2);
end;

function v1.removeRagdollJoints(p72, p73) -- Line: 321
    -- upvalues: BALL_SOCKET_NAME (copy), NO_COLLIDE_NAME (copy)
    local v74 = {};
    local v75 = pairs;
    local u76 = {};
    local u77 = 0;
    local u78 = 0;

    local function u80(p79) -- Line: 66
        -- upvalues: u76 (copy), u77 (ref), u78 (copy), u80 (copy)
        for _, child in pairs(p79:GetChildren()) do
            table.insert(u76, child);

            if child:IsA("Model") and u77 < u78 then
                u80(child);
                u77 = u77 + 1;
            elseif not child:IsA("Model") then
                u80(child);
            end;
        end;
    end;

    u80(p72);

    for _, v in v75(u76) do
        if v:IsA("BallSocketConstraint") and v.Name == BALL_SOCKET_NAME or v:IsA("NoCollisionConstraint") and v.Name == NO_COLLIDE_NAME then
            local v81 = v:GetAttribute("Joint");

            if p73 == nil or v81 and (typeof(p73) == "table" and p73[v81]) then
                if v81 then
                    v74[v81] = true;
                end;

                v:Destroy();
            end;
        end;
    end;

    return v74;
end;

function v1.disableMotors(p82, p83, p84) -- Line: 340
    -- upvalues: R6_MOTOR6DS (copy), disableMotorSet (copy), R15_MOTOR6DS (copy)
    local v85 = nil;

    if p83 == Enum.HumanoidRigType.R6 then
        p84 = p84 or R6_MOTOR6DS;
        v85 = disableMotorSet(p82, p84);
    elseif p83 == Enum.HumanoidRigType.R15 then
        p84 = p84 or R15_MOTOR6DS;
        v85 = disableMotorSet(p82, p84);
    else
        error("unknown rig type", 2);
    end;

    if p84.RootPart then
        local v86 = p82.PrimaryPart or p82:FindFirstChild("HumanoidRootPart");

        if v86 and v86:IsA("BasePart") then
            v86.CanCollide = false;
        end;
    end;

    return v85;
end;

function v1.enableMotors(p87, p88, p89) -- Line: 371
    -- upvalues: enableMotorSet (copy), R6_MOTOR6DS (copy), R15_MOTOR6DS (copy)
    local v90 = nil;

    if p88 == Enum.HumanoidRigType.R6 then
        v90 = enableMotorSet(p87, p89 or R6_MOTOR6DS);
    elseif p88 == Enum.HumanoidRigType.R15 then
        v90 = enableMotorSet(p87, p89 or R15_MOTOR6DS);
    else
        error("unknown rig type", 2);
    end;

    if p89.RootPart then
        local v91 = p87.PrimaryPart or p87:FindFirstChild("HumanoidRootPart");

        if v91 and v91:IsA("BasePart") then
            v91.CanCollide = true;
        end;
    end;

    return v90;
end;

function v1.disableParticleEmittersAndFadeOut(p92, p93) -- Line: 396
    -- upvalues: RunService (copy)
    if RunService:IsServer() then
        error("disableParticleEmittersAndFadeOut should not be called on the server.", 2);
    end;

    local u94 = {};
    local u95 = 0;
    local u96 = 0;

    local function u98(p97) -- Line: 66
        -- upvalues: u94 (copy), u95 (ref), u96 (copy), u98 (copy)
        for _, child in pairs(p97:GetChildren()) do
            table.insert(u94, child);

            if child:IsA("Model") and u95 < u96 then
                u98(child);
                u95 = u95 + 1;
            elseif not child:IsA("Model") then
                u98(child);
            end;
        end;
    end;

    u98(p92);
    local v99 = {};

    for _, v in pairs(u94) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v99[v] = v.Transparency;
        elseif v:IsA("ParticleEmitter") then
            v.Enabled = false;
        end;
    end;

    local v100 = 0;

    while v100 < p93 do
        v100 = v100 + RunService.Heartbeat:Wait();
        local v101 = math.min(v100 / p93, 1);

        for i, v in pairs(v99) do
            i.Transparency = (1 - v101) * v + v101;
        end;
    end;
end;

function v1.easeJointFriction(p102, p103) -- Line: 424
    -- upvalues: BALL_SOCKET_NAME (copy), RunService (copy)
    local u104 = {};
    local u105 = 0;
    local u106 = 0;

    local function u108(p107) -- Line: 66
        -- upvalues: u104 (copy), u105 (ref), u106 (copy), u108 (copy)
        for _, child in pairs(p107:GetChildren()) do
            table.insert(u104, child);

            if child:IsA("Model") and u105 < u106 then
                u108(child);
                u105 = u105 + 1;
            elseif not child:IsA("Model") then
                u108(child);
            end;
        end;
    end;

    u108(p102);
    local v109 = {};

    for _, v in pairs(u104) do
        if v:IsA("BallSocketConstraint") and v.Name == BALL_SOCKET_NAME then
            local MaxFrictionTorque = v.MaxFrictionTorque;
            local Name = v.Parent.Name;
            v109[v] = { v, MaxFrictionTorque, MaxFrictionTorque * ((Name == "UpperTorso" or Name == "Head") and 0.5 or 0.05) };
        end;
    end;

    local v110 = 0;

    while v110 < p103 do
        local _, v111 = RunService.Stepped:Wait();
        v110 = v110 + v111;
        local v112 = math.min(v110 / p103, 1);

        for _, v in pairs(v109) do
            local v113, v114, v115 = unpack(v);
            v113.MaxFrictionTorque = (1 - v112) * v114 + v112 * v115;
        end;
    end;
end;

return v1;