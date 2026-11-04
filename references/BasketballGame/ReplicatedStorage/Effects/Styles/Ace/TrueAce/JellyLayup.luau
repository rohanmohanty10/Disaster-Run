 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Zone = require(ReplicatedStorage.Effects.Base.Zone);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 15
    -- upvalues: SfxManager (copy), Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), Zone (copy), VfxManager (copy), TweenService (copy), Lighting (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Char = p2.Char;
    local u4 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    SfxManager:playSound({
        Sound = "JellyLayup",
        Parent = workspace
    });
    task.delay(2.5, function() -- Line: 24
        -- upvalues: Effects (ref), u4 (copy)
        Effects:SubtitleV2({
            { u4, "Boring...", 1 }
        });
    end);
    local u5 = 0;
    local u6 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 33
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
    task.delay(10 - u3, function() -- Line: 51
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Zone(u1, {
        Hide = true,
        Time = 7.267,
        Char = Char
    });
    local CamRig = workspace:FindFirstChild("CamRig");
    local BALL = Char:FindFirstChild("BALL", true);
    local u9 = script.Jelly_VFX.VFX:Clone();
    u9.Parent = workspace.Debris;
    u9:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -3.4));
    local u10 = script.Jelly_VFX.BALL:Clone();
    u10.Parent = u9;
    u10.CFrame = BALL.CFrame;
    u10.WeldConstraint.Part0 = u10;
    u10.WeldConstraint.Part1 = BALL;
    local u11 = script.CameraVFX:Clone();
    u11.Parent = u9;

    if CamRig then
        u11.PrimaryPart.CFrame = CamRig.camera.CFrame;
        Essentials:Weld(CamRig.camera, u11.PrimaryPart);
    else
        u11:Destroy();
        warn("cam rig not found");
    end;

    local u12 = {};
    task.delay(0.33 - u3, function() -- Line: 89
        -- upvalues: u9 (copy), VfxManager (ref), u11 (copy)
        VfxManager.Enable(u9.AirSpecs, true);
        VfxManager.Enable(u11.L_R, true);
        VfxManager.Emit(u9.MC_Jump);
    end);
    task.delay(0.867 - u3, function() -- Line: 99
        -- upvalues: u9 (copy), VfxManager (ref), TweenService (ref)
        local Jump = u9.Jump;
        VfxManager.Emit(Jump);

        for _, descendant in Jump:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 105
                    -- upvalues: TweenService (ref), descendant (copy)
                    task.wait(0.2);
                    TweenService:Create(descendant, TweenInfo.new(0.25), {
                        TimeScale = 0.3
                    }):Play();
                end);
            end;
        end;
    end);
    task.delay(3.05 - u3, function() -- Line: 113
        -- upvalues: u9 (copy), VfxManager (ref), u10 (copy), u11 (copy), Char (copy), u12 (copy)
        VfxManager.Emit(u9.Fake_Emit);
        VfxManager.Enable(u10, true);
        VfxManager.Enable(u11.L_R, false);
        VfxManager.Enable(u11.T_B, true);

        for _, descendant in u9.AirSpecs:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Rate = descendant.Rate / 5;
            end;
        end;

        u9.Light.Attachment.Beam.Enabled = true;

        for _, child in script.AceAura:GetChildren() do
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
                    table.insert(u12, v14);
                end;
            end;
        end;
    end);
    task.delay(3.067 - u3, function() -- Line: 149
        -- upvalues: Lighting (ref)
        script.Jelly_VFX.Fake_at:Clone().Parent = Lighting;
    end);
    task.delay(3.783 - u3, function() -- Line: 154
        -- upvalues: u9 (copy), VfxManager (ref), u10 (copy)
        VfxManager.Emit(u9.AuraEmit1);
        VfxManager.Enable(u10, false);
    end);
    task.delay(4.3 - u3, function() -- Line: 161
        -- upvalues: u9 (copy), VfxManager (ref), u11 (copy)
        for _, descendant in pairs(u9.Release:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        VfxManager.Enable(u11.T_B, false);

        for _, descendant in u9.AirSpecs:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Rate = descendant.Rate * 5;
            end;
        end;
    end);
    task.delay(4.85 - u3, function() -- Line: 180
        -- upvalues: u9 (copy), VfxManager (ref), Lighting (ref), u12 (copy)
        VfxManager.Enable(u9.AirSpecs, false);
        local Fake_at = Lighting:FindFirstChild("Fake_at");

        if Fake_at then
            Fake_at:Destroy();
        end;

        VfxManager.Emit(u9.Landing);

        for _, v in u12 do
            if v:IsA("Attachment") then
                VfxManager.Enable(v, false);
            elseif v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;

            task.delay(2, function() -- Line: 198
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;

        table.clear(u12);
    end);
    task.delay(6.233 - u3, function() -- Line: 205
        -- upvalues: u9 (copy), TweenService (ref), u10 (copy)
        for _, descendant in u9.Jump:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 209
                    -- upvalues: TweenService (ref), descendant (copy)
                    TweenService:Create(descendant, TweenInfo.new(0.1), {
                        TimeScale = 1
                    }):Play();
                end);
            end;
        end;

        for _, descendant in u10:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            elseif descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(7.267 - u3, function() -- Line: 224
        -- upvalues: u9 (copy)
        u9.Light.Attachment.Beam.Enabled = false;
        u9:Destroy();
    end);
end;