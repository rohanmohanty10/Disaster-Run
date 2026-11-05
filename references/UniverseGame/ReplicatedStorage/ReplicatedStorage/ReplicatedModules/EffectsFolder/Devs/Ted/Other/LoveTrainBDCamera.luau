  

 

local TweenService = game:GetService("TweenService");
local u1 = game.ReplicatedStorage["Client Assets"];
local CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = game.Players.LocalPlayer;
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);

return function(p2) -- Line: 6
    -- upvalues: u1 (copy), CurrentCamera (copy), LocalPlayer (copy), Animations (copy), TweenService (copy)
    if game.Players.LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local HumanoidRootPart = p2.HumanoidRootPart;
    local _ = p2.Humanoid;
    local u3 = u1["D4C: Love Train"]["camera by kitsun2"]:Clone();
    u3.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
    u3.Parent = workspace.Effects;
    u3.camerarootpart.Anchored = true;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u4 = nil;
    coroutine.wrap(function() -- Line: 23
        -- upvalues: u4 (ref), CurrentCamera (ref), u3 (copy)
        while not u4 do
            CurrentCamera.CFrame = u3.camera.CFrame;
            wait();
        end;
    end)();
    local v5;

    if LocalPlayer.Settings.CameraShake.Value == false then
        v5 = Animations.playClient("Tusk", "Camera", nil, nil, u3.AnimationController.Animator);
    else
        v5 = Animations.playClient("Tusk", "ShakingCamera", nil, nil, u3.AnimationController.Animator);
    end;

    local u6 = u1["D4C: Love Train"].FrontWall:Clone();
    u6.Name = "FrontWall_" .. p2.Name;
    local u7 = u1["D4C: Love Train"].BackWall:Clone();
    u7:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 5, -35));
    u6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-1.5, 5, -17));
    u6.Parent = workspace.Effects;
    u7.Parent = workspace.Effects;
    task.delay(14.5, function() -- Line: 50
        -- upvalues: u6 (copy), TweenService (ref), u7 (copy)
        for _, descendant in pairs(u6:GetDescendants()) do
            if descendant:IsA("Beam") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 0
                }):Play();
            end;

            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Transparency = 1
                }):Play();
            end;

            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;

            if descendant:IsA("PointLight") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 0
                }):Play();
            end;
        end;

        for _, descendant in pairs(u7:GetDescendants()) do
            if descendant:IsA("Beam") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 0
                }):Play();
            end;

            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Transparency = 1
                }):Play();
            end;

            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;

            if descendant:IsA("PointLight") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 0
                }):Play();
            end;
        end;

        game.Debris:AddItem(u6, 1);
        game.Debris:AddItem(u7, 1);
    end);
    v5.Stopped:Wait();
    u4 = true;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u3:Destroy();
end;