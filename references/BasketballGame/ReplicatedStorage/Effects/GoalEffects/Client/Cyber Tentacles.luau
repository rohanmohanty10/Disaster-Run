 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: Debris (copy), VfxManager (copy)
    if not p2.Preview then
        local u3 = script.Tentacles:Clone();
        u3.Parent = Debris;
        u3:PivotTo(p2.CFrame);
        u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
        VfxManager.Emit(u3.Root);
        VfxManager.Enable(u3.RootPart, true);

        for _, descendant in pairs(u3.RootPart:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "SuperTruser12345" then
                VfxManager.Enable(descendant, false);
            end;
        end;

        task.delay(0.1, function() -- Line: 31
            -- upvalues: u3 (copy), VfxManager (ref)
            for _, descendant in pairs(u3.RootPart:GetDescendants()) do
                if descendant:IsA("Attachment") and descendant.Name == "SuperTruser12345" then
                    VfxManager.Enable(descendant, true);
                end;
            end;
        end);
        task.delay(0.7833333333333333, function() -- Line: 39
            -- upvalues: u3 (copy), VfxManager (ref)
            for _, descendant in pairs(u3.RootPart:GetDescendants()) do
                if descendant:IsA("Attachment") and descendant.Name == "SuperTruser12345" then
                    VfxManager.Enable(descendant, false);
                end;
            end;
        end);
        task.delay(1.0166666666666666, function() -- Line: 47
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.Enable(u3.RootPart, false);

            for _, child in pairs(u3:GetChildren()) do
                if child:IsA("BasePart") then
                    child.Transparency = 1;
                end;
            end;
        end);
        VfxManager.DestroyEffect(u3, 6);

        return;
    end;

    local u4 = script.Tentacles:Clone();
    u4.Parent = Debris;
    u4:PivotTo(p2.CFrame * CFrame.fromOrientation(0, -1.5707963267948966, 0));
    u4:ScaleTo(0.3333333333333333);
    u4.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u4.Root);
    VfxManager.Enable(u4.RootPart, true);

    for _, descendant in pairs(u4.RootPart:GetDescendants()) do
        if descendant:IsA("Attachment") and descendant.Name == "SuperTruser12345" then
            VfxManager.Enable(descendant, false);
        end;
    end;

    task.delay(0.1, function() -- Line: 82
        -- upvalues: u4 (copy), VfxManager (ref)
        for _, descendant in pairs(u4.RootPart:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "SuperTruser12345" then
                VfxManager.Enable(descendant, true);
            end;
        end;
    end);
    task.delay(0.7833333333333333, function() -- Line: 90
        -- upvalues: u4 (copy), VfxManager (ref)
        for _, descendant in pairs(u4.RootPart:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "SuperTruser12345" then
                VfxManager.Enable(descendant, false);
            end;
        end;
    end);
    task.delay(1.0166666666666666, function() -- Line: 98
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.Enable(u4.RootPart, false);

        for _, child in pairs(u4:GetChildren()) do
            if child:IsA("BasePart") then
                child.Transparency = 1;
            end;
        end;
    end);
    VfxManager.DestroyEffect(u4, 6);
end;