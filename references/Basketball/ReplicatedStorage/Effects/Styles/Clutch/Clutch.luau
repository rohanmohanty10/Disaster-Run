 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Zone = require(ReplicatedStorage.Effects.Base.Zone);
local _ = game.Players.LocalPlayer;

function EmitAll(p1: table)
    for _, v in next, p1 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 20
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

function EnableVFX(p2: userdata, p3: boolean?)
    for _, v in next, p2:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p3 or false;
        end;
    end;
end;

function Weld(p4: userdata, p5: userdata)
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p4;
    WeldConstraint.Part1 = p5;
    WeldConstraint.Parent = p4;
end;

function DestroyEffect(u6: userdata, p7: number)
    task.delay(p7, function() -- Line: 45
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;

return function(u8, p9) -- Line: 50
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), Zone (copy), Lighting (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u10 = workspace:GetServerTimeNow() - p9.TimeSent;
    SfxManager:playSound({
        Sound = "ClutchAwakenMove",
        Duration = 7,
        Parent = workspace
    });
    local u11 = 0;
    local u12 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u12 = RunService.RenderStepped:Connect(function(p13) -- Line: 60
        -- upvalues: u8 (copy), u12 (ref), u11 (ref), u10 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u8.MovementController.States.Ability == false then
            u12:Disconnect();

            return;
        end;

        if u11 <= 0 then
            u11 = p13 * 60 * u10;
        end;

        u11 = u11 + p13 * 60;
        local v14 = script_Fov[math.ceil(u11)];

        if v14 ~= nil then
            if math.ceil(u11) >= #script_Fov then
                u12:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v14, p13 * 6);
        end;
    end);
    task.delay(5.5 - u10, function() -- Line: 79
        -- upvalues: u12 (ref)
        u12:Disconnect();
    end);
    local Character = p9.Character;
    Zone(u8, {
        Hide = true,
        Time = 5.5,
        Char = Character
    });

    if not Character:FindFirstChild("HumanoidRootPart") then
        local _ = Character.PrimaryPart;
    end;

    local Torso = Character:FindFirstChild("Torso");
    local BALL = Character:FindFirstChild("BALL", true);
    local Highlight = Character:FindFirstChild("Highlight");
    local CamRig = workspace:FindFirstChild("CamRig");
    local script_Assets = script.Assets;
    local u15 = script.ClutchAwakeningAbility:Clone();
    u15.Parent = Lighting;
    local u16 = Lighting.ClutchAwakeningAbility["Clutch Awakening Atmosphere"];
    local u17 = {};
    local v18 = {};
    local v19 = {};

    for _, v in { "Density", "Offset", "Color", "Decay", "Haze" } do
        u17[v] = u16[v];
        u16[v] = Lighting.Atmosphere[v];
        v18[v] = Lighting.Atmosphere[v];
    end;

    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    local v20 = script_Assets.BallFX:Clone();
    v20.CFrame = BALL.CFrame;
    v20.Parent = workspace.Debris;
    EnableVFX(v20, true);
    Weld(v20, BALL);
    DestroyEffect(v20, 5.1);
    task.wait(0.69);
    local v21 = script_Assets.CatchEmit:Clone();
    v21.CFrame = Torso.CFrame;
    v21.Parent = workspace.Debris;
    EmitAll(v21:GetDescendants());
    DestroyEffect(v21, 2);
    Highlight.FillTransparency = 0.35;
    TweenService:Create(Highlight, TweenInfo.new(1.2, Enum.EasingStyle.Linear), {
        FillTransparency = 1
    }):Play();
    task.wait(0.63);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    u16.Parent = Lighting;
    TweenService:Create(u16, TweenInfo.new(0.355, Enum.EasingStyle.Linear), u17):Play();
    local v22 = script_Assets.StartUpEmit:Clone();
    v22.Position = Torso.Position;
    v22.Parent = workspace.Debris;
    EmitAll(v22:GetDescendants());
    DestroyEffect(v22, 1);
    local v23 = script_Assets.EnablingStarter:Clone();
    v23:PivotTo(CFrame.new(Torso.Position));
    v23.Parent = workspace.Debris;
    Weld(v23.PrimaryPart, Torso);
    EnableVFX(v23, true);
    DestroyEffect(v23, 4);
    local PointLight = v23:FindFirstChild("EnablingStarterVFX").PointLight.PointLight;
    local Brightness = PointLight.Brightness;
    local Range = PointLight.Range;
    PointLight.Brightness = 0;
    PointLight.Range = 0;
    PointLight.Enabled = false;
    TweenService:Create(PointLight, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
        Brightness = Brightness,
        Range = Range
    }):Play();

    for _, child in script_Assets.SpeedlineCameraFX:Clone():GetChildren() do
        child.Parent = CamRig;
    end;

    for _, child in Character:GetChildren() do
        if child.Name ~= "HumanoidRootPart" and child:IsA("BasePart") then
            local v24 = child;

            for _, child2 in script_Assets.AuraCharFX:Clone():GetChildren() do
                child2.Parent = v24;
                table.insert(v19, child2);
            end;
        end;
    end;

    task.spawn(function() -- Line: 175
        -- upvalues: script_Assets (copy), Torso (copy), RunService (ref)
        for i = 1, 12 do
            local math_random_ret = math.random(3, 10);
            local u25 = i * 1.5707963267948966;
            local u26 = 0;
            local u27 = Random.new():NextNumber(3, 14);
            local u28 = 0;
            local u29 = script_Assets.Trail:Clone();
            u29.CFrame = Torso.CFrame;
            u29.Parent = workspace.Debris;
            local os_clock_ret = os.clock();
            local u30 = nil;
            u30 = RunService.Heartbeat:Connect(function(p31) -- Line: 189
                -- upvalues: u26 (ref), u27 (copy), i (copy), u28 (ref), u29 (copy), Torso (ref), math_random_ret (copy), u25 (copy), os_clock_ret (copy), u30 (ref)
                u26 = u26 + p31 * u27 * (i % 2 == 0 and 1 or -1);
                u28 = u28 + p31 * 6;
                local CFrame2 = Torso.CFrame;
                local v32 = math_random_ret * math.sin(u26 + u25);
                local v33 = math_random_ret * math.cos(u26 + u25);
                u29.CFrame = CFrame2 + Vector3.new(v32, u28, v33);

                if os.clock() - os_clock_ret >= 1 then
                    u30:Disconnect();
                    EnableVFX(u29, false);
                    DestroyEffect(u29, 0.5);
                end;
            end);
            task.wait(0.025);
            local _ = i;
        end;
    end);
    task.wait(2.01);
    EnableVFX(CamRig, false);
    EnableVFX(v23, false);
    local v34 = script_Assets.Jump:Clone();
    v34.Position = Torso.Position;
    v34.Parent = workspace.Debris;
    EmitAll(v34:GetDescendants());
    DestroyEffect(v34, 2);
    task.wait(0.9);
    TweenService:Create(u16, TweenInfo.new(0.755, Enum.EasingStyle.Cubic), v18):Play();
    TweenService:Create(PointLight, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
        Brightness = 0,
        Range = 0
    }):Play();

    for _, v in ipairs(v19) do
        if v:IsA("ParticleEmitter") then
            v:Destroy();
        end;
    end;

    task.delay(0.355, function() -- Line: 229
        -- upvalues: u16 (copy), Lighting (ref), TweenService (ref), u17 (copy)
        task.wait(0.5);
        u16.Parent = Lighting:FindFirstChild("HyugaAwakeningAbility");
        TweenService:Create(u16, TweenInfo.new(0.755, Enum.EasingStyle.Cubic), u17):Play();
    end);
    EnableVFX(v20, false);
    local v35 = script_Assets.ShootEffect:Clone();
    v35.CFrame = Torso.CFrame * CFrame.new(0, 0, -1.5);
    v35.Parent = workspace.Debris;
    EmitAll(v35:GetDescendants());
    DestroyEffect(v35, 3);
    task.delay(1, function() -- Line: 243
        -- upvalues: u15 (copy), u16 (copy)
        u15:Destroy();
        u16:Destroy();
    end);
end;