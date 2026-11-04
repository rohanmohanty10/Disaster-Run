 

 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local ParticipantDirectory = require(ChickenOrHero.Presentation.ParticipantDirectory);
local DaggerConfig = require(ChickenOrHero.Weapons.DaggerConfig);
local KnifeClips = require(ChickenOrHero.Weapons.KnifeClips);
local ScythePose = require(ChickenOrHero.Weapons.ScythePose);
local u1 = {};
local u2 = {};

for i, v in KnifeClips.Actions do
    u1[KnifeClips.default(i)] = v;
    u2[i] = table.freeze({
        grip = true,
        looped = v.looped,
        priority = v.priority,
        equip = v.equip
    });
end;

local function register(p3) -- Line: 18
    -- upvalues: KnifeClips (copy), u1 (copy), u2 (copy)
    for i in KnifeClips.Actions do
        local v4 = KnifeClips.custom(p3, i);

        if v4 and not u1[v4] then
            u1[v4] = u2[i];
        end;
    end;

    local v5 = KnifeClips.stow(p3);

    if v5 and not u1[v5] then
        u1[v5] = KnifeClips.Stow;
    end;
end;

local function applyPolicy(p6) -- Line: 31
    -- upvalues: u1 (copy)
    local v7 = p6.Animation and u1[p6.Animation.AnimationId];

    if v7 then
        if p6.Looped ~= v7.looped then
            p6.Looped = v7.looped;
        end;

        if p6.Priority ~= v7.priority then
            p6.Priority = v7.priority;
        end;
    end;

    return v7;
end;

local u8 = {};
local u9 = {};
local u10 = {};
local u11 = 1;

local function restore(p12) -- Line: 45
    for _, v in p12.joints do
        if v.motor.Parent and (v.applied and v.motor.Transform == v.applied) then
            v.motor.Transform = v.base;
        end;

        v.applied = nil;
    end;
end;

local function remove(p13, p14) -- Line: 53
    -- upvalues: restore (copy), ScythePose (copy), u8 (copy)
    restore(p14);
    ScythePose.restore(p14.scythe);

    if p14.animationPlayed then
        p14.animationPlayed:Disconnect();
    end;

    u8[p13] = nil;
end;

local function bindAnimator(p15, p16) -- Line: 61
    -- upvalues: applyPolicy (copy), u1 (copy)
    if p15.animator == p16 then
        return;
    end;

    if p15.animationPlayed then
        p15.animationPlayed:Disconnect();
    end;

    p15.animator = p16;
    p15.animationPlayed = p16.AnimationPlayed:Connect(applyPolicy);

    for _, v in p16:GetPlayingAnimationTracks() do
        local v17 = v.Animation and u1[v.Animation.AnimationId];

        if v17 then
            if v.Looped ~= v17.looped then
                v.Looped = v17.looped;
            end;

            if v.Priority ~= v17.priority then
                v.Priority = v17.priority;
            end;
        end;
    end;
end;

table.insert(u10, RunService.PreAnimation:Connect(function() -- Line: 77
    -- upvalues: u8 (copy), restore (copy)
    for _, v in u8 do
        restore(v);
    end;
end));
table.insert(u10, RunService.PreSimulation:Connect(function(p18) -- Line: 85
    -- upvalues: u11 (ref), u9 (copy), ParticipantDirectory (copy), u8 (copy), register (copy), KnifeClips (copy), ScythePose (copy), restore (copy), bindAnimator (copy), DaggerConfig (copy), u1 (copy), Players (copy)
    u11 = u11 + p18;

    if u11 >= 0.1 then
        u11 = 0;
        table.clear(u9);

        for _, v in ParticipantDirectory.list() do
            u9[v.UserId] = v;
            local Character = v.Character;
            local v19;

            if Character then
                v19 = Character:FindFirstChild("EquippedDagger");
            else
                v19 = Character;
            end;

            local v20;

            if Character then
                v20 = Character:FindFirstChild("Right Arm");
            else
                v20 = Character;
            end;

            local v21;

            if Character then
                v21 = Character:FindFirstChild("Torso");
            else
                v21 = Character;
            end;

            if v20 then
                v20 = v20:FindFirstChild("Handle");
            end;

            local v22;

            if v21 then
                v22 = v21:FindFirstChild("Right Shoulder");
            else
                v22 = v21;
            end;

            if v19 and (v20 and (v22 and not u8[Character])) then
                register(v19);
                local v23 = KnifeClips.animated(v19);
                local v24 = {
                    yaw = 0,
                    model = v19,
                    torso = v21,
                    animated = v23
                };
                local v25;

                if v23 then
                    v25 = nil;
                else
                    v25 = ScythePose.new(v19) or nil;
                end;

                v24.scythe = v25;
                v24.joints = {
                    grip = {
                        motor = v20
                    },
                    arm = {
                        motor = v22
                    }
                };
                u8[Character] = v24;
            end;
        end;
    end;

    for i, v in u8 do
        restore(v);

        if i.Parent and (v.model.Parent and v.joints.grip.motor.Parent) then
            local v26 = i:FindFirstChildOfClass("Humanoid");
            local HumanoidRootPart = i:FindFirstChild("HumanoidRootPart");

            if v26 then
                v26 = v26:FindFirstChildOfClass("Animator");
            end;

            if HumanoidRootPart and v26 then
                bindAnimator(v, v26);
                local v27 = 0;
                local v28 = 0;
                local v29 = 0;
                local Attribute = i:GetAttribute("DaggerDrawStartedAt");
                local v30;

                if type(Attribute) == "number" then
                    v30 = workspace:GetServerTimeNow() >= Attribute + DaggerConfig.DrawDuration + DaggerConfig.FadeOut;
                else
                    v30 = false;
                end;

                local v31 = v;
                local v32 = i;

                for _, v2 in v26:GetPlayingAnimationTracks() do
                    local v33 = v2.Animation and u1[v2.Animation.AnimationId];

                    if v33 then
                        if v2.Looped ~= v33.looped then
                            v2.Looped = v33.looped;
                        end;

                        if v2.Priority ~= v33.priority then
                            v2.Priority = v33.priority;
                        end;
                    end;

                    if v33 then
                        if v33.equip and (v32:GetAttribute("DaggerState") ~= "Drawing" and (v32:GetAttribute("DaggerState") == "Stowed" or v30)) and v2.WeightTarget > 0 then
                            v2:Stop(DaggerConfig.FadeOut);
                        end;

                        if v33.grip then
                            v27 = v27 + v2.WeightCurrent;
                        end;

                        if v33.dive and v2.Length > 0 then
                            v28 = v2.WeightCurrent;
                            v29 = v2.TimePosition / v2.Length;
                        end;
                    end;
                end;

                local v34 = not v31.animated and v31.model:GetAttribute("IdleGrip");

                if typeof(v34) == "CFrame" then
                    local grip = v31.joints.grip;
                    grip.base = grip.motor.Transform;
                    grip.applied = grip.base:Lerp(v34, 1 - math.clamp(v27, 0, 1));
                    grip.motor.Transform = grip.applied;
                end;

                ScythePose.apply(v31.scythe, v29, v28);
                local v35;

                if v32 == Players.LocalPlayer.Character then
                    v35 = v32:GetAttribute("LocalMeleeActive") == true;
                else
                    v35 = false;
                end;

                local v36 = v35 and v32:GetAttribute("LocalMeleePhase") or v32:GetAttribute("ReachPhase");
                local v37 = v35 and v32:GetAttribute("LocalMeleeDirection") or v32:GetAttribute("ReachDirection");
                local v38 = u9[v32:GetAttribute("ReachTargetUserId")];
                local v39 = v38 and v38.Character and v38.Character:FindFirstChild("HumanoidRootPart");

                if v36 == "Tracking" and v39 then
                    v37 = v39.Position - HumanoidRootPart.Position;
                end;

                local v40 = 0;

                if v32:GetAttribute("DaggerState") == "Held" and not (v32:GetAttribute("TackleActive") or (v32:GetAttribute("MovementLocked") or v36 ~= "Tracking" and (v36 ~= "Windup" and v36 ~= "Active"))) and typeof(v37) == "Vector3" then
                    local v41 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1);
                    local v42 = v37 * Vector3.new(1, 0, 1);

                    if v41.Magnitude > 0.01 and v42.Magnitude > 0.01 then
                        local Y = v41:Cross(v42).Y;
                        local v43 = v41:Dot(v42);
                        local math_atan2_ret = math.atan2(Y, v43);
                        local v44 = -math.rad(DaggerConfig.AimLimit);
                        local math_rad_ret = math.rad(DaggerConfig.AimLimit);
                        v40 = math.clamp(math_atan2_ret, v44, math_rad_ret);
                    end;
                end;

                local yaw = v31.yaw;
                local v45 = v40 - v31.yaw;
                local v46 = -DaggerConfig.AimRate * math.min(p18, 0.1);
                v31.yaw = yaw + v45 * (1 - math.exp(v46));

                if math.abs(v31.yaw) > 0.001 then
                    local arm = v31.joints.arm;
                    arm.base = arm.motor.Transform;
                    local v47 = v31.torso.CFrame:VectorToObjectSpace(Vector3.new(0, 1, 0));
                    local Rotation = arm.motor.C0.Rotation;
                    arm.applied = Rotation:Inverse() * CFrame.fromAxisAngle(v47, v31.yaw) * Rotation * arm.base;
                    arm.motor.Transform = arm.applied;
                end;
            else
                ScythePose.restore(v.scythe);
            end;
        else
            restore(v);
            ScythePose.restore(v.scythe);

            if v.animationPlayed then
                v.animationPlayed:Disconnect();
            end;

            u8[i] = nil;
        end;
    end;
end));
script.Destroying:Connect(function() -- Line: 202
    -- upvalues: u10 (copy), u8 (copy), restore (copy), ScythePose (copy)
    for _, v in u10 do
        v:Disconnect();
    end;

    for i, v in u8 do
        restore(v);
        ScythePose.restore(v.scythe);

        if v.animationPlayed then
            v.animationPlayed:Disconnect();
        end;

        u8[i] = nil;
    end;
end);