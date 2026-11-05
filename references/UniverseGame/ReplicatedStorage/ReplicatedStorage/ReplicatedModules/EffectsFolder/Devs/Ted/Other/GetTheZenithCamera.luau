  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local CurrentCamera = workspace.CurrentCamera;
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);

return function(p2) -- Line: 4
    -- upvalues: u1 (copy), CurrentCamera (copy), Animations (copy)
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
    coroutine.wrap(function() -- Line: 21
        -- upvalues: u4 (ref), u3 (copy), HumanoidRootPart (copy), CurrentCamera (ref)
        while not u4 do
            u3.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            CurrentCamera.CFrame = u3.camera.CFrame;
            wait();
        end;
    end)();
    Animations.playClient("Nuclear Star", "GetTheZenithCamera", nil, nil, u3.AnimationController.Animator).Stopped:Wait();
    u4 = true;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u3:Destroy();
end;