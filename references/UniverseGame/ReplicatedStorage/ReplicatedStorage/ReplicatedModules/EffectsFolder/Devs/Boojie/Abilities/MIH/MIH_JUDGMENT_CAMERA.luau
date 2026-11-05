  

 

local AnimationHandler = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);

return function(p1) -- Line: 2
    -- upvalues: AnimationHandler (copy)
    if game.Players.LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local CurrentCamera = workspace.CurrentCamera;
    local HumanoidRootPart = p1.HumanoidRootPart;
    local _ = p1.Humanoid;
    local u2 = game.ReplicatedStorage["Client Assets"]["Made In Heaven"].Camera:Clone();
    u2.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
    u2.Parent = workspace.Effects;
    u2.camerarootpart.Anchored = true;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u3 = false;
    task.spawn(function() -- Line: 20
        -- upvalues: u3 (ref), u2 (copy), HumanoidRootPart (copy), CurrentCamera (copy)
        while not u3 do
            u2.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            CurrentCamera.CFrame = u2.camera.CFrame;
            task.wait();
        end;
    end);
    local v4 = AnimationHandler.CreateAnimationByName("Made In Heaven", nil, "DivineJudgmentCamera");
    local v5 = u2.AnimationController.Animator:LoadAnimation(v4);
    v5:Play();
    v5.Stopped:Wait();
    u3 = true;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u2:Destroy();
end;