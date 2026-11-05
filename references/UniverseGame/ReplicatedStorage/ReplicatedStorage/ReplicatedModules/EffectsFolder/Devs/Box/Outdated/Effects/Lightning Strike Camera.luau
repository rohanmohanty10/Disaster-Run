  

 

require(game:GetService("ReplicatedStorage").ReplicatedModules.Animations);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local CurrentCamera = workspace.CurrentCamera;
local AnimationHandler = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);

return function(p2, u3, p4) -- Line: 8
    -- upvalues: Trove (copy), u1 (copy), CurrentCamera (copy), AnimationHandler (copy)
    if game.Players.LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local u5 = Trove.new();

    local function CheckAncestry(p6, p7) -- Line: 15
        -- upvalues: u5 (copy)
        if not p7 then
            u5:Destroy();
        end;
    end;

    u5:Connect(p2.AncestryChanged, CheckAncestry);
    u5:Connect(p4.AncestryChanged, CheckAncestry);
    local _ = p2.HumanoidRootPart;
    local _ = p2.Humanoid;
    local u8 = u5:Add(u1.Assets.Abilities["Weather Report"].CameraMan:Clone());
    u8.PrimaryPart.CFrame = u3.CFrame;
    u8.PrimaryPart.Anchored = true;
    u8.Parent = workspace.Effects;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u9 = nil;
    task.spawn(function() -- Line: 32
        -- upvalues: u9 (ref), u8 (copy), u3 (copy), CurrentCamera (ref)
        while not u9 do
            u8.PrimaryPart.CFrame = u3.CFrame;
            CurrentCamera.CFrame = u8.Head.CFrame;
            task.wait();
        end;
    end);
    u5:Add(function() -- Line: 40
        -- upvalues: u9 (ref), CurrentCamera (ref)
        u9 = true;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
    end);
    local v10 = AnimationHandler.CreateAnimationByName("Weather Report", nil, "Lightning Strike Camera");
    local v11 = u8.AnimationController:LoadAnimation(v10);
    v11.Priority = Enum.AnimationPriority.Action4;
    v11:Play();
    u5:Add(v11);
    task.delay(8, u5.Destroy, u5);
end;