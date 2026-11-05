  

 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u2 = {};

function u2.StateChanged(p3, p4, p5) -- Line: 26
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), u2 (copy), EffectsHandler (copy), TweenService (copy), CurrentCamera (copy)
    if p4 == "Gliding" then
        if p5.Sounds.Cape then
            p5.Sounds.Cape:Play();
        end;
    elseif p4 == "Diving" then
        task.spawn(function() -- Line: 32
            -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref), u2 (ref), EffectsHandler (ref), TweenService (ref), CurrentCamera (ref)
            local u6 = ReplicatedStorage["Client Assets"].Universal.ZoomEffect:Clone();
            u6.Parent = LocalPlayer.PlayerGui;
            local v7 = 1;

            while LocalPlayer:GetAttribute("Diving") do
                local v8 = u2:GetAnimationBlend();
                local v9 = 1 - v8;
                EffectsHandler.CallEffect("Camera Shake", {
                    0.5,
                    22 * v9,
                    0,
                    0.65 * v9,
                    Vector3.new(0.5, 0.5, 0.5),
                    Vector3.new(1, 1, 1)
                });
                TweenService:Create(CurrentCamera, TweenInfo.new(0.05), {
                    FieldOfView = LocalPlayer.Settings.FieldOfView.Value + 20 * v9
                }):Play();
                local u10 = u6:FindFirstChild((tostring(v7)));
                local v11 = TweenService:Create(u10, TweenInfo.new(0.05), {
                    ImageTransparency = 0.25 + v8
                });
                v11.Completed:Connect(function() -- Line: 54
                    -- upvalues: u6 (copy), TweenService (ref), u10 (copy)
                    if u6:IsDescendantOf(game) then
                        TweenService:Create(u10, TweenInfo.new(0.075), {
                            ImageTransparency = 1
                        }):Play();
                    end;
                end);
                v11:Play();
                local v12 = v7 + 1;
                v7 = v12 > 3 and 1 or v12;
                EffectsHandler.Wait(0.05);
            end;

            u6:Destroy();
            TweenService:Create(CurrentCamera, TweenInfo.new(0.25), {
                FieldOfView = LocalPlayer.Settings.FieldOfView.Value
            }):Play();
        end);
    end;
end;

function u2.GetAnimationBlend(p13) -- Line: 79
    -- upvalues: CurrentCamera (copy)
    local v14 = CurrentCamera.CFrame.LookVector:Dot(Vector3.new(0, -1, 0));
    local v15 = math.acos(v14);
    local v16 = (math.deg(v15) - 30) / 30;

    return math.clamp(v16, 0.0001, 0.999);
end;

function u2.OnFloor(p17, p18) -- Line: 88
    -- upvalues: LocalPlayer (copy), u1 (copy)
    local v19 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local HumanoidRootPart = v19.HumanoidRootPart;

    if v19 and HumanoidRootPart then
        return workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -(p18 or 4.5), 0), u1);
    end;
end;

function u2.Step(p20, p21, p22) -- Line: 97
    -- upvalues: CurrentCamera (copy), u2 (copy), LocalPlayer (copy)
    local _ = p22.Character;
    local RootPart = p22.RootPart;
    local LinearVelocity = p22.LinearVelocity;
    local AlignOrientation = p22.AlignOrientation;
    local Animations = p22.Animations;
    local CFrame2 = CurrentCamera.CFrame;
    local LookVector = CFrame2.LookVector;
    p22.Humanoid:ChangeState(Enum.HumanoidStateType.Physics);
    local v23 = u2:GetAnimationBlend();
    Animations.Glide:AdjustWeight(v23);
    Animations.Dive:AdjustWeight(1 - v23);
    local v24 = v23 < 0.75;
    LocalPlayer:SetAttribute("Diving", v24);

    if p22.Diving ~= v24 then
        u2:StateChanged(v24 and "Diving" or "Gliding", p22);
    end;

    p22.Diving = v24;
    local _ = (1 - v23) / 0.75 >= 1;
    local v25 = 0.25 + v23;

    if p22.Sounds.Glide then
        p22.Sounds.Glide.PlaybackSpeed = 2 - v25;
    end;

    if p22.Sounds.Dive then
        p22.Sounds.Dive.Volume = (1 - v25) * 2;
    end;

    local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity;
    local v26 = RootPart.CFrame:VectorToObjectSpace(AssemblyLinearVelocity);
    local v27 = table.pack(RootPart.CFrame:ToObjectSpace(CFrame2):ToEulerAngles(Enum.RotationOrder.YXZ));
    AlignOrientation.CFrame = CFrame.lookAlong(RootPart.Position, LookVector) * CFrame.Angles(0, 0, v27[2]);
    local v28 = math.abs(v26.Z) * 50 + math.abs(v26.Y) * 50;
    local v29 = (math.abs(v26.Z) * 1) ^ 1.06;
    local v30 = math.min(AssemblyLinearVelocity.Y, 0);
    local v31 = v29 + math.abs(v30) * 12.5;
    LinearVelocity.MaxAxesForce = Vector3.new(5000, v28, v31);

    return p22;
end;

function u2.GetAnimations(p32) -- Line: 146
    -- upvalues: LocalPlayer (copy)
    local v33 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local Humanoid = v33.Humanoid;

    if v33 and Humanoid then
        local v34 = {};

        for _, v in Humanoid:GetPlayingAnimationTracks() do
            local v35 = script:FindFirstChild(v.Name);

            if v35 and string.match(v35.AnimationId, "%d+$") == string.match(v.Animation.AnimationId, "%d+$") then
                v34[v.Name] = v;
            end;
        end;

        for _, child in script:GetChildren() do
            local Name = child.Name;

            if not v34[Name] then
                v34[Name] = Humanoid:LoadAnimation(child);
                v34[Name]:Play();
                v34[Name]:AdjustWeight(0.0001);

                if Name == "Dive" then
                    v34[Name]:AdjustSpeed(2.5);
                end;
            end;
        end;

        return v34;
    end;
end;

function u2.BeginGlide(p36) -- Line: 185
    -- upvalues: LocalPlayer (copy), CurrentCamera (copy), Trove (copy), u2 (copy), RunService (copy)
    local u37 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local Humanoid = u37.Humanoid;
    local HumanoidRootPart = u37.HumanoidRootPart;

    if u37 and (Humanoid and (HumanoidRootPart and not u37:GetAttribute("Gliding"))) then
        u37:SetAttribute("Gliding", true);
        CurrentCamera:SetAttribute("HeadOffset", Vector3.new(0, -3.5, 0));
        Humanoid.AutoRotate = false;
        local u38 = Trove.new();
        u38:AttachToInstance(u37);
        u38:Connect(u37:GetAttributeChangedSignal("Gliding"), function() -- Line: 199
            -- upvalues: u37 (copy), u38 (copy)
            if u37:GetAttribute("Gliding") == false then
                u38:Destroy();
            end;
        end);
        local v39 = u38:Construct(Instance, "Attachment");
        v39.Parent = HumanoidRootPart;
        local v40 = u38:Construct(Instance, "LinearVelocity");
        v40.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector;
        v40.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
        v40.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        v40.MaxAxesForce = Vector3.new(5000, 100000, 0);
        v40.Attachment0 = v39;
        v40.VectorVelocity = Vector3.new(0, 0, -50);
        v40.Parent = v39;
        local v41 = u38:Construct(Instance, "AlignOrientation");
        v41.Attachment0 = v39;
        v41.Responsiveness = 8;
        v41.MaxTorque = 1000000;
        v41.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        v41.Parent = v39;
        local u42 = u2:GetAnimations();
        local u43 = {
            Diving = false,
            LinearVelocity = v40,
            AlignOrientation = v41,
            Character = u37,
            Humanoid = Humanoid,
            RootPart = HumanoidRootPart,
            Animations = u42,
            Sounds = {
                Glide = u37:FindFirstChild("Glide Ambience", true),
                Dive = u37:FindFirstChild("Dive Ambience", true),
                Cape = u37:FindFirstChild("Glide Cape Trigger", true)
            }
        };
        local u44 = u37:FindFirstChild("Cape") and u37.Cape.PrimaryPart;

        if u44 then
            u44:SetAttribute("SmartboneDisabled", true);
        end;

        local v45 = u37:FindFirstChild("Glide Startup", true);

        if v45 then
            v45:Play();
        end;

        if u43.Sounds.Glide then
            u43.Sounds.Glide:Play();
        end;

        if u43.Sounds.Dive then
            u43.Sounds.Dive:Play();
        end;

        u38:Add(function() -- Line: 249
            -- upvalues: u37 (copy), LocalPlayer (ref), CurrentCamera (ref), Humanoid (copy), u42 (copy), u43 (ref), u44 (copy)
            u37:SetAttribute("Gliding", false);
            LocalPlayer:SetAttribute("Diving", nil);
            CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;

            if not u37:GetAttribute("Grappling") then
                Humanoid.AutoRotate = true;
                Humanoid:ChangeState(Enum.HumanoidStateType.Freefall);
            end;

            for _, v in u42 do
                v:AdjustWeight(0.0001);
            end;

            if u43.Sounds.Glide then
                u43.Sounds.Glide:Stop();
            end;

            if u43.Sounds.Dive then
                u43.Sounds.Dive:Stop();
            end;

            if u44 then
                u44:SetAttribute("SmartboneDisabled", nil);
            end;

            CurrentCamera:SetAttribute("HeadOffset", nil);
        end);
        u38:Connect(RunService.PreSimulation, function(p46) -- Line: 273
            -- upvalues: u2 (ref), u38 (copy), u43 (ref)
            if u2:OnFloor() then
                u38:Destroy();

                return;
            end;

            u43 = u2:Step(math.min(p46, 0.06666666666666667), u43);
        end);

        return u38;
    end;
end;

function u2.Destroy(p47) -- Line: 288
    -- upvalues: LocalPlayer (copy)
    local v48 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

    if v48 then
        v48:SetAttribute("Gliding", false);
    end;
end;

return u2;