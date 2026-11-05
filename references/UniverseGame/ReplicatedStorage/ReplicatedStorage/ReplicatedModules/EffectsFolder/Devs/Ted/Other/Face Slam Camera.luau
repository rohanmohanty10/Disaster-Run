  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local CurrentCamera = workspace.CurrentCamera;
local AnimationHandler = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);

return function(p2) -- Line: 4
    -- upvalues: u1 (copy), CurrentCamera (copy), AnimationHandler (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local HumanoidRootPart = p2.HumanoidRootPart;
    local _ = p2.Humanoid;
    local u3 = u1["D4C: Love Train"]["camera by kitsun2"]:Clone();
    u3.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
    u3.Parent = workspace.Effects;
    u3.camerarootpart.Anchored = true;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    workspace.CurrentCamera.FieldOfView = 70;
    local u4 = nil;
    task.spawn(function() -- Line: 23
        -- upvalues: u4 (ref), u3 (copy), HumanoidRootPart (copy), CurrentCamera (ref)
        while not u4 do
            u3.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            CurrentCamera.CFrame = u3.camera.CFrame;
            task.wait();
        end;
    end);
    local v5 = AnimationHandler.CreateAnimationByName("Killer Queen", nil, "Face Slam Camera");
    local v6 = u3.AnimationController.Animator:LoadAnimation(v5);
    v6:Play();
    v6.Stopped:Wait();
    u4 = true;
    workspace.CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u3:Destroy();
end;