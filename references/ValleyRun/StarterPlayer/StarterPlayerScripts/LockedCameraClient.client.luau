 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local Camera = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Movement"):WaitForChild("MovementConfig")).Camera;
LocalPlayer.CameraMinZoomDistance = Camera.MinZoom;
LocalPlayer.CameraMaxZoomDistance = Camera.MaxZoom;
local ControlGate = require(game.ReplicatedStorage.ChickenOrHero.Movement:WaitForChild("ControlGate"));
local Cursor = require(game.ReplicatedStorage.ChickenOrHero:WaitForChild("Interface"):WaitForChild("Cursor"));
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = true;
local u7 = {};
local u8 = nil;
local u9 = false;
local u10 = nil;
local MouseBehavior = UserInputService.MouseBehavior;
local MouseIconEnabled = UserInputService.MouseIconEnabled;

local function releaseCharacter() -- Line: 22
    -- upvalues: u9 (ref), u10 (ref), u2 (ref), u4 (ref), u5 (ref), u1 (ref), u3 (ref)
    u9 = false;
    u10 = nil;

    if u2 and u2.Parent then
        u2.AutoRotate = u4;
        u2.CameraOffset = u5;
    end;

    u1 = nil;
    u2 = nil;
    u3 = nil;
end;

local function bindCharacter(p11) -- Line: 31
    -- upvalues: u9 (ref), u10 (ref), u2 (ref), u4 (ref), u5 (ref), u1 (ref), u3 (ref), LocalPlayer (copy), u8 (ref)
    u9 = false;
    u10 = nil;

    if u2 and u2.Parent then
        u2.AutoRotate = u4;
        u2.CameraOffset = u5;
    end;

    u1 = nil;
    u2 = nil;
    u3 = nil;
    local Humanoid = p11:WaitForChild("Humanoid", 10);
    local HumanoidRootPart = p11:WaitForChild("HumanoidRootPart", 10);

    if not (Humanoid and (HumanoidRootPart and LocalPlayer.Character == p11)) then
        return;
    end;

    u1 = p11;
    u2 = Humanoid;
    u3 = HumanoidRootPart;
    u8 = nil;
    u4 = Humanoid.AutoRotate;
    u5 = Humanoid.CameraOffset;
end;

table.insert(u7, LocalPlayer.CharacterAdded:Connect(bindCharacter));
table.insert(u7, LocalPlayer.CharacterRemoving:Connect(function(p12) -- Line: 45
    -- upvalues: u1 (ref), u9 (ref), u10 (ref), u2 (ref), u4 (ref), u5 (ref), u3 (ref)
    if p12 == u1 then
        u9 = false;
        u10 = nil;

        if u2 and u2.Parent then
            u2.AutoRotate = u4;
            u2.CameraOffset = u5;
        end;

        u1 = nil;
        u2 = nil;
        u3 = nil;
    end;
end));
table.insert(u7, UserInputService.WindowFocused:Connect(function() -- Line: 53
    -- upvalues: u6 (ref)
    u6 = true;
end));
table.insert(u7, UserInputService.WindowFocusReleased:Connect(function() -- Line: 59
    -- upvalues: u6 (ref)
    u6 = false;
end));

if LocalPlayer.Character then
    task.spawn(bindCharacter, LocalPlayer.Character);
end;

RunService:BindToRenderStep("CoHSpawnFacing", Enum.RenderPriority.Camera.Value - 1, function() -- Line: 66
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u8 (ref), u2 (ref), Camera (copy)
    if LocalPlayer:GetAttribute("Spectating") == true or not (u1 and (u3 and LocalPlayer:GetAttribute("ChoiceSpotlightActive") ~= true)) then
        return;
    end;

    local Attribute = u1:GetAttribute("SpawnFacingVersion");
    local Attribute2 = u1:GetAttribute("SpawnFacing");
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if Attribute ~= nil and (Attribute ~= u8 and (typeof(Attribute2) == "Vector3" and (Attribute2.Magnitude > 0.001 and (workspace_CurrentCamera and (workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable and workspace_CurrentCamera.CameraSubject == u2))))) then
        u8 = Attribute;
        local math_clamp_ret = math.clamp((workspace_CurrentCamera.CFrame.Position - workspace_CurrentCamera.Focus.Position).Magnitude, Camera.MinZoom, Camera.MaxZoom);
        local math_clamp_ret2 = math.clamp(workspace_CurrentCamera.CFrame.LookVector.Y, -0.6, 0.2);
        local v13 = Attribute2 * Vector3.new(1, 0, 1);

        if v13.Magnitude < 0.001 then
            return;
        end;

        local v14 = v13.Unit * math.sqrt(1 - math_clamp_ret2 * math_clamp_ret2) + Vector3.new(0, 1, 0) * math_clamp_ret2;
        local v15 = u3.Position + Vector3.new(0, 1.5, 0);
        workspace_CurrentCamera.CFrame = CFrame.lookAt(v15 - v14 * math_clamp_ret, v15);
        workspace_CurrentCamera.Focus = CFrame.new(v15);
    end;
end);
RunService:BindToRenderStep("ChickenOrHeroLockedCamera", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 103
    -- upvalues: u9 (ref), LocalPlayer (copy), u2 (ref), u4 (ref), u3 (ref), UserInputService (copy), Cursor (copy), ControlGate (copy), u6 (ref), u5 (ref), Camera (copy), u1 (ref), u10 (ref)
    u9 = false;

    if LocalPlayer:GetAttribute("Spectating") == true then
        if u2 then
            u2.AutoRotate = u4;
        end;

        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v16 = u2 and u3;

    if v16 then
        if u2.Health > 0 then
            if workspace_CurrentCamera then
                if workspace_CurrentCamera.CameraSubject == u2 then
                    v16 = workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable;
                else
                    v16 = false;
                end;
            else
                v16 = workspace_CurrentCamera;
            end;
        else
            v16 = false;
        end;
    end;

    local v17;

    if LocalPlayer:GetAttribute("MatchSummaryVisible") == true and LocalPlayer:GetAttribute("InMatch") ~= true then
        v17 = game.ReplicatedStorage.ChickenOrHero.Game.Session:GetAttribute("Phase") == "Intermission";
    else
        v17 = false;
    end;

    local v18;

    if game.ReplicatedStorage.ChickenOrHero.Game.Session:GetAttribute("BossFighting") == true then
        v18 = type(LocalPlayer:GetAttribute("BossHearts")) == "number";
    else
        v18 = false;
    end;

    local v19 = not v18;

    if v19 then
        if UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
            v19 = LocalPlayer:GetAttribute("InMatch") ~= true;
        else
            v19 = false;
        end;
    end;

    local v20 = Cursor.active();

    if v20 then
        v17 = v20;
    else
        local v21;

        if v18 then
            v21 = ControlGate.reason(LocalPlayer) ~= nil and true or LocalPlayer:GetAttribute("ReleaseCursorForControls") == true;
        else
            v21 = ControlGate.cursorReason(LocalPlayer) ~= nil;
        end;

        if v21 then
            v17 = v21;
        elseif v17 then
            v17 = not v19;
        end;
    end;

    if v16 and (u6 and (v19 or v17)) then
        if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter and not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        end;

        UserInputService.MouseIconEnabled = true;
        u2.AutoRotate = u4;
        u2.CameraOffset = u5;

        return;
    end;

    if not (v16 and u6) then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        UserInputService.MouseIconEnabled = true;

        if u2 then
            u2.AutoRotate = u4;
            u2.CameraOffset = u5;
        end;

        return;
    end;

    if UserInputService.MouseEnabled then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
        UserInputService.MouseIconEnabled = false;
    end;

    u2.CameraOffset = Camera.ShoulderOffset;

    if u1:GetAttribute("TackleActive") or u1:GetAttribute("GearMotion") then
        return;
    end;

    if u2.Sit or (u2.PlatformStand or (u3.Anchored or u2:GetState() == Enum.HumanoidStateType.Physics)) then
        u2.AutoRotate = u4;
    else
        u2.AutoRotate = false;
        local LookVector = workspace_CurrentCamera.CFrame.LookVector;
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

        if Vector3_new_ret.Magnitude > 0.001 then
            u10 = Vector3_new_ret.Unit;
            u9 = true;
        end;
    end;
end);
table.insert(u7, RunService.PreSimulation:Connect(function() -- Line: 188
    -- upvalues: u9 (ref), u10 (ref), u3 (ref), LocalPlayer (copy), u1 (ref), u2 (ref)
    if not (u9 and (u10 and (u3 and (u3.Parent and (LocalPlayer.Character == u1 and (u2.Health > 0 and not (u2.Sit or (u2.PlatformStand or (u3.Anchored or (u2:GetState() == Enum.HumanoidStateType.Physics or (u1:GetAttribute("TackleActive") or u1:GetAttribute("GearMotion")))))))))))) then
        return;
    end;

    if u3.CFrame.LookVector:Dot(u10) < 0.999999 or u3.CFrame.UpVector:Dot(Vector3.new(0, 1, 0)) < 0.999999 then
        u3.CFrame = CFrame.lookAt(u3.Position, u3.Position + u10);
    end;
end));
script.Destroying:Connect(function() -- Line: 213
    -- upvalues: RunService (copy), u7 (copy), u9 (ref), u10 (ref), u2 (ref), u4 (ref), u5 (ref), u1 (ref), u3 (ref), UserInputService (copy), MouseBehavior (copy), MouseIconEnabled (copy)
    RunService:UnbindFromRenderStep("ChickenOrHeroLockedCamera");
    RunService:UnbindFromRenderStep("CoHSpawnFacing");

    for _, v in u7 do
        v:Disconnect();
    end;

    u9 = false;
    u10 = nil;

    if u2 and u2.Parent then
        u2.AutoRotate = u4;
        u2.CameraOffset = u5;
    end;

    u1 = nil;
    u2 = nil;
    u3 = nil;
    UserInputService.MouseBehavior = MouseBehavior;
    UserInputService.MouseIconEnabled = MouseIconEnabled;
end);