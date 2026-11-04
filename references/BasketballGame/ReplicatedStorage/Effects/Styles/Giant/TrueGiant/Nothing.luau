 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 17
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy), Lighting (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    SfxManager:playSound({
        Sound = "NothingGiant",
        Parent = workspace
    });
    local u4 = 0;
    local u5 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u5 = RunService.RenderStepped:Connect(function(p6) -- Line: 29
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
    task.delay(10, function() -- Line: 48
        -- upvalues: u5 (ref)
        if u5 then
            u5:Disconnect();
        end;
    end);
    local u8 = script.VFX:Clone();
    u8.Parent = workspace.Debris;
    u8:PivotTo(HumanoidRootPart.CFrame);
    local BALL = Char:FindFirstChild("BALL", true);
    local u9 = script.BALL:Clone();
    u9.Parent = u8;
    u9.CFrame = BALL.CFrame;
    Essentials:Weld(BALL, u9);
    local u10 = script.CamVFX:Clone();
    u10.Parent = u8;
    u10:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    Essentials:Weld(u10:FindFirstChild("camera"), u10.CameraLines);
    local HeadFX = u8.HeadFX;
    HeadFX.CFrame = Char:FindFirstChild("Head").CFrame;
    Essentials:Weld(Char:FindFirstChild("Head"), HeadFX);
    local MainAura = u8.MainAura;
    MainAura.CFrame = Char:FindFirstChild("Torso").CFrame * CFrame.new(0, -2.5, 0);
    Essentials:Weld(Char:FindFirstChild("Torso"), MainAura);
    local u11 = {};
    task.delay(0.3, function() -- Line: 75
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Dribbles.Dribble_0);
    end);
    task.delay(1.3, function() -- Line: 80
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Dribbles.Dribble_1);
    end);
    task.delay(1.85, function() -- Line: 85
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Impact1);
    end);
    task.delay(2.4, function() -- Line: 90
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Step);
        VfxManager.Emit(u8.HeadFX.Emit);
        VfxManager.Enable(u8.HeadFX.Enabling, true);
    end);
    task.delay(2.983, function() -- Line: 101
        -- upvalues: Char (copy), VfxManager (ref), u11 (copy), u8 (copy), u10 (copy), Lighting (ref), u9 (copy)
        local function enableParticles(u12) -- Line: 102
            task.spawn(function() -- Line: 103
                -- upvalues: u12 (copy)
                for _, descendant in u12:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end);
        end;

        for _, child in script.Aura:GetChildren() do
            if Char:FindFirstChild(child.Name) then
                local v13 = child;

                for _, child2 in child:GetChildren() do
                    local v14 = child2:Clone();

                    if v14:IsA("Attachment") then
                        VfxManager.Enable(v14, true);
                    elseif v14:IsA("ParticleEmitter") then
                        v14.Enabled = true;
                    end;

                    v14.Parent = Char:FindFirstChild(v13.Name);
                    table.insert(u11, v14);
                end;
            end;
        end;

        local AirSpecs = u8.AirSpecs;
        task.spawn(function() -- Line: 103
            -- upvalues: AirSpecs (copy)
            for _, descendant in AirSpecs:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        local MainAura2 = u8.MainAura;
        task.spawn(function() -- Line: 103
            -- upvalues: MainAura2 (copy)
            for _, descendant in MainAura2:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        local BackgroundGalaxy = u8.BackgroundGalaxy;
        task.spawn(function() -- Line: 103
            -- upvalues: BackgroundGalaxy (copy)
            for _, descendant in BackgroundGalaxy:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        VfxManager.Enable(u10.LeftCinematicBars, true);
        VfxManager.Enable(u10.RightCinematicBars, true);
        task.spawn(function() -- Line: 134
            -- upvalues: u8 (ref), VfxManager (ref)
            VfxManager.Emit(u8.Jump);
        end);
        task.spawn(function() -- Line: 139
            -- upvalues: Lighting (ref)
            local v15 = script.Fake_At:Clone();
            v15.Glare = 0.7;
            v15.Parent = Lighting;
        end);
        task.spawn(function() -- Line: 145
            -- upvalues: u8 (ref)
            u8.BackgroundGalaxy.Void.Transparency = 0;
        end);
        VfxManager.Enable(u9, true);
    end);
    task.delay(4.233, function() -- Line: 153
        -- upvalues: VfxManager (ref), u10 (copy), Lighting (ref)
        VfxManager.Enable(u10.LeftCinematicBars, false);
        VfxManager.Enable(u10.RightCinematicBars, false);
        local Fake_At = Lighting:FindFirstChild("Fake_At");

        if Fake_At then
            Fake_At.Glare = 0.2;
        end;
    end);
    task.delay(5.6, function() -- Line: 164
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Enable(u10.LeftCinematicBars, true);
        VfxManager.Enable(u10.RightCinematicBars, true);
        VfxManager.Enable(u10.CameraLines, true);
    end);
    task.delay(5.75, function() -- Line: 173
        -- upvalues: u8 (copy), VfxManager (ref), Lighting (ref)
        VfxManager.Emit(u8.Dunk);
        local Fake_At = Lighting:FindFirstChild("Fake_At");

        if Fake_At then
            Fake_At:Destroy();
        end;

        local BackgroundGalaxy = u8.BackgroundGalaxy;
        BackgroundGalaxy.Void.Transparency = 1;
        VfxManager.Enable(BackgroundGalaxy, false);
    end);
    task.delay(6.6, function() -- Line: 187
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Landing);
        VfxManager.Enable(u8.AirSpecs, false);
        VfxManager.Enable(u8.MainAura, false);
    end);
    task.delay(7, function() -- Line: 198
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Impact2);
    end);
    task.delay(7.2, function() -- Line: 203
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Impact3);
    end);
    task.delay(8.56, function() -- Line: 208
        -- upvalues: VfxManager (ref), u10 (copy), u8 (copy), u11 (copy), u9 (copy)
        VfxManager.Enable(u10.LeftCinematicBars, false);
        VfxManager.Enable(u10.RightCinematicBars, false);
        VfxManager.Enable(u10.CameraLines, false);
        VfxManager.Enable(u8.AirSpecs, false);
        VfxManager.Enable(u8.MainAura, false);

        for _, v in u11 do
            if v:IsA("Attachment") then
                VfxManager.Enable(v, false);
            elseif v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;

            task.delay(2, function() -- Line: 229
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;

        table.clear(u11);
        VfxManager.Enable(u8.HeadFX.Enabling, false);
        VfxManager.Enable(u9, false);
    end);
    task.delay(9.56 - u3, function() -- Line: 241
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;