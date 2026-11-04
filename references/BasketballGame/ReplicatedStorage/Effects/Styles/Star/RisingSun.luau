 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local u1 = { "Head", "Torso", "Left Arm", "Right Arm" };

return function(u2, p3) -- Line: 19
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy), u1 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u4 = workspace:GetServerTimeNow() - p3.TimeSent;
    SfxManager:playSound({
        Sound = "MeteorAwakenMove2",
        Parent = workspace
    });
    local CamRig = workspace:FindFirstChild("CamRig");
    local u5 = 0;
    local u6 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 30
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
    task.delay(16.1 - u4, function() -- Line: 48
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);
    local Character = p3.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if CamRig then
        local camera = CamRig:FindFirstChild("camera");

        if not camera then
            print("wat the");
        end;

        local u9 = script.CameraFX:Clone();
        u9.Parent = CamRig;

        for _, child in u9:GetChildren() do
            task.spawn(function() -- Line: 65
                -- upvalues: child (copy), camera (copy), CamRig (copy)
                child.CFrame = camera.CFrame;
                local v10 = child:FindFirstChildWhichIsA("WeldConstraint");

                if v10 then
                    v10.Part0 = child;
                    v10.Part1 = CamRig:FindFirstChild("camera");
                end;
            end);
        end;

        for _, descendant in u9:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local Attribute = descendant:GetAttribute("EmitDuration");
                local Attribute2 = descendant:GetAttribute("EmitStart");
                task.delay(Attribute2, function() -- Line: 79
                    -- upvalues: descendant (copy), Attribute (copy)
                    descendant.Enabled = true;
                    task.wait(Attribute);
                    descendant.Enabled = false;
                end);
            end;
        end;

        task.delay(14, function() -- Line: 87
            -- upvalues: u9 (copy)
            if u9 then
                u9:Destroy();
            end;
        end);
    end;

    local u11 = script.AllVFX:Clone();
    u11.Parent = workspace.Debris;
    u11.PrimaryPart.CFrame = HumanoidRootPart.CFrame;

    for _, child in u11:GetChildren() do
        if child:GetAttribute("Emit") then
            local Attribute = child:GetAttribute("Time");
            task.delay(Attribute - u4, function() -- Line: 103
                -- upvalues: VfxManager (ref), child (copy)
                VfxManager.Emit(child);
            end);
        end;
    end;

    local function Emit(p12) -- Line: 109
        for _, descendant in ipairs(p12:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                local _ = descendant:GetAttribute("EmitDelay") or 0;
                local u13 = descendant:GetAttribute("EmitCount") or 1;
                local u14 = descendant:GetAttribute("EmitDuration") or 0;
                task.spawn(function() -- Line: 115
                    -- upvalues: descendant (copy), u13 (copy), u14 (copy)
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(u13);
                    end;

                    if u14 > 0 then
                        descendant.Enabled = true;
                        task.wait(u14);
                        descendant.Enabled = false;
                    end;
                end);
            end;
        end;
    end;

    local u15 = script.CutsceneBloom:Clone();
    local u16 = script.CutsceneCorrectionColor:Clone();
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(255, 120, 30);
    Highlight.FillTransparency = 0.8;
    Highlight.OutlineColor = Color3.new(255, 200, 61);
    Highlight.OutlineTransparency = 0;
    local BALL = Character:FindFirstChild("BALL", true);
    local u17 = {};
    task.delay(2.633 - u4, function() -- Line: 144
        -- upvalues: Highlight (copy), Character (copy), u15 (copy), u16 (copy), u11 (copy), Essentials (ref), Emit (copy), u1 (ref), u17 (copy), BALL (copy)
        Highlight.Parent = Character;
        game.Lighting.Atmosphere.Density = 0;
        u15.Parent = game.Lighting;
        u16.Parent = game.Lighting;
        local EyeVFXKagami = u11.EyeVFXKagami;
        EyeVFXKagami.CFrame = Character:FindFirstChild("Head").CFrame;
        EyeVFXKagami.Anchored = false;
        Essentials:Weld(Character:FindFirstChild("Head"), EyeVFXKagami);
        Emit(EyeVFXKagami);
        Emit(u11.SpaceZone);
        local GalaxyBackground = u11.GalaxyBackground;
        Emit(GalaxyBackground);

        for _, descendant in pairs(GalaxyBackground:GetDescendants()) do
            if descendant:IsA("Part") then
                descendant.Transparency = 0;
            end;
        end;

        u11.SpaceZone.Transparency = 0;
        local script_Sweat = script.Sweat;

        for _, v in u1 do
            local v18 = Character:FindFirstChild(v);

            if v18 then
                for _, child in script_Sweat:GetChildren() do
                    local v19 = child:Clone();
                    v19.Parent = v18;
                    u17[v19] = v19;
                end;
            end;
        end;

        for _, child in script.BALLStuff:GetChildren() do
            local v20 = child:Clone();
            v20.Parent = BALL;
            u17[v20] = v20;
        end;

        local Highlight2 = Instance.new("Highlight");
        Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight2.FillColor = Color3.fromRGB(255, 120, 30);
        Highlight2.FillTransparency = 0.8;
        Highlight2.OutlineColor = Color3.new(255, 200, 61);
        Highlight2.OutlineTransparency = 0;
        Highlight2.Name = "BallHighlight";
        Highlight2.Parent = BALL;
        u17[Highlight2] = Highlight2;
    end);
    task.delay(14.4 - u4, function() -- Line: 207
        -- upvalues: u11 (copy), Emit (copy), u15 (copy), u16 (copy), Highlight (copy), u17 (copy)
        Emit(u11.DunkVFX);
        u15:Destroy();
        u16:Destroy();
        Highlight:Destroy();
        game.Lighting.Atmosphere.Density = 0.3;

        for _, descendant in pairs(u11.GalaxyBackground:GetDescendants()) do
            if descendant:IsA("Part") then
                descendant.Transparency = 1;
            end;
        end;

        for _, v in u17 do
            v:Destroy();
        end;

        u11.SpaceZone.Transparency = 1;
        task.delay(3, function() -- Line: 230
            -- upvalues: u11 (ref)
            u11:Destroy();
        end);
    end);
end;