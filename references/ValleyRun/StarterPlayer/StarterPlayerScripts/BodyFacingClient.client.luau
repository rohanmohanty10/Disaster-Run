 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ParticipantDirectory = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("ParticipantDirectory"));
local Movement = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Movement");
local BodyFacingConfig = require(Movement:WaitForChild("BodyFacingConfig"));
local BodyFacingModel = require(Movement:WaitForChild("BodyFacingModel"));
local AnimationPolicy = require(game.ReplicatedStorage.ChickenOrHero:WaitForChild("Animation"):WaitForChild("AnimationPolicy"));
local v1 = require(game.ReplicatedStorage.ChickenOrHero.Animation.AnimationLibrary).prepare();
local u2 = v1.Stop and v1.Stop.animation.AnimationId;
local u3 = {};

for _, v in { "Idle", "Walk", "Run", "Left", "Right", "Back" } do
    local v4 = v1[v];

    if v4 then
        u3[v4.animation.AnimationId] = true;
    end;
end;

local DashAnimationPolicy = require(game.ReplicatedStorage.ChickenOrHero.Animation:WaitForChild("DashAnimationPolicy"));
local LocalLocomotion = require(game.ReplicatedStorage.ChickenOrHero.Animation:WaitForChild("LocalLocomotion"));

local function locomotionAnimator(p5, p6) -- Line: 20
    -- upvalues: LocalLocomotion (copy)
    return LocalLocomotion.animatorFor(p5) or p6:FindFirstChildOfClass("Animator");
end;

local u7 = {};

for i, v in v1 do
    if DashAnimationPolicy.isName(i) then
        u7[v.animation.AnimationId] = true;
    end;
end;

local u8 = {};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = 1;

local function restore(p13) -- Line: 28
    for _, v in p13.joints do
        if v.motor.Parent and (v.applied and v.motor.Transform == v.applied) then
            v.motor.Transform = v.base;
        end;

        v.applied = nil;
    end;
end;

local function record(p14) -- Line: 40
    -- upvalues: u8 (copy), restore (copy)
    local Character = p14.Character;
    local v15 = u8[p14.UserId];

    if v15 and (v15.character == Character and Character:IsDescendantOf(workspace)) then
        local v16;

        if v15.humanoid.Parent == Character then
            v16 = v15.root.Parent == Character;
        else
            v16 = false;
        end;

        for _, v in v15.joints do
            if v16 then
                v16 = v.motor:IsDescendantOf(Character);
            end;
        end;

        if v16 then
            return v15;
        end;
    end;

    local v17 = type(p14) == "number" and p14 and p14 or p14.UserId;
    local v18 = u8[v17];

    if v18 then
        restore(v18);
        u8[v17] = nil;
    end;

    if not (Character and Character:IsDescendantOf(workspace)) then
        return;
    end;

    local v19 = Character:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Torso = Character:FindFirstChild("Torso");

    if not (v19 and (v19.RigType == Enum.HumanoidRigType.R6 and (HumanoidRootPart and Torso))) then
        return;
    end;

    local RootJoint = HumanoidRootPart:FindFirstChild("RootJoint");
    local Neck = Torso:FindFirstChild("Neck");
    local v20 = Torso:FindFirstChild("Left Hip");
    local v21 = Torso:FindFirstChild("Right Hip");

    if RootJoint and (Neck and (v20 and v21)) then
        local v22 = {
            character = Character,
            humanoid = v19,
            root = HumanoidRootPart,
            state = {},
            joints = {},
            version = Character:GetAttribute("MovementReset")
        };

        for i, v in {
            torso = RootJoint,
            head = Neck,
            left = v20,
            right = v21
        } do
            v22.joints[i] = {
                motor = v,
                base = v.Transform
            };
        end;

        u8[p14.UserId] = v22;

        return v22;
    end;
end;

local function overlay(p23, p24) -- Line: 65
    local motor = p23.motor;
    p23.base = motor.Transform;
    local Rotation = motor.C0.Rotation;
    motor.Transform = Rotation:Inverse() * p24 * Rotation * p23.base;
    p23.applied = motor.Transform;
end;

table.insert(u9, Players.PlayerRemoving:Connect(function(p25) -- Line: 35, Name: remove
    -- upvalues: u8 (copy), restore (copy)
    local v26 = type(p25) == "number" and p25 and p25 or p25.UserId;
    local v27 = u8[v26];

    if v27 then
        restore(v27);
        u8[v26] = nil;
    end;
end));
table.insert(u9, RunService.PreAnimation:Connect(function() -- Line: 74
    -- upvalues: u8 (copy), restore (copy)
    for _, v in u8 do
        restore(v);
    end;
end));
table.insert(u9, RunService.PreSimulation:Connect(function(p28) -- Line: 77
    -- upvalues: LocalLocomotion (copy), u12 (ref), u10 (copy), u11 (copy), ParticipantDirectory (copy), u8 (copy), restore (copy), record (copy), BodyFacingConfig (copy), LocalPlayer (copy), u3 (copy), u2 (copy), AnimationPolicy (copy), BodyFacingModel (copy), u7 (copy), DashAnimationPolicy (copy)
    if LocalLocomotion.enabled then
        LocalLocomotion.copy();
    end;

    u12 = u12 + p28;

    if u12 >= 0.1 then
        u12 = 0;
        table.clear(u10);
        table.clear(u11);

        for _, v in ParticipantDirectory.list() do
            if type(v.UserId) == "number" then
                table.insert(u10, v);
                u11[v.UserId] = v;
            end;
        end;

        for i, v in u8 do
            if not (u11[i] and v.character:IsDescendantOf(workspace)) then
                local v29 = type(i) == "number" and i and i or i.UserId;
                local v30 = u8[v29];

                if v30 then
                    restore(v30);
                    u8[v29] = nil;
                end;
            end;
        end;
    end;

    for _, v in u10 do
        local v31 = record(v);

        if v31 then
            restore(v31);
            local character = v31.character;
            local humanoid = v31.humanoid;
            local root = v31.root;
            local v32;

            if type(v) == "table" then
                v32 = v.IsBot and v:GetAttribute("GameRole") ~= "Catcher";
            else
                v32 = false;
            end;

            local v33 = character:GetAttribute("ClientBot") == true;
            local v34 = v32 or not BodyFacingConfig.Enabled;

            if not v34 then
                if humanoid.Health <= 0 then
                    v34 = true;
                else
                    v34 = humanoid.Sit or not v33 and (humanoid.PlatformStand or root.Anchored);

                    if not v34 then
                        if character:GetAttribute("MovementLocked") == true or character:GetAttribute("TackleActive") == true then
                            v34 = true;
                        elseif v == LocalPlayer then
                            v34 = v:GetAttribute("ReleaseCameraForUI") == true and true or game.GuiService.MenuIsOpen;
                        else
                            v34 = false;
                        end;
                    end;
                end;
            end;

            local Attribute = character:GetAttribute("MovementReset");

            if v34 or Attribute ~= v31.version then
                v31.state = {};
                v31.lastTravel = nil;
                v31.gazePitch = nil;
                v31.version = Attribute;
            end;

            if not v34 then
                local v35 = root.CFrame.LookVector * Vector3.new(1, 0, 1);

                if v35.Magnitude >= 0.001 then
                    local v36 = (LocalLocomotion.velocityFor(character) or root.AssemblyLinearVelocity) * Vector3.new(1, 0, 1);
                    local v37;

                    if v == LocalPlayer and workspace.CurrentCamera then
                        local math_clamp_ret = math.clamp(workspace.CurrentCamera.CFrame.LookVector.Y, -1, 1);
                        v37 = math.asin(math_clamp_ret);
                    else
                        v37 = 0;
                    end;

                    if type(v) == "table" and v.IsBot then
                        local Attribute2 = character:GetAttribute("ReachPhase");
                        local v38;

                        if Attribute2 == "Windup" or Attribute2 == "Active" then
                            v38 = false;
                        else
                            v38 = u11[character:GetAttribute("BotPursuitTarget")];
                        end;

                        local v39;

                        if v38 then
                            v39 = v38.Character;
                        else
                            v39 = v38;
                        end;

                        if v39 then
                            v39 = v39:FindFirstChild("Head") or v39:FindFirstChild("HumanoidRootPart");
                        end;

                        local Head = character:FindFirstChild("Head");
                        local v40;

                        if v39 and (Head and v38:GetAttribute("RunState") == "Active") then
                            local v41 = v39.Position - Head.Position;
                            v40 = math.atan2(v41.Y, (v41 * Vector3.new(1, 0, 1)).Magnitude);
                        else
                            v40 = 0;
                        end;

                        local v42 = v31.gazePitch or 0;
                        local v43 = v40 - (v31.gazePitch or 0);
                        local v44 = -BodyFacingConfig.BodyFollowRate * math.min(p28, 0.1);
                        v31.gazePitch = v42 + v43 * (1 - math.exp(v44));
                        v37 = v31.gazePitch;
                    end;

                    local v45 = nil;
                    local v46;

                    if v == LocalPlayer then
                        v46 = character:GetAttribute("AnimationPackActive") == true;
                    else
                        v46 = false;
                    end;

                    local v47;

                    if v == LocalPlayer then
                        v47 = v;
                    else
                        local v48 = LocalLocomotion.animatorFor(character) or humanoid:FindFirstChildOfClass("Animator");

                        if v48 then
                            v45 = v48:GetPlayingAnimationTracks();
                            v47 = v;

                            for _, v2 in v45 do
                                if v2.Animation and (u3[v2.Animation.AnimationId] and v2.WeightCurrent > 0.01) then
                                    v46 = true;
                                    break;
                                end;
                            end;
                        else
                            v47 = v;
                        end;
                    end;

                    local v49 = character:GetAttribute("AnimationAction") == "Stop";

                    if v46 and v47 ~= LocalPlayer then
                        for _, v2 in v45 or {} do
                            if (v2.Name == "CoH_Stop" or u2 and v2.Animation.AnimationId == u2) and v2.WeightCurrent > 0.05 then
                                v49 = true;
                                break;
                            end;
                        end;
                    end;

                    if v49 and v31.lastTravel then
                        v36 = v31.lastTravel;
                    elseif v36.Magnitude >= BodyFacingConfig.MovementThreshold then
                        v31.lastTravel = v36;
                    end;

                    local v50 = v46 and (AnimationPolicy.poseScale(AnimationPolicy.angle(v36, v35)) or 1) or 1;
                    local v51 = BodyFacingModel.step(v31.state, v36, v35.Unit, v37, p28, BodyFacingConfig);
                    v51.torso = v51.torso * v50;
                    v51.hip = v51.hip * v50;
                    v51.head = v51.head * v50;
                    local Attribute2 = character:GetAttribute("DashVisualFacing");

                    if typeof(Attribute2) == "Vector3" and Attribute2.Magnitude > 0.01 then
                        local v52 = LocalLocomotion.animatorFor(character) or humanoid:FindFirstChildOfClass("Animator");
                        local v53 = 0;

                        if v52 then
                            for _, v2 in v52:GetPlayingAnimationTracks() do
                                if v2.Animation and u7[v2.Animation.AnimationId] then
                                    v53 = math.max(v53, v2.WeightCurrent);
                                end;
                            end;
                        end;

                        if v53 > 0 then
                            local math_clamp_ret = math.clamp(v53, 0, 1);
                            local v54 = DashAnimationPolicy.yaw(v35.Unit, Attribute2);
                            local math_sin_ret = math.sin(v54 - v51.torso);
                            local math_cos_ret = math.cos(v54 - v51.torso);
                            local math_atan2_ret = math.atan2(math_sin_ret, math_cos_ret);
                            v51.torso = v51.torso + math_atan2_ret * math_clamp_ret;
                            v51.hip = v51.hip * (1 - math_clamp_ret);
                            v51.head = v51.head * (1 - math_clamp_ret);
                            v51.pitch = v51.pitch * (1 - math_clamp_ret);
                        end;
                    end;

                    local torso = v31.joints.torso;
                    local CFrame_Angles_ret = CFrame.Angles(0, v51.torso, 0);
                    local motor = torso.motor;
                    torso.base = motor.Transform;
                    local Rotation = motor.C0.Rotation;
                    motor.Transform = Rotation:Inverse() * CFrame_Angles_ret * Rotation * torso.base;
                    torso.applied = motor.Transform;
                    local motor2 = v31.joints.torso.motor;
                    local v55 = motor2.C0 * motor2.Transform * motor2.C1:Inverse();
                    local v56 = v55:VectorToObjectSpace(Vector3.new(0, 1, 0));
                    local v57 = v55:VectorToObjectSpace(Vector3.new(1, 0, 0));
                    local head = v31.joints.head;
                    local v58 = CFrame.fromAxisAngle(v56, v51.head) * CFrame.fromAxisAngle(v57, v51.pitch);
                    local motor3 = head.motor;
                    head.base = motor3.Transform;
                    local Rotation2 = motor3.C0.Rotation;
                    motor3.Transform = Rotation2:Inverse() * v58 * Rotation2 * head.base;
                    head.applied = motor3.Transform;
                    local left = v31.joints.left;
                    local CFrame_fromAxisAngle_ret = CFrame.fromAxisAngle(v56, v51.hip);
                    local motor4 = left.motor;
                    left.base = motor4.Transform;
                    local Rotation3 = motor4.C0.Rotation;
                    motor4.Transform = Rotation3:Inverse() * CFrame_fromAxisAngle_ret * Rotation3 * left.base;
                    left.applied = motor4.Transform;
                    local right = v31.joints.right;
                    local CFrame_fromAxisAngle_ret2 = CFrame.fromAxisAngle(v56, v51.hip);
                    local motor5 = right.motor;
                    right.base = motor5.Transform;
                    local Rotation4 = motor5.C0.Rotation;
                    motor5.Transform = Rotation4:Inverse() * CFrame_fromAxisAngle_ret2 * Rotation4 * right.base;
                    right.applied = motor5.Transform;

                    if v47 == LocalPlayer then
                        character:SetAttribute("FacingTravelAngle", v51.angle);
                        character:SetAttribute("FacingGait", v51.gait);
                        character:SetAttribute("FacingTorsoYaw", (math.deg(v51.torso)));
                    end;
                end;
            end;
        end;
    end;
end));
script.Destroying:Connect(function() -- Line: 181
    -- upvalues: u9 (copy), u8 (copy), restore (copy), u10 (copy), u11 (copy)
    for _, v in u9 do
        v:Disconnect();
    end;

    for _, v in u8 do
        restore(v);
    end;

    table.clear(u8);
    table.clear(u10);
    table.clear(u11);
end);