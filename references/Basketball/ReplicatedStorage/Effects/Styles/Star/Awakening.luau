 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Controllers.LightingController);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 18
    -- upvalues: SfxManager (copy), Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    workspace:FindFirstChild("CamRig");
    local BALL = Char:FindFirstChild("BALL", true);
    local u4 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    SfxManager:playSound({
        Sound = "MeteorAwaken",
        Duration = 8,
        Parent = workspace
    });
    task.delay(4.5, function() -- Line: 32
        -- upvalues: Effects (ref), u4 (copy)
        Effects:SubtitleV2({
            { u4, "Not a single one of you can stop me!", 3.5 }
        });
    end);
    local Attribute = workspace:GetAttribute("CurrentMap");
    local u5 = workspace:FindFirstChild(Attribute);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 48
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * u3;
        end;

        u6 = u6 + p8 * 60;
        local v9 = script_Fov[math.ceil(u6)];

        if v9 ~= nil then
            if math.ceil(u6) >= #script_Fov then
                u7:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
        end;
    end);
    task.delay(10 - u3, function() -- Line: 67
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);
    local u10 = script.VFX:Clone();
    u10.Parent = workspace.Debris;
    u10:PivotTo(HumanoidRootPart.CFrame);
    local u11 = {};
    local u12 = nil;
    local u13 = nil;
    local QuickSpecs = u10.CharacterFX.QuickSpecs;
    QuickSpecs.CFrame = Char:FindFirstChild("Torso").CFrame * CFrame.new(-0.028, -2.959, -0.078);
    Essentials:Weld(Char:FindFirstChild("Torso"), QuickSpecs);
    task.delay(0.97 - u3, function() -- Line: 84
        -- upvalues: u10 (copy), VfxManager (ref), Attribute (copy), u5 (copy), u11 (copy), u12 (ref), BALL (copy)
        VfxManager.Emit(u10.Transition);
        local Galaxybackground = u10.Galaxybackground;
        VfxManager.Enable(Galaxybackground, true);
        Galaxybackground.BackgroundGalaxy.Void.Transparency = 0;

        if Attribute == "Map1" then
            for _, child in u5.CourtParts:GetChildren() do
                child.Transparency = child.Transparency + 1;
                table.insert(u11, child);
            end;

            local Part = u5.Ground.Part;
            Part.Transparency = Part.Transparency + 1;
            table.insert(u11, Part);
        end;

        for _, child in workspace.Courts2.Court:GetChildren() do
            if child.Name ~= "Outlines" then
                child.Transparency = child.Transparency + 1;
                table.insert(u11, child);
            end;
        end;

        u12 = script.BALL.VFX:Clone();
        u12.Parent = BALL;
        VfxManager.Enable(u12, true);
    end);
    task.delay(1.68 - u3, function() -- Line: 125
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.CharacterFX.SmallDrible);
    end);
    task.delay(2.217 - u3, function() -- Line: 130
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.CharacterFX.SmallDrible);
    end);
    task.delay(2.517 - u3, function() -- Line: 135
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Enable(u10.CharacterFX.QuickSpecs, true);
    end);
    task.delay(3.483 - u3, function() -- Line: 139
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Enable(u10.CharacterFX.QuickSpecs, false);
    end);
    task.delay(2.9 - u3, function() -- Line: 143
        -- upvalues: VfxManager (ref), u10 (copy), u13 (ref), Char (copy)
        VfxManager.Emit(u10.CharacterFX.eyemit);
        u13 = script.HeadVFX.Stuff:Clone();
        u13.Parent = Char:FindFirstChild("Head");
        VfxManager.Enable(u13, true);
    end);
    task.delay(3.76 - u3, function() -- Line: 150
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.CharacterFX.ElectricDribbleFirst);
    end);
    task.delay(4.97, function() -- Line: 155
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10.CharacterFX.FootStep);
    end);
    task.delay(5 - u3, function() -- Line: 159
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Enable(u10.CharacterFX.MovementFX, true);
    end);
    task.delay(7.2 - u3, function() -- Line: 164
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.CharacterFX.ElectricDribbleSecond);
    end);
    task.delay(8.6 - u3, function() -- Line: 169
        -- upvalues: u10 (copy), u11 (copy), u12 (ref), u13 (ref)
        u10:Destroy();

        for _, v in u11 do
            v.Transparency = v.Transparency - 1;
        end;

        if u12 then
            u12:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;
    end);
end;