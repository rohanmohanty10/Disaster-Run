  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local createAfterImage = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 21
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy), EmitModule (copy), createAfterImage (copy), ReplicatedStorage (copy), RunService (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u2 = {};

    local function ScreenEffect() -- Line: 36
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 60, 100)
            }):Play();
            task.delay(0.1, function() -- Line: 40
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    local function GetSafePosition(p3, p4) -- Line: 46
        -- upvalues: Char (copy)
        local Position = (Char.HumanoidRootPart.CFrame * CFrame.new(p4)).Position;
        local v5 = Position - p3;
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Char, workspace.Debris };
        RaycastParams_new_ret.IgnoreWater = true;
        local v6 = workspace:Raycast(p3, v5, RaycastParams_new_ret);

        if v6 then
            return v6.Position - v5.Unit * 1;
        end;

        return Position;
    end;

    local function CreateEffect(p7, p8) -- Line: 65
        -- upvalues: VfxManager (ref), u2 (copy)
        local v9 = p7:Clone();
        v9.CFrame = p8;
        v9.Parent = workspace.Debris;
        VfxManager.Emit(v9);
        table.insert(u2, v9);
    end;

    local v10 = script.Highlight:Clone();
    v10.Parent = Char;
    EmitModule.emit(v10);

    if p1.Type == "Start" then
        local Position = Char.HumanoidRootPart.Position;
        local script_StartupSimple = script.StartupSimple;
        local v11 = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
        local v12 = script_StartupSimple:Clone();
        v12.CFrame = v11;
        v12.Parent = workspace.Debris;
        VfxManager.Emit(v12);
        table.insert(u2, v12);
        local u13 = createAfterImage(Char, {
            NotAnchored = true,
            Duration = 3,
            FillColor = Color3.new(0.392157, 0.839216, 0.976471),
            OutlineColor = Color3.new(0.262745, 0.592157, 0.796078)
        });
        table.insert(u2, u13);
        u13.Humanoid:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Abilities.DribbleZoneForwardClone):Play();
        local v14 = GetSafePosition(Position, Vector3.new(0, 0, -60));
        TweenService:Create(u13.HumanoidRootPart, TweenInfo.new(0.3), {
            CFrame = CFrame.new(v14, v14 + Char.HumanoidRootPart.CFrame.LookVector)
        }):Play();
        local u15 = createAfterImage(Char, {
            NotAnchored = true,
            Duration = 3,
            FillColor = Color3.new(0.392157, 0.839216, 0.976471),
            OutlineColor = Color3.new(0.262745, 0.592157, 0.796078)
        });
        table.insert(u2, u15);
        u15.Humanoid:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Abilities.DribbleZoneRightClone):Play();
        local v16 = GetSafePosition(Position, Vector3.new(60, 0, 0));
        TweenService:Create(u15.HumanoidRootPart, TweenInfo.new(0.3), {
            CFrame = CFrame.new(v16, v16 + Char.HumanoidRootPart.CFrame.LookVector)
        }):Play();
        local u17 = createAfterImage(Char, {
            NotAnchored = true,
            Duration = 3,
            FillColor = Color3.new(0.392157, 0.839216, 0.976471),
            OutlineColor = Color3.new(0.262745, 0.592157, 0.796078)
        });
        table.insert(u2, u17);
        u17.Humanoid:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Abilities.DribbleZoneLeftClone):Play();
        local v18 = GetSafePosition(Position, Vector3.new(-60, 0, 0));
        TweenService:Create(u17.HumanoidRootPart, TweenInfo.new(0.3), {
            CFrame = CFrame.new(v18, v18 + Char.HumanoidRootPart.CFrame.LookVector)
        }):Play();
        local u19 = script.Trail:Clone();
        u19.Parent = workspace.Debris;
        EmitModule.emit(u19);
        table.insert(u2, u19);
        local u20 = script.Trail:Clone();
        u20.Parent = workspace.Debris;
        EmitModule.emit(u20);
        table.insert(u2, u20);
        local u21 = script.Trail:Clone();
        u21.Parent = workspace.Debris;
        EmitModule.emit(u21);
        table.insert(u2, u21);
        local v22 = RunService.Heartbeat:Connect(function() -- Line: 165
            -- upvalues: u19 (copy), u13 (copy), u20 (copy), u15 (copy), u21 (copy), u17 (copy)
            u19.CFrame = u13.HumanoidRootPart.CFrame;
            u20.CFrame = u15.HumanoidRootPart.CFrame;
            u21.CFrame = u17.HumanoidRootPart.CFrame;
        end);
        task.wait(0.7);
        v22:Disconnect();
        local CFrame2 = u13.HumanoidRootPart.CFrame;
        local v23 = script.StartDash:Clone();
        v23.CFrame = CFrame2;
        v23.Parent = workspace.Debris;
        VfxManager.Emit(v23);
        table.insert(u2, v23);
        local CFrame3 = u15.HumanoidRootPart.CFrame;
        local v24 = script.StartDash:Clone();
        v24.CFrame = CFrame3;
        v24.Parent = workspace.Debris;
        VfxManager.Emit(v24);
        table.insert(u2, v24);
        local CFrame4 = u17.HumanoidRootPart.CFrame;
        local v25 = script.StartDash:Clone();
        v25.CFrame = CFrame4;
        v25.Parent = workspace.Debris;
        VfxManager.Emit(v25);
        table.insert(u2, v25);
        u13:Destroy();
        u15:Destroy();
        u17:Destroy();
    else
        local v26 = p1.Side == "Forward" and CFrame.Angles(0, 0, 0) or p1.Side == "Left" and CFrame.Angles(0, 1.5707963267948966, 0);

        if not v26 then
            if p1.Side == "Right" then
                v26 = CFrame.Angles(0, -1.5707963267948966, 0);
            else
                v26 = false;
            end;
        end;

        local v27 = HumanoidRootPart.CFrame * v26;
        local v28 = script.Hit4Emit:Clone();
        v28.CFrame = v27;
        v28.Parent = workspace.Debris;
        VfxManager.Emit(v28);
        table.insert(u2, v28);
    end;

    task.spawn(function() -- Line: 189
        for i = 1, 20 do
            task.wait(0.1);
            local _ = i;
        end;
    end);
    task.wait(2);
    v10:Destroy();

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;