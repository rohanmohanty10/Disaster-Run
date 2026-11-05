  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"));
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = {};
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

function u1.GetAnimations(p3) -- Line: 24
    -- upvalues: LocalPlayer (copy)
    local v4 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local Humanoid = v4.Humanoid;

    if v4 and Humanoid then
        local v5 = {};

        for _, v in Humanoid:GetPlayingAnimationTracks() do
            local v6 = script:FindFirstChild(v.Name);

            if v6 and string.match(v6.AnimationId, "%d+$") == string.match(v.Animation.AnimationId, "%d+$") then
                v5[v.Name] = v;
            end;
        end;

        for _, child in script:GetChildren() do
            local Name = child.Name;

            if not v5[Name] then
                v5[Name] = Humanoid:LoadAnimation(child);
                v5[Name]:Play();
                v5[Name]:AdjustWeight(Name == "Idle" and 1 or 0.0001);
            end;
        end;

        return v5;
    end;
end;

function u1.ValidateLedge(p7, p8) -- Line: 59
    -- upvalues: u2 (copy)
    return not workspace:Raycast(p8.Position + Vector3.new(0, -1, 0) + p8.LookVector * 1, p8.UpVector * 3, u2);
end;

function u1.DetectLedge(p9, p10, p11) -- Line: 63
    -- upvalues: LocalPlayer (copy), u2 (copy), u1 (copy)
    local v12 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local Humanoid = v12.Humanoid;
    local HumanoidRootPart = v12.HumanoidRootPart;
    local Head = v12.Head;

    if p11 or (Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping) then
        if v12 and not v12:GetAttribute("Vaulting") then
            local v13 = p10 or workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * 6, u2);

            if not (v13 and (v13.Instance and v13.Position)) then
                return;
            end;

            local v14 = v13.Normal:Dot(Vector3.new(0, 1, 0));

            if math.abs(v14) >= 0.75 then
                return;
            end;

            local v15 = v13.Instance.CFrame:PointToObjectSpace(v13.Position);
            local v16 = Vector3.new(v15.X, v13.Instance.Size.Y / 2, v15.Z);
            local v17 = v13.Instance.CFrame:PointToWorldSpace(v16);
            local v18 = CFrame.lookAt(v17, v17 - v13.Normal);

            if p11 or (v17 - Head.Position).Magnitude <= 4 and u1:ValidateLedge(v18) then
                return u1:BeginVault(v18);
            end;
        end;

        return false;
    end;
end;

function u1.BeginVault(p19, p20) -- Line: 99
    -- upvalues: LocalPlayer (copy), Trove (copy), u1 (copy), RunService (copy)
    local u21 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local Humanoid = u21.Humanoid;
    local HumanoidRootPart = u21.HumanoidRootPart;

    if u21 and (HumanoidRootPart and Humanoid) then
        u21:SetAttribute("Vaulting", true);
        local u22 = Trove.new();
        u22:AttachToInstance(u21);
        local v23 = u22:Construct(Instance, "Part");
        v23.Anchored = true;
        v23.Size = Vector3.new(1, 1, 1);
        v23.CFrame = p20 + Vector3.new(0, -2, 0) - p20.LookVector;
        v23.CanQuery = false;
        v23.CanCollide = false;
        v23.CanTouch = false;
        v23.Transparency = 1;
        v23.Parent = workspace.Effects;
        local v24 = u22:Construct(Instance, "Attachment");
        v24.Parent = v23;
        local v25 = u22:Construct(Instance, "Attachment");
        v25.Parent = HumanoidRootPart;
        local v26 = u22:Construct(Instance, "AlignPosition");
        v26.ApplyAtCenterOfMass = true;
        v26.Responsiveness = 50;
        v26.MaxForce = 1000000;
        v26.Attachment0 = v25;
        v26.Attachment1 = v24;
        v26.Parent = v25;
        local v27 = u22:Construct(Instance, "AlignOrientation");
        v27.Responsiveness = 50;
        v27.MaxTorque = 1000000;
        v27.Attachment0 = v25;
        v27.Attachment1 = v24;
        v27.Parent = v25;
        u1:SidewaysVaultSetup(u22, v23);
        u22:Connect(RunService.RenderStepped, function(p28) -- Line: 145
            -- upvalues: HumanoidRootPart (copy), Humanoid (copy)
            HumanoidRootPart.Anchored = false;
            Humanoid.AutoRotate = false;
        end);
        u22:Add(function() -- Line: 152
            -- upvalues: u21 (copy), HumanoidRootPart (copy), Humanoid (copy)
            u21:SetAttribute("Vaulting", false);
            HumanoidRootPart.Anchored = false;
            Humanoid.AutoRotate = true;
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
        end);
        task.delay(0.25, function() -- Line: 161
            -- upvalues: u21 (copy), u22 (copy), Humanoid (copy)
            if u21 and (u21:IsDescendantOf(game) and u21:GetAttribute("Vaulting")) then
                u22:Connect(Humanoid.Changed, function(p29) -- Line: 163
                    -- upvalues: Humanoid (ref), u22 (ref)
                    if p29 == "Jump" and Humanoid.Jump == true then
                        u22:Destroy();
                    end;
                end);
            end;
        end);

        return u22;
    end;
end;

function u1.SidewaysVaultSetup(p30, p31, u32) -- Line: 173
    -- upvalues: LocalPlayer (copy), u1 (copy), RunService (copy), CurrentCamera (copy)
    local v33 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local Humanoid = v33.Humanoid;

    if v33 and (v33.HumanoidRootPart and Humanoid) then
        local u34 = u1:GetAnimations();
        p31:Add(function() -- Line: 180
            -- upvalues: u34 (copy)
            for _, v in u34 do
                v:AdjustWeight(0.0001);
            end;
        end);
        p31:Connect(RunService.RenderStepped, function(p35) -- Line: 186
            -- upvalues: Humanoid (copy), CurrentCamera (ref), u1 (ref), u32 (copy), u34 (copy)
            local v36 = p35 * 60;
            local v37 = 0;

            if Humanoid.MoveDirection:Dot(CurrentCamera.CFrame.RightVector) > 0.7 then
                u1:DirectionalMovement(4 * v36, u32);
                v37 = 1;
            elseif Humanoid.MoveDirection:Dot(-CurrentCamera.CFrame.RightVector) > 0.7 then
                u1:DirectionalMovement(-4 * v36, u32);
                v37 = -1;
            end;

            local v38 = v37 == 0 and "Idle" or (v37 < 0 and "Left" or (v37 > 0 and "Right" or false));

            for i, v in u34 do
                v:AdjustWeight(i == v38 and 1 or 0.0001);
            end;
        end);
    end;
end;

function u1.DirectionalMovement(p39, p40, p41) -- Line: 206
    -- upvalues: LocalPlayer (copy), u2 (copy), u1 (copy)
    local v42 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local Head = v42.Head;

    if v42 and Head then
        local v43 = workspace:Raycast(Head.Position, Head.CFrame.RightVector * p40 + Head.CFrame.LookVector * 8, u2);

        if v43 and v43.Instance then
            u1:MovementStep(v43, p41);

            return;
        end;

        local v44 = workspace:Raycast(Head.Position + Vector3.new(0, -1, 0) + Head.CFrame.RightVector * p40, Head.CFrame.RightVector * -p40 + Head.CFrame.LookVector * 2, u2);

        if v44 and v44.Instance then
            u1:MovementStep(v44, p41);
        end;
    end;
end;

function u1.MovementStep(p45, p46, p47) -- Line: 223
    -- upvalues: LocalPlayer (copy), u1 (copy)
    local v48 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local Head = v48.Head;

    if v48 and Head then
        local v49 = p46.Instance.CFrame:PointToObjectSpace(p46.Position);
        local v50 = Vector3.new(v49.X, p46.Instance.Size.Y / 2, v49.Z);
        local v51 = p46.Instance.CFrame:PointToWorldSpace(v50);
        local v52 = CFrame.lookAt(v51, v51 - p46.Normal);

        if u1:ValidateLedge(v52) and (v51 - Head.Position).Magnitude < 3.5 then
            p47.CFrame = v52 - Vector3.new(0, 2, 0) - v52.LookVector;
        end;
    end;
end;

return u1;