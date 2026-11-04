 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 14
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), LightingController (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    SfxManager:playSound({
        Sound = "ClutchAwaken",
        Duration = 7,
        Parent = workspace
    });
    local u4 = 0;
    local u5 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u5 = RunService.RenderStepped:Connect(function(p6) -- Line: 27
        -- upvalues: u1 (copy), u5 (ref), u4 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u5:Disconnect();

            return;
        end;

        if u4 <= 0 then
            u4 = p6 * 60 * u3;
        end;

        u4 = u4 + p6 * 60;
        local v7 = script_Fov[math.ceil(u4)];

        if v7 ~= nil then
            if math.ceil(u4) >= #script_Fov then
                u5:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v7, p6 * 6);
        end;
    end);
    task.delay(6 - u3, function() -- Line: 46
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
    task.delay(4.75 - u3, function() -- Line: 52
        local v8 = script["Black+White"]:Clone();
        v8.Parent = game.Lighting;
        v8.Enabled = true;
        task.wait(0.04);
        v8:Destroy();
        local v9 = script["White+Back"]:Clone();
        v9.Parent = game.Lighting;
        v9.Enabled = true;
        task.wait(0.04);
        v9:Destroy();
    end);
    game.Lighting.Atmosphere.Color = Color3.new(0.0823529, 0.0823529, 0.0823529);
    game.Lighting.Atmosphere.Decay = Color3.new(0.0980392, 0.0980392, 0.0980392);
    game.Lighting.Atmosphere.Haze = 10;
    task.delay(1.5 - u3, function() -- Line: 69
        -- upvalues: LightingController (ref), u3 (copy)
        LightingController:SetLighting({
            Lighting = {
                Brightness = 0,
                EnvironmentDiffuseScale = 1,
                EnvironmentSpecularScale = 1,
                GlobalShadows = true,
                GeographicLatitude = 54.377
            },
            Atmosphere = {
                Density = 1,
                Offset = 1,
                Glare = 0
            }
        }, 2.5 - u3);
    end);
    task.delay(6, function() -- Line: 87
        -- upvalues: LightingController (ref)
        LightingController:ResetLighting(0.7);
    end);
    local Head = Character:FindFirstChild("Head");
    local script_HeadAttachs = script.HeadAttachs;
    local u10 = script_HeadAttachs.Right:Clone();
    u10.Parent = Head;
    local u11 = script_HeadAttachs.Left:Clone();
    u11.Parent = Head;
    local u12 = script_HeadAttachs.starLeft:Clone();
    u12.Parent = Head;
    local u13 = script_HeadAttachs.starRight:Clone();
    u13.Parent = Head;
    task.delay(4.8 - u3, function() -- Line: 108
        -- upvalues: VfxManager (ref), u10 (copy), u11 (copy), u12 (copy), u13 (copy)
        VfxManager.Enable(u10, true);
        VfxManager.Enable(u11, true);
        VfxManager.Emit(u12);
        VfxManager.Emit(u13);
        task.wait(3);
        u11:Destroy();
        u10:Destroy();
        u12:Destroy();
        u13:Destroy();
    end);

    for _, child in script.RootAttachs:GetChildren() do
        local u14 = child:Clone();
        u14.Parent = HumanoidRootPart;
        local Name = u14.Name;
        task.delay(4.8 - u3, function() -- Line: 128
            -- upvalues: Name (copy), u14 (ref)
            if Name == "Sparks1" or Name == "Sparks2" then
                u14.Enabled = true;
            elseif Name == "Attachment" then
                u14.AuraBurst.Enabled = true;
                local Explosions = u14.Explosions;
                Explosions:Emit(Explosions:GetAttribute("EmitCount"));
            end;

            task.wait(1.2);
            u14:Destroy();
        end);
    end;
end;