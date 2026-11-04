  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local _ = workspace.CurrentCamera;
local _ = Players.LocalPlayer;
local Players2 = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players2.LocalPlayer;
local CurrentCamera = Workspace.CurrentCamera;

local function createDebugPart(p1: vector, p2, p3: vector, p4: number) -- Line: 28
    -- upvalues: Workspace (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = p2;
    Part.Size = p3;
    Part.CFrame = CFrame.new(p1);
    Part.Parent = Workspace;
    game.Debris:AddItem(Part, p4 or 2);

    return Part;
end;

local function GetAimPointFromCenter(p5: number?, p6: userdata?, p7: boolean?) -- Line: 44
    -- upvalues: CurrentCamera (copy), LocalPlayer (copy), Workspace (copy), createDebugPart (copy)
    local v8 = p5 or 200;
    local ViewportSize = CurrentCamera.ViewportSize;
    local v9 = CurrentCamera:ScreenPointToRay(ViewportSize.X * 0.5, ViewportSize.Y * 0.5);
    local Origin = v9.Origin;
    local Direction = v9.Direction;
    local v10 = p6 or RaycastParams.new();
    v10.FilterType = v10.FilterType or Enum.RaycastFilterType.Exclude;
    v10.FilterDescendantsInstances = v10.FilterDescendantsInstances or { LocalPlayer.Character };
    local v11 = Workspace:Raycast(Origin, Direction * v8, v10);
    local v12 = v11 and v11.Position or Origin + Direction * v8;

    if p7 then
        local v13 = v12 - Origin;
        local Magnitude = v13.Magnitude;
        local v14 = Origin + v13 * 0.5;
        createDebugPart(v14, Color3.fromRGB(0, 170, 255), Vector3.new(0.1, 0.1, Magnitude), 1).CFrame = CFrame.lookAt(v14, v12);
        createDebugPart(v12, v11 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0), Vector3.new(0.5, 0.5, 0.5), 1);
    end;

    return v12, v11, Origin, Direction;
end;

return function(u15, p16, u17) -- Line: 86
    -- upvalues: ReplicatedStorage (copy), Players2 (copy), RunService (copy), Popup (copy), GetAimPointFromCenter (copy), AbilityBalancing (copy)
    if p16.Character.Values.HasBall.Value == true then
        return;
    end;

    if u15.AbilityOne > tick() then
        return;
    end;

    if u15.AbilityUsed > tick() then
        return;
    end;

    if u15.ABC then
        u15.ABC:Clean();
    end;

    if u17.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    local Value = ReplicatedStorage.Football.Value;
    local Value2 = Value.OnPlayer.Value;
    local Value3 = Value.Char.Value;
    local PlayerFromCharacter = Players2:GetPlayerFromCharacter(Value3);
    local v18;

    if Value3 then
        v18 = Value3:GetAttribute("IsTrainingDummy");
    else
        v18 = Value3;
    end;

    if RunService:IsStudio() then
        Value3 = nil;
    else
        if not (Value2 and (Value3 and (PlayerFromCharacter and (PlayerFromCharacter.Team ~= p16.Team and (Value3.Values.Goalie.Value == false or Value3.Values.IsInPenalty.Value == false)))) or Value2 and v18) then
            Popup.Popup(p16, "Enemy team must have ball!");

            return;
        end;

        if (Value3.HumanoidRootPart.Position - u17.HumanoidRootPart.Position).Magnitude >= 75 then
            Popup.Popup(p16, "Must be near player with ball!");

            return;
        end;
    end;

    u15.Camera.Cutscene = true;
    u15.InAbility = true;
    u15.StatesController.States.Ability = true;
    u17.HumanoidRootPart.Anchored = true;
    u15.ABC:Add(function() -- Line: 122
        -- upvalues: u15 (copy), u17 (copy)
        u15.Camera.Cutscene = false;
        u15.InAbility = false;
        u15.StatesController.States.Ability = false;
        u17.HumanoidRootPart.Anchored = false;
    end);
    u15:AbilityCooldown("1", 75);
    u15.AbilityService.Ability:Fire("InfernoDragonDrive", Value3);
    local _ = u17.HumanoidRootPart.CFrame.LookVector;
    u15.ABC:Add(task.delay(40, function() -- Line: 135
        -- upvalues: u15 (copy)
        u15.ABC:Clean();
    end));
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Goals };
    local u19 = GetAimPointFromCenter(200, RaycastParams_new_ret, false);
    u15.ABC:Connect(u15.AbilityService.Ability, function(p20) -- Line: 145
        -- upvalues: u19 (copy), u17 (copy), AbilityBalancing (ref), u15 (copy)
        p20.AssemblyLinearVelocity = (u19 - u17.HumanoidRootPart.Position).Unit * AbilityBalancing.InfernoDragonDrive.ShotPower;
        u15.BallController:DragBall(p20);
        u15.ABC:Clean();
    end);
end;