  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: VfxManager (copy), Debris (copy), ReplicatedStorage (copy), Essentials (copy)
    local Char = p1.Char;

    if p1.Type ~= "Isagi" then
        if p1.Type == "Kaiser" then
            local v2 = script.Attachments:FindFirstChild("AttachmentKaiser"):Clone();
            v2.Parent = ReplicatedStorage.Football.Value.BallAnims.BALL;
            VfxManager.Emit(v2);
            Debris:AddItem(v2, 5);
            task.delay(0.3799999999999999, function() -- Line: 56
                -- upvalues: Char (copy), Essentials (ref), VfxManager (ref), Debris (ref)
                local v3 = script:FindFirstChild("Kaiser Drive"):Clone();
                v3.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0.0435791016, -0.406499624, 0.158615112, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                v3.Parent = workspace.Debris;
                v3.Anchored = false;
                Essentials:Weld(v3, Char.HumanoidRootPart);
                VfxManager.Emit(v3);
                Debris:AddItem(v3, 5);
                task.wait(0.5);
            end);
            task.delay(0.6999999999999997, function() -- Line: 67
                -- upvalues: Char (copy), VfxManager (ref), Debris (ref)
                local v4 = script:FindFirstChild("Kaiser Shoot"):Clone();
                v4.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-1.2673645, 0.725020409, -1.86624908, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                v4.Parent = workspace.Debris;
                VfxManager.Emit(v4);
                Debris:AddItem(v4, 5);
            end);
        end;

        return;
    end;

    task.delay(0.03, function() -- Line: 12
        -- upvalues: Char (copy), VfxManager (ref)
        local v5 = script["Isagi Dribble1"]:Clone();
        v5.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-0.87891388, -2.5, -1.6616745, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        v5.Parent = workspace.Debris;
        VfxManager.Emit(v5);
    end);
    task.delay(0.33, function() -- Line: 19
        -- upvalues: Char (copy), VfxManager (ref), Debris (ref)
        local v6 = script:FindFirstChild("Isagi Dribble2"):Clone();
        v6.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(1.21208954, -2.5, -1.6616745, -1, 0, 0, 0, 1, 0, 0, 0, -1);
        v6.Parent = workspace.Debris;
        VfxManager.Emit(v6);
        Debris:AddItem(v6, 5);
    end);
    task.delay(0.57, function() -- Line: 27
        -- upvalues: ReplicatedStorage (ref), VfxManager (ref), Debris (ref)
        local v7 = script.Attachments:FindFirstChild("AttachmentIsagi"):Clone();
        v7.Parent = ReplicatedStorage.Football.Value.BallAnims.BALL;
        VfxManager.Emit(v7);
        Debris:AddItem(v7, 5);
    end);
    task.delay(1, function() -- Line: 34
        -- upvalues: Char (copy), VfxManager (ref), Debris (ref)
        local v8 = script:FindFirstChild("Guns"):Clone();
        v8.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-0.43291473, 0.87800026, -1.38667297, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        v8.Parent = workspace.Debris;
        VfxManager.Emit(v8);
        Debris:AddItem(v8, 5);
        task.wait(0.02);
        local v9 = script:FindFirstChild("Isagi Shoot"):Clone();
        v9.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-0.87891388, 0.53700256, -3.45367432, 1, 0, 0, 0, 0, 1, 0, -1, 0);
        v9.Parent = workspace.Debris;
        VfxManager.Emit(v9);
        Debris:AddItem(v9, 5);
    end);
end;