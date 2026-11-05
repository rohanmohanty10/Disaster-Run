  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Signal = require(Knit.Util.Signal);
local LocalPlayer = game.Players.LocalPlayer;
local PlayerModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"));
PlayerModule:GetCameras();
local u1 = PlayerModule:GetControls();
local CurrentCamera = game.Workspace.CurrentCamera;
local Xtal = require(game.ReplicatedStorage:WaitForChild("Xtal"));
local u2 = Knit.CreateController({
    Name = "PilotController",
    ActivePilot = nil,
    ActiveTrove = nil,
    PilotAdded = Signal.new(),
    PilotRemoved = Signal.new()
});

function u2.GetPilot(p3, p4, p5) -- Line: 27
    return game.Workspace.Effects:FindFirstChild(p4.Name .. "_" .. (p5 or "Pilot"));
end;

function u2.Control(p6, u7, p8) -- Line: 31
    -- upvalues: LocalPlayer (copy), u2 (copy), Trove (copy), CurrentCamera (copy), u1 (copy), Xtal (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    u2:Reset();
    local v9 = Trove.new();
    local u10 = p8 or {
        HookWalkSpeed = true,
        HookJumpPower = true,
        HookJump = true,
        HookAutoRotate = true
    };

    local function IsValid() -- Line: 47
        -- upvalues: Character (copy), u10 (copy)
        if not Character then
            return;
        end;

        if not Character:IsDescendantOf(workspace) then
            return;
        end;

        if not u10.Check or u10.Check() then
            return true;
        end;
    end;

    local function IsPilotValid() -- Line: 62
        -- upvalues: u2 (ref), u7 (copy)
        if u2.ActivePilot == u7 then
            return true;
        end;
    end;

    u2.ActivePilot = u7;
    local Humanoid = u7:WaitForChild("Humanoid");
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
    Humanoid.NameDisplayDistance = 0;
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v9:AttachToInstance(u7);
    v9:Add(function() -- Line: 78
        -- upvalues: u2 (ref), u7 (copy), Humanoid (copy)
        if u2.ActivePilot == u7 then
            u2:Reset();
        end;

        if Humanoid then
            Humanoid:Move(Vector3.new(0, 0, 0));
        end;
    end);

    if u10.Radius then
        local v11 = u10.Radius:Clone();
        v11.CFrame = CFrame.new(Character.HumanoidRootPart.Position);
        v11.Parent = workspace.Effects;
        v9:Add(v11);
    end;

    CurrentCamera.CameraSubject = Humanoid;
    u1:OnCharacterAdded(u7);

    function u1.moveFunction(p12, ...) -- Line: 96
        -- upvalues: Humanoid (copy)
        Humanoid:Move(...);
    end;

    Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);

    local function Changed(p13) -- Line: 102
        -- upvalues: u10 (copy), Humanoid (copy), Character (copy)
        if u10.HookWalkSpeed and p13 == nil or p13 == "WalkSpeed" then
            Humanoid.WalkSpeed = Character.Humanoid.WalkSpeed;
        end;

        if u10.HookJumpPower and p13 == nil or p13 == "JumpPower" then
            Humanoid.JumpPower = Character.Humanoid.JumpPower;
        end;

        if u10.HookAutoRotate and p13 == nil or p13 == "AutoRotate" then
            Humanoid.AutoRotate = Character.Humanoid.AutoRotate;
        end;
    end;

    if u10.HookWalkSpeed then
        Humanoid.WalkSpeed = Character.Humanoid.WalkSpeed;
    end;

    if u10.HookJumpPower then
        Humanoid.JumpPower = Character.Humanoid.JumpPower;
    end;

    if u10.HookAutoRotate then
        Humanoid.AutoRotate = Character.Humanoid.AutoRotate;
    end;

    v9:Add(Character.Humanoid.Changed:Connect(Changed));
    local v14;

    if u10.Animations then
        v14 = Xtal.new("Animate", Humanoid, u10.Animations);
        v14.Animator = Character.Humanoid:WaitForChild("Animator");
        v9:Add(v14);
    else
        v14 = nil;
    end;

    u2.PilotAdded:Fire(u7);
    local v15 = os.clock();

    while true do
        local v16;

        if Character and Character:IsDescendantOf(workspace) then
            v16 = (not u10.Check or u10.Check()) and true or nil;
        else
            v16 = nil;
        end;

        if not v16 or u2.ActivePilot ~= u7 then
            if u2.ActivePilot == u7 or u2.ActivePilot == nil then
                if u2.ActivePilot == u7 then
                    u2:Reset();
                end;

                local v17 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
                u1:OnCharacterAdded(v17);
                u1.moveFunction = LocalPlayer.Move;
                CurrentCamera.CameraSubject = v17:WaitForChild("Humanoid");
            end;

            if getmetatable(v9) then
                v9:Destroy();
            end;

            return;
        end;

        if CurrentCamera.CameraSubject == Character.Humanoid then
            CurrentCamera.CameraSubject = Humanoid;
        end;

        Character.Humanoid:Move(Vector3.new(0, 0, 0));

        if v14 and getmetatable(v14) then
            v14:Update();
        end;

        if os.clock() - v15 <= 1 or u10.HookJump and Character.Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) or not u10.HookJump then
            if not Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);
            end;
        elseif not Character.Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) and Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
        end;

        game:GetService("RunService").RenderStepped:Wait();
    end;
end;

function u2.Reset(p18) -- Line: 166
    -- upvalues: u2 (copy)
    if u2.ActivePilot then
        u2.PilotRemoved:Fire(u2.ActivePilot);
        u2.ActivePilot = nil;
    end;

    if u2.ActiveTrove then
        if getmetatable(u2.ActiveTrove) then
            u2.ActiveTrove:Destroy();
        end;

        u2.ActiveTrove = nil;
    end;
end;

return u2;