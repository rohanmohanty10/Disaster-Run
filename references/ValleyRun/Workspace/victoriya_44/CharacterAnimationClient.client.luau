 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local script_Parent = script.Parent;
local Humanoid = script_Parent:WaitForChild("Humanoid");
local HumanoidRootPart = script_Parent:WaitForChild("HumanoidRootPart");

if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
    return;
end;

if require(game.ReplicatedFirst:WaitForChild("FFlags")).LocalLocomotion then
    local Animate = script_Parent:WaitForChild("Animate", 5);

    if Animate then
        Animate.Enabled = false;
    end;

    local Animator = Humanoid:WaitForChild("Animator", 5);

    if Animator then
        for _, v in Animator:GetPlayingAnimationTracks() do
            if v.Priority == Enum.AnimationPriority.Core then
                v:Stop(0);
            end;
        end;
    end;

    return;
end;

local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Animation = ChickenOrHero:WaitForChild("Animation");
local AnimationConfig = require(Animation.AnimationConfig);
local AnimationPolicy = require(Animation.AnimationPolicy);
local StopAnimationPolicy = require(Animation:WaitForChild("StopAnimationPolicy"));
local DashAnimation = require(Animation:WaitForChild("DashAnimation"));
require(Animation:WaitForChild("DashAnimationPolicy"));
local u1 = StopAnimationPolicy.new();
local MovementProfiles = require(ChickenOrHero.Movement:WaitForChild("MovementProfiles"));
local u2 = require(Animation.AnimationLibrary).prepare();

if not (u2.Idle and (u2.Walk and u2.Run)) then
    return;
end;

local v3 = Humanoid:FindFirstChildOfClass("Animator");

while not (v3 or (not script_Parent.Parent or Humanoid.Health <= 0)) do
    task.wait(0.1);
    v3 = Humanoid:FindFirstChildOfClass("Animator");
end;

if not (v3 and script_Parent.Parent) then
    return;
end;

DashAnimation.prepare(script_Parent);
local u4 = script_Parent:GetAttribute("DashAnimationSequence") or 0;
local LocomotionTracks = require(Animation:WaitForChild("LocomotionTracks"));
local u5 = LocomotionTracks.new(v3, u2);
local tracks = u5.tracks;
local u6 = {};
local u7 = true;
local u8 = {
    Stop = true,
    Land = true
};
u5:refresh(os.clock());
script_Parent:SetAttribute("AnimationPackActive", nil);
script_Parent:SetAttribute("AnimationPackLoading", true);
local u9 = 0;
local u10 = {};
local u11 = true;
local u12 = 0;
local u13 = nil;
local u14 = 0;
local Attribute = script_Parent:GetAttribute("MovementReset");

local function endAction() -- Line: 53
    -- upvalues: u13 (ref), tracks (copy), AnimationConfig (copy), script_Parent (copy)
    if u13 and tracks[u13] then
        tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
    end;

    u13 = nil;
    script_Parent:SetAttribute("AnimationAction", nil);
end;

local function startAction(p15, p16, p17, p18) -- Line: 57
    -- upvalues: tracks (copy), LocomotionTracks (copy), u13 (ref), AnimationConfig (copy), script_Parent (copy), u14 (ref)
    local v19 = tracks[p15];

    if not LocomotionTracks.ready(v19) then
        return;
    end;

    if u13 and tracks[u13] then
        tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
    end;

    u13 = nil;
    script_Parent:SetAttribute("AnimationAction", nil);
    u13 = p15;
    u14 = os.clock() + p16;
    script_Parent:SetAttribute("AnimationAction", p15);
    v19:Play(p15 == "Stop" and (AnimationConfig.Stop.FadeIn or 0.07) or 0.07, p18 or 1, (p17 or v19.Length) / math.max(p16, 0.05));
    v19.TimePosition = 0;
end;

local function cleanup() -- Line: 63
    -- upvalues: u7 (ref), DashAnimation (copy), script_Parent (copy), u6 (copy), u5 (copy)
    if not u7 then
        return;
    end;

    u7 = false;
    DashAnimation.release(script_Parent);

    for _, v in u6 do
        v:Disconnect();
    end;

    u5:destroy();
    script_Parent:SetAttribute("AnimationPackActive", nil);
    script_Parent:SetAttribute("AnimationPackLoading", nil);
    script_Parent:SetAttribute("AnimationAction", nil);
end;

table.insert(u6, Humanoid.Died:Connect(cleanup));
table.insert(u6, script.Destroying:Connect(cleanup));
table.insert(u6, RunService.PreAnimation:Connect(function(p20) -- Line: 72
    -- upvalues: u7 (ref), HumanoidRootPart (copy), u5 (copy), script_Parent (copy), MovementProfiles (copy), Players (copy), Humanoid (copy), Attribute (ref), u13 (ref), tracks (copy), AnimationConfig (copy), DashAnimation (copy), u4 (ref), u1 (ref), StopAnimationPolicy (copy), u12 (ref), u11 (ref), AnimationPolicy (copy), startAction (copy), u14 (ref), u2 (copy), u9 (ref), u8 (copy), LocomotionTracks (copy), u10 (copy)
    if not (u7 and HumanoidRootPart.Parent) then
        return;
    end;

    local math_min_ret = math.min(p20, 0.1);
    u5:refresh(os.clock());
    local v21 = u5:coreReady();

    if script_Parent:GetAttribute("AnimationPackActive") ~= v21 then
        script_Parent:SetAttribute("AnimationPackActive", v21);
    end;

    if script_Parent:GetAttribute("AnimationPackLoading") == v21 then
        script_Parent:SetAttribute("AnimationPackLoading", not v21);
    end;

    local v22 = MovementProfiles.get(Players.LocalPlayer:GetAttribute("GameRole"), Players.LocalPlayer);
    local Magnitude = (HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude;
    local v23 = Humanoid.FloorMaterial ~= Enum.Material.Air;
    local v24 = script_Parent:GetAttribute("MovementState") or "Idle";
    local v25 = HumanoidRootPart.Anchored or script_Parent:GetAttribute("MovementLocked") == true;
    local v26 = script_Parent:GetAttribute("TackleActive") == true;
    local v27;

    if Players.LocalPlayer:GetAttribute("GameRole") == "Runner" then
        v27 = Players.LocalPlayer:GetAttribute("RunState") == "Caught";
    else
        v27 = false;
    end;

    local Attribute2 = script_Parent:GetAttribute("MovementReset");

    if Attribute2 ~= Attribute then
        Attribute = Attribute2;

        if u13 and tracks[u13] then
            tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        u13 = nil;
        script_Parent:SetAttribute("AnimationAction", nil);
        DashAnimation.stop(script_Parent);
        u4 = script_Parent:GetAttribute("DashAnimationSequence") or 0;
        u1 = StopAnimationPolicy.new();
        u12 = 0;
        u11 = v23;
    end;

    local v28 = script_Parent:GetAttribute("DashAnimationSequence") or 0;
    local v29 = v23 and not v25 and not (v26 or v27 or (Humanoid.Sit or Humanoid.PlatformStand)) and v22.Dash.Enabled;

    if not v29 then
        DashAnimation.stop(script_Parent);
    end;

    if v28 ~= u4 then
        u4 = v28;

        if v29 and (v24 == "Boosting" or v24 == "Dashing") then
            if u13 and tracks[u13] then
                tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
            end;

            u13 = nil;
            script_Parent:SetAttribute("AnimationAction", nil);
            DashAnimation.play(script_Parent, script_Parent:GetAttribute("DashFromDirection"), script_Parent:GetAttribute("DashToDirection"), v22.Dash);
        end;
    end;

    local v30 = DashAnimation.isActive(script_Parent);
    local v31 = AnimationPolicy.angle(HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1), HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1));
    local step = StopAnimationPolicy.step;
    local v32 = {
        mode = v24,
        speed = Magnitude,
        entrySpeed = script_Parent:GetAttribute("MovementStopEntrySpeed"),
        angle = v31
    };
    v32.allowed = v21 and not v30 and (v23 and not (v25 or v26 or (v27 or Humanoid.Sit))) and not Humanoid.PlatformStand;
    v32.clipLength = tracks.Stop and tracks.Stop.Length or 0;
    v32.now = os.clock();
    local v33 = step(u1, v32, math_min_ret, AnimationConfig.Stop, v22);
    local v34;

    if script_Parent:GetAttribute("Ragdolled") or (not v21 or (Humanoid.Sit or Humanoid.PlatformStand)) then
        v34 = {};

        if u13 and tracks[u13] then
            tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        u13 = nil;
        script_Parent:SetAttribute("AnimationAction", nil);
    elseif v26 then
        v34 = {
            Idle = 1
        };

        if u13 and tracks[u13] then
            tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        u13 = nil;
        script_Parent:SetAttribute("AnimationAction", nil);
    elseif v27 then
        v34 = tracks.CaughtIdle and (tracks.CaughtIdle.Length > 0 and {
            CaughtIdle = 1
        }) or {
            Idle = 1
        };

        if u13 and tracks[u13] then
            tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        u13 = nil;
        script_Parent:SetAttribute("AnimationAction", nil);
        u12 = 0;
    elseif v25 then
        v34 = {
            Idle = 1
        };

        if u13 and tracks[u13] then
            tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        u13 = nil;
        script_Parent:SetAttribute("AnimationAction", nil);
    elseif v23 then
        v34 = AnimationPolicy.weights(Magnitude, v31, v22.MaxSpeed, AnimationConfig);

        if v30 then
            if u13 and tracks[u13] then
                tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
            end;

            u13 = nil;
            script_Parent:SetAttribute("AnimationAction", nil);
        elseif u11 or (u12 <= 0.15 or v26) then
            if v33 then
                startAction("Stop", v33.duration, v33.clipEnd, v33.weight);
            end;
        else
            startAction("Land", 0.25);
        end;

        u12 = 0;
    else
        u12 = u12 + math_min_ret;
        v34 = {
            Fall = 1
        };

        if u13 and tracks[u13] then
            tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        u13 = nil;
        script_Parent:SetAttribute("AnimationAction", nil);
    end;

    if u13 and (u14 <= os.clock() or (v26 or u13 == "Stop" and (v24 ~= "Braking" and v24 ~= "Idle"))) then
        if u13 and tracks[u13] then
            tracks[u13]:Stop(u13 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        u13 = nil;
        script_Parent:SetAttribute("AnimationAction", nil);
    end;

    local v35 = u5:weights(v34);
    local math_clamp_ret = math.clamp((Magnitude / v22.MaxSpeed - AnimationConfig.RunBlendStart) / (AnimationConfig.RunBlendEnd - AnimationConfig.RunBlendStart), 0, 1);
    local v36 = Magnitude / math.max(AnimationConfig.WalkReferenceSpeed * (1 - math_clamp_ret) + AnimationConfig.RunReferenceSpeed * u2.Run.length * math_clamp_ret, 1);
    local math_clamp_ret2 = math.clamp(v36, 0.25, 3);
    u9 = (u9 + math_clamp_ret2 * math_min_ret) % 1;

    for i, v in tracks do
        if not u8[i] and LocomotionTracks.ready(v) then
            local v37 = v35[i] or 0;
            local v38 = i == "CaughtIdle" and AnimationConfig.CaughtIdle.FadeTime or AnimationConfig.FadeTime;
            local v39;

            if i == "CaughtIdle" then
                v39 = AnimationConfig.CaughtIdle.PlaybackRate;
            elseif i == "Idle" or i == "Fall" then
                v39 = 1;
            elseif i == "Walk" or i == "Run" then
                v39 = math_clamp_ret2 * math.max(v.Length, 0.1);
            else
                v39 = math.clamp(Magnitude / AnimationConfig.DirectionalReferenceSpeed, 0.5, 2.2);
            end;

            if v37 > 0.001 then
                if v.IsPlaying and v.WeightTarget > 0.001 then
                    if math.abs(v.WeightTarget - v37) > 0.05 then
                        v:AdjustWeight(v37, v38);
                    end;

                    if math.abs(v.Speed - v39) > v39 * 0.05 then
                        v:AdjustSpeed(v39);
                    end;
                else
                    v:Play(v38, v37, v39);

                    if i ~= "Idle" and (i ~= "Fall" and i ~= "CaughtIdle") then
                        v.TimePosition = u9 * v.Length;
                    end;
                end;

                u10[i] = v37;
            else
                if v.IsPlaying and v.WeightTarget > 0.001 then
                    v:Stop(v38);
                end;

                u10[i] = 0;
            end;
        end;
    end;

    u11 = v23;
end));