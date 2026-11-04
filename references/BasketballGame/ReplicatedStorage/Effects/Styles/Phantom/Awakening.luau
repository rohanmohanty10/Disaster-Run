 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local Zone = require(ReplicatedStorage.Effects.Base.Zone);
local _ = game.Players.LocalPlayer;
local u1 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

return function(u2, p3) -- Line: 25
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), Zone (copy), SfxManager (copy), TweenService (copy), Debris (copy), u1 (copy), VfxManager (copy), LightingController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u4 = workspace:GetServerTimeNow() - p3.TimeSent;
    local u5 = 0;
    local u6 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 32
        -- upvalues: u2 (copy), u6 (ref), u5 (ref), u4 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u2.MovementController.States.Ability == false then
            u6:Disconnect();

            return;
        end;

        if u5 <= 0 then
            u5 = p7 * 60 * u4;
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
    local Char = p3.Char;
    local CamRig = workspace:FindFirstChild("CamRig");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Zone(u2, {
        Hide = true,
        Time = 8,
        Char = Char
    });
    SfxManager:playSound({
        Sound = "PhantomAwaken",
        Duration = 11,
        Parent = workspace
    });
    local u9 = Char:FindFirstChildWhichIsA("Highlight");

    if u9 then
        u9.Enabled = false;
    end;

    task.delay(10 - u4, function() -- Line: 63
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);
    task.delay(6.5 - u4, function() -- Line: 69
        -- upvalues: TweenService (ref), Debris (ref)
        local u10 = script.Blur:Clone();
        u10.Parent = game.Lighting;
        u10.Enabled = true;
        u10.Size = 0;
        TweenService:Create(u10, TweenInfo.new(3), {
            Size = 17
        }):Play();
        task.delay(3, function() -- Line: 75
            -- upvalues: TweenService (ref), u10 (copy), Debris (ref)
            TweenService:Create(u10, TweenInfo.new(0.5), {
                Size = 0
            }):Play();
            Debris:AddItem(u10, 0.8);
        end);
    end);
    task.delay(5.8 - u4, function() -- Line: 82
        -- upvalues: Char (copy), u1 (ref)
        for _, child in Char:GetChildren() do
            if table.find(u1, child.Name) then
                local v11 = child;

                for _, child2 in script.BodyParticles:GetChildren() do
                    local u12 = child2:Clone();
                    u12.Parent = v11;
                    u12.Enabled = true;
                    task.delay(4, function() -- Line: 89
                        -- upvalues: u12 (ref)
                        u12.Enabled = false;
                        task.wait(3);
                        u12:Destroy();
                    end);
                end;
            end;
        end;
    end);
    task.delay(7.4 - u4, function() -- Line: 100
        -- upvalues: Char (copy), TweenService (ref)
        for _, descendant in Char:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(1.2), {
                    Transparency = descendant.Transparency + 1
                }):Play();
                task.delay(2, function() -- Line: 104
                    -- upvalues: TweenService (ref), descendant (copy)
                    TweenService:Create(descendant, TweenInfo.new(1), {
                        Transparency = descendant.Transparency - 1
                    }):Play();
                end);
            end;
        end;
    end);
    task.delay(3.7 - u4, function() -- Line: 112
        -- upvalues: Char (copy), Debris (ref)
        for _, child in script.EyeParticles:GetChildren() do
            local u13 = child:Clone();
            u13.Parent = Char:FindFirstChild("Head");
            task.delay(7, function() -- Line: 117
                -- upvalues: u13 (ref), Debris (ref)
                for _, child2 in u13:GetChildren() do
                    if child2:IsA("ParticleEmitter") then
                        child2.Enabled = false;
                    end;
                end;

                Debris:AddItem(u13, 3);
            end);
        end;
    end);
    task.delay(2.16 - u4, function() -- Line: 129
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), CamRig (copy)
        for _, child in script.RootEffects:GetChildren() do
            local u14 = child:Clone();
            u14.Parent = HumanoidRootPart;
            VfxManager.Emit(u14);
            task.delay(3, function() -- Line: 135
                -- upvalues: u14 (ref)
                u14:Destroy();
            end);
        end;

        if CamRig then
            local u15 = script.CameraLines:Clone();
            u15.Parent = CamRig.camera;
            u15.Enabled = true;
            task.delay(0.5, function() -- Line: 144
                -- upvalues: u15 (copy)
                u15:Destroy();
            end);
        end;
    end);
    local u16 = script.BLACK:Clone();
    u16.Parent = game.Lighting;
    task.delay(6.7 - u4, function() -- Line: 153
        -- upvalues: u16 (copy), TweenService (ref)
        u16.Enabled = true;
        TweenService:Create(u16, TweenInfo.new(0.2), {
            Brightness = 0,
            TintColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(7.1 - u4, function() -- Line: 158
        -- upvalues: TweenService (ref), u16 (copy)
        TweenService:Create(u16, TweenInfo.new(0.4), {
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(8.3 - u4, function() -- Line: 162
        -- upvalues: TweenService (ref), u16 (copy)
        TweenService:Create(u16, TweenInfo.new(0.3), {
            Brightness = 0,
            TintColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(9.3 - u4, function() -- Line: 166
        -- upvalues: u9 (copy), TweenService (ref), u16 (copy)
        if u9 then
            u9.Enabled = true;
        end;

        TweenService:Create(u16, TweenInfo.new(0.5), {
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.wait(0.5);
        u16:Destroy();
    end);
    LightingController:SetLighting({
        Atmosphere = {
            Density = 0,
            Offset = 0.193,
            Color = Color3.fromRGB(164, 235, 255),
            Decay = Color3.fromRGB(255, 255, 255)
        }
    });
    task.delay(1.5 - u4, function() -- Line: 186
        -- upvalues: LightingController (ref)
        LightingController:SetLighting({
            Lighting = {
                EnvironmentDiffuseScale = 0,
                OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            },
            Atmosphere = {
                Density = 0.7,
                Offset = 0.193
            }
        }, 1.4);
    end);
    task.delay(3.5 - u4, function() -- Line: 199
        -- upvalues: LightingController (ref)
        LightingController:SetLighting({
            Atmosphere = {
                Density = 1,
                Offset = 0.2
            }
        }, 4);
    end);
    task.delay(8 - u4, function() -- Line: 208
        -- upvalues: LightingController (ref)
        LightingController:ResetLighting(1);
    end);
end;