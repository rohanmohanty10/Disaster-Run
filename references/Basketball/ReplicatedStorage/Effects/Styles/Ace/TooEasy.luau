 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy), TweenService (copy)
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local u4 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    SfxManager:playSound({
        Sound = "TooEasy",
        Parent = workspace
    });
    task.delay(3.5, function() -- Line: 24
        -- upvalues: Effects (ref), u4 (copy)
        Effects:SubtitleV2({
            { u4, `You don't belong here<animation style="appear" timeBetweenStep="{1.8}">,</animation> you idiot.`, 3.5 }
        });
    end);
    local u5 = 0;
    local u6 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 37
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
    task.delay(10 - u3, function() -- Line: 55
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);
    local CamRig = workspace:FindFirstChild("CamRig");
    local u9 = script.TooEasyFX.VFX:Clone();
    u9.Parent = workspace.Debris;
    u9:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -3.4));
    local BALL = Char:FindFirstChild("BALL", true);
    local u10 = script.TooEasyFX.BALL:Clone();
    u10.Parent = u9;
    local u11 = script.TooEasyFX.UserHeadLighting:Clone();
    u11.Parent = workspace.Debris;
    u11.CFrame = Char:FindFirstChild("Head").CFrame;
    Essentials:Weld(Char:FindFirstChild("Head"), u11);
    u10.CFrame = BALL.CFrame;
    u10.WeldConstraint.Part0 = u10;
    u10.WeldConstraint.Part1 = BALL;
    local u12;

    if CamRig then
        u12 = script.TooEasyFX.CameraFX.Camera_VFX:Clone();
        u12.Parent = CamRig;
        u12.CFrame = CamRig.camera.CFrame;
        Essentials:Weld(CamRig.camera, u12);
    else
        u12 = nil;
    end;

    VfxManager.Enable(u9.DribbleAirSpecs, false);
    VfxManager.Enable(u10, false);
    VfxManager.Emit(u9.Dribble_1);
    VfxManager.Enable(u11, true);
    task.delay(0.08 - u3, function() -- Line: 92
        -- upvalues: TweenService (ref)
        TweenService:Create(game.Lighting.DepthOfField, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 12.28,
            InFocusRadius = 3.07
        }):Play();
    end);
    local u13 = {};
    task.delay(0.283 - u3, function() -- Line: 100
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Dribble_2);
    end);
    task.delay(0.817 - u3, function() -- Line: 104
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Dribble_3);
    end);
    task.delay(1.35 - u3, function() -- Line: 108
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Dribble_5);
    end);
    task.delay(1.7 - u3, function() -- Line: 112
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Dribble_6);
    end);
    task.delay(2.13 - u3, function() -- Line: 116
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Dribble_7);
    end);
    task.delay(2.733 - u3, function() -- Line: 120
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Dribble_8);
    end);
    task.delay(3.317 - u3, function() -- Line: 124
        -- upvalues: VfxManager (ref), u9 (copy), Char (copy), u13 (copy)
        VfxManager.Emit(u9.Dribble_9);

        for _, child in script.AceAura:GetChildren() do
            if Char:FindFirstChild(child.Name) then
                local v14 = child;

                for _, child2 in child:GetChildren() do
                    local v15 = child2:Clone();

                    if v15:IsA("Attachment") then
                        VfxManager.Enable(v15, true);
                    elseif v15:IsA("ParticleEmitter") then
                        v15.Enabled = true;
                    end;

                    v15.Parent = Char:FindFirstChild(v14.Name);
                    table.insert(u13, v15);
                end;
            end;
        end;
    end);
    task.delay(4.15 - u3, function() -- Line: 143
        -- upvalues: u12 (ref), VfxManager (ref), u10 (copy), u9 (copy), TweenService (ref)
        local _ = game.Lighting;

        if u12 then
            VfxManager.Enable(u12, true);
        end;

        VfxManager.Enable(u10, true);
        VfxManager.Emit(u9.Jump);
        VfxManager.Enable(u9.AirSpecs, true);

        for _, descendant in u9.AirSpecs:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Specs" then
                local TimeScale = descendant.TimeScale;
                TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Quint), {
                    TimeScale = 0.1
                }):Play();
                task.delay(2.5, function() -- Line: 164
                    -- upvalues: TweenService (ref), descendant (copy), TimeScale (copy)
                    TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Quint), {
                        TimeScale = TimeScale
                    }):Play();
                end);
            end;
        end;

        for _, descendant in u9.Light:GetDescendants() do
            if descendant:IsA("SpotLight") then
                local Brightness = descendant.Brightness;
                local Angle = descendant.Angle;
                descendant.Brightness = 0;
                descendant.Angle = 0;
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.755, Enum.EasingStyle.Quint), {
                    Brightness = Brightness,
                    Angle = Angle
                }):Play();
            end;
        end;
    end);
    task.delay(6.233 - u3, function() -- Line: 183
        -- upvalues: TweenService (ref), VfxManager (ref), u9 (copy), u12 (ref), u11 (copy), u10 (copy), u13 (copy)
        TweenService:Create(game.Lighting.DepthOfField, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            FarIntensity = 0.21,
            FocusDistance = 90,
            InFocusRadius = 0
        }):Play();
        VfxManager.Emit(u9.Dunk);

        if u12 then
            VfxManager.Enable(u12, false);
        end;

        VfxManager.Enable(u11, false);
        local Light = u9.Light;
        Light.Attachment.BlueSpotLight.Enabled = false;
        Light.Attachment.WhiteSpotLight.Enabled = false;
        VfxManager.Enable(u9.AirSpecs, false);
        VfxManager.Enable(u10, false);

        for _, v in u13 do
            if v:IsA("Attachment") then
                VfxManager.Enable(v, false);
            elseif v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;

            task.delay(2, function() -- Line: 211
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;

        table.clear(u13);
    end);
    task.delay(9.06 - u3, function() -- Line: 218
        -- upvalues: u9 (copy), u11 (copy), u12 (ref)
        u9:Destroy();
        u11:Destroy();

        if u12 then
            u12:Destroy();
        end;
    end);
end;