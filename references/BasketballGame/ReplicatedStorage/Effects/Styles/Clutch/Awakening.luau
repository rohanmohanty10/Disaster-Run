 
 

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
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = game.Players.LocalPlayer;
local Assets = script:WaitForChild("Assets");

function EmitAll(p1: table)
    for _, v in next, p1 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 21
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
        if v.ClassName == "ParticleEmitter" or v.ClassName == "Trail" then
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
    task.delay(p7, function() -- Line: 47
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;

return function(u8, p9) -- Line: 52
    -- upvalues: Lighting (copy), SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), Effects (copy), TweenService (copy), Assets (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u10 = workspace:GetServerTimeNow() - p9.TimeSent;
    local Character = p9.Character;
    local Head = Character:FindFirstChild("Head");
    Character:FindFirstChild("Right Arm");
    Character:FindFirstChild("Right Leg");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    Character:FindFirstChild("Highlight");
    local u11 = game.Players:FindFirstChild(Character.Name) or game.Players:GetPlayerFromCharacter(Character);
    local u12 = script.ClutchAwakeningAbility:Clone();
    u12.Parent = Lighting;
    local u13 = Lighting.ClutchAwakeningAbility["Clutch Awakening Atmosphere"];
    local ClutchDof = Lighting.ClutchAwakeningAbility.ClutchDof;
    Character:FindFirstChild("BALL", true);
    local TeamMate = p9.TeamMate;
    SfxManager:playSound({
        Sound = "ClutchAwaken",
        Duration = 7,
        Parent = workspace
    });
    local u14 = 0;
    local u15 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u15 = RunService.RenderStepped:Connect(function(p16) -- Line: 78
        -- upvalues: u8 (copy), u15 (ref), u14 (ref), u10 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u8.MovementController.States.Ability == false then
            u15:Disconnect();

            return;
        end;

        if u14 <= 0 then
            u14 = p16 * 60 * u10;
        end;

        u14 = u14 + p16 * 60;
        local v17 = script_Fov[math.ceil(u14)];

        if v17 ~= nil then
            if math.ceil(u14) >= #script_Fov then
                u15:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v17, p16 * 6);
        end;
    end);
    task.delay(2.75, function() -- Line: 97
        -- upvalues: Effects (ref), u11 (copy)
        Effects:SubtitleV2({
            { u11, "Keep passing to me.", 1.5 }
        });
    end);
    task.delay(8 - u10, function() -- Line: 103
        -- upvalues: u15 (ref)
        u15:Disconnect();
    end);
    u13.Parent = Lighting;
    TweenService:Create(u13, TweenInfo.new(1.3, Enum.EasingStyle.Quad), {
        Haze = 10
    }):Play();
    TweenService:Create(ClutchDof, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {
        FarIntensity = 0.4
    }):Play();
    task.wait(1.84 - u10);

    if TeamMate then
        local v18 = Assets.QuestionMarkFX:Clone();
        v18.CFrame = TeamMate:FindFirstChild("Head").CFrame;
        v18.Parent = workspace.Debris;
        EmitAll(v18:GetDescendants());
        DestroyEffect(v18, 1);
    end;

    task.spawn(function() -- Line: 121
        -- upvalues: Assets (ref), HumanoidRootPart (copy), RunService (ref)
        for i = 1, 15 do
            local math_random_ret = math.random(2, 7);
            local u19 = i * 1.5707963267948966;
            local u20 = 0;
            local u21 = Random.new():NextNumber(1, 14);
            local u22 = 0;
            local u23 = Assets.Trail:Clone();
            u23.CFrame = HumanoidRootPart.CFrame;
            u23.Parent = workspace.Debris;
            local os_clock_ret = os.clock();
            local u24 = nil;
            u24 = RunService.Heartbeat:Connect(function(p25) -- Line: 135
                -- upvalues: u20 (ref), u21 (copy), i (copy), u22 (ref), u23 (copy), HumanoidRootPart (ref), math_random_ret (copy), u19 (copy), os_clock_ret (copy), u24 (ref)
                u20 = u20 + p25 * u21 * (i % 2 == 0 and 1 or -1);
                u22 = u22 + p25 * Random.new():NextNumber(1.5, 4);
                local CFrame2 = HumanoidRootPart.CFrame;
                local v26 = math_random_ret * math.sin(u20 + u19);
                local v27 = math_random_ret * math.cos(u20 + u19);
                u23.CFrame = CFrame2 + Vector3.new(v26, u22, v27);

                if os.clock() - os_clock_ret >= 1 then
                    u24:Disconnect();
                    EnableVFX(u23, false);
                    DestroyEffect(u23, 1.35);
                end;
            end);
            task.wait(0.06);
            local _ = i;
        end;
    end);
    task.wait(2.82);
    local v28 = Assets.EyeVFX:Clone();
    v28.CFrame = Head.CFrame;
    v28.Parent = workspace.Debris;
    Weld(v28, Head);
    DestroyEffect(v28, 1.3);
    EmitAll(v28.Emit:GetDescendants());
    EnableVFX(v28.Enabling, true);
    local v29 = Assets.SpeedlineCameraFX:Clone();
    local CamRig = workspace:FindFirstChild("CamRig");

    for _, child in v29:GetChildren() do
        child.Parent = CamRig;
    end;

    for _, descendant in v28:GetDescendants() do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local _ = descendant.Width1;
            descendant.Enabled = true;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            TweenService:Create(descendant, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                Width0 = Width0,
                Width1 = Width0
            }):Play();
        end;
    end;

    local u30 = Assets.ScopeEye:Clone();
    u30.CFrame = Head.CFrame * CFrame.new(0, 0, -2);
    u30.Parent = workspace.Debris;
    EnableVFX(u30, true);
    DestroyEffect(u30, 1.3);
    task.spawn(function() -- Line: 186
        -- upvalues: u30 (copy), Head (copy), RunService (ref)
        local v31 = 0;

        while u30.Parent ~= nil do
            v31 = v31 + 3;
            u30.CFrame = Head.CFrame * CFrame.new(0.2, 0.2, -1) * CFrame.Angles(0, 0, (math.rad(v31)));
            RunService.Heartbeat:Wait();
        end;
    end);
    local v32 = Assets.AirFX:Clone();
    v32:PivotTo(HumanoidRootPart.CFrame);
    v32.Parent = workspace.Debris;
    EnableVFX(v32, true);
    DestroyEffect(v32, 1.3);

    for _, descendant in v32:GetDescendants() do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local _ = descendant.Width1;
            descendant.Enabled = true;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            TweenService:Create(descendant, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                Width0 = Width0,
                Width1 = Width0
            }):Play();
        end;
    end;

    task.delay(1.3, function() -- Line: 211
        -- upvalues: u12 (copy), u13 (copy), ClutchDof (copy)
        u12:Destroy();

        if u13 then
            u13:Destroy();
        end;

        if ClutchDof then
            ClutchDof:Destroy();
        end;
    end);
end;