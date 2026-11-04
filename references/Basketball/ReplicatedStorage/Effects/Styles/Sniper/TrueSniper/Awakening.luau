 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 15
    -- upvalues: SfxManager (copy), Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), TweenService (copy), VfxManager (copy), LightingController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    local v4 = game.Players:FindFirstChild(Character.Name) or game.Players:GetPlayerFromCharacter(Character);
    SfxManager:playSound({
        Sound = "SniperAwaken",
        Parent = workspace
    });
    Effects:SubtitleV2({
        { v4, "Victory is inevitable..<animation style=\"appear\" timeBetweenStep=\"1.8\">.</animation> <animation style=\"glitch\">when the stars align!</animation>", 4 }
    });
    local u5 = 0;
    local u6 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 42
        -- upvalues: u1 (copy), u6 (ref), u5 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u6:Disconnect();

            return;
        end;

        if u5 <= 0 then
            u5 = p7 * 60 * u3;
        end;

        u5 = u5 + p7 * 60;
        local v8 = script_Fov[math.ceil(u5)];

        if v8 ~= nil then
            if math.ceil(u5) >= #script_Fov then
                u6:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v8, p7 * 6);
        end;
    end);
    task.delay(8 - u3, function() -- Line: 61
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);
    local u9 = script.StarSign:Clone();
    u9.Parent = workspace;
    u9:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 7, 4) * CFrame.Angles(0, 3.141592653589793, 0));
    task.delay(7, function() -- Line: 70
        -- upvalues: u9 (copy), Debris (ref), TweenService (ref)
        for _, descendant in u9:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
                Debris:AddItem(descendant, 4);
            elseif descendant:IsA("PointLight") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 0
                }):Play();
                Debris:AddItem(descendant, 2);
            end;
        end;

        Debris:AddItem(u9, 4);
    end);
    local u10 = {};
    table.insert(u10, u9["Sniper StarSign"].ray1);
    table.insert(u10, u9["Sniper StarSign"].ray2);
    table.insert(u10, u9["Sniper StarSign"].ray3);
    task.delay(2.5, function() -- Line: 88
        -- upvalues: u10 (copy)
        for _, v in u10 do
            local v11 = v:FindFirstChildWhichIsA("ParticleEmitter");

            if v11 then
                v11.Enabled = true;
            end;
        end;
    end);
    task.delay(5, function() -- Line: 98
        -- upvalues: u10 (copy)
        for _, v in u10 do
            local v12 = v:FindFirstChildWhichIsA("ParticleEmitter");

            if v12 then
                v12.Enabled = false;
            end;
        end;
    end);
    local u13 = script.Stars:Clone();
    u13.Parent = workspace;
    u13.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 7, 6) * CFrame.Angles(0, 0, -1.5707963267948966);
    task.delay(8, function() -- Line: 111
        -- upvalues: u13 (copy)
        u13:Destroy();
    end);
    local u14 = script.Floor2:Clone();
    u14.Parent = workspace;
    u14.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
    task.delay(7, function() -- Line: 118
        -- upvalues: u14 (copy)
        for _, child in u14:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;

        task.wait(2);
        u14:Destroy();
    end);
    local u15 = script.Bounce.Bounce2:Clone();
    u15.Parent = HumanoidRootPart;
    task.delay(5.4, function() -- Line: 132
        -- upvalues: VfxManager (ref), u15 (copy)
        VfxManager.Emit(u15);
    end);
    task.delay(6.26, function() -- Line: 136
        -- upvalues: VfxManager (ref), u15 (copy)
        VfxManager.Emit(u15);
    end);
    local u16 = script.EyeMit["Eye Emit"]:Clone();
    u16.Parent = Character:FindFirstChild("Head");
    task.delay(7.4, function() -- Line: 142
        -- upvalues: VfxManager (ref), u16 (copy)
        VfxManager.Emit(u16);
        task.wait(2);
        u16:Destroy();
    end);
    local MapFolder = workspace:FindFirstChild("MapFolder");
    local u17 = nil;
    local Floor = workspace:FindFirstChild("Courts2").Court.Floor;

    if MapFolder then
        task.spawn(function() -- Line: 153
            -- upvalues: u17 (ref), Floor (copy)
            u17 = script["particule espace"]:Clone();
            u17.Parent = Floor;
        end);
    end;

    LightingController:SetLighting({
        Lighting = {
            Brightness = 0,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(26, 26, 26),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        },
        Atmosphere = {
            Density = 0.8,
            Offset = 1,
            Glare = 0.63,
            Haze = 6.67,
            Color = Color3.fromRGB(0, 0, 0),
            Decay = Color3.fromRGB(255, 255, 255)
        }
    });
    task.delay(8, function() -- Line: 178
        -- upvalues: u17 (ref)
        if u17 then
            u17.Enabled = false;
            task.delay(4, function() -- Line: 181
                -- upvalues: u17 (ref)
                u17:Destroy();
            end);
        end;
    end);
    task.delay(9, function() -- Line: 187
        -- upvalues: LightingController (ref), Floor (copy)
        LightingController:ResetLighting(1);
    end);
end;