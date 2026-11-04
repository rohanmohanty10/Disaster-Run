 
 

game:GetService("RunService");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");
game:GetService("Players");
require("@game/ReplicatedStorage/Packages/Janitor");
local u1 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");
local u3 = require("@game/ReplicatedStorage/Shared/Utility/Sequencer");
local Debris = workspace:WaitForChild("Debris");

return function(p4: any, p5: table) -- Line: 15
    -- upvalues: u3 (copy), u2 (copy), u1 (copy), Debris (copy)
    local TimeSent = p5.TimeSent;
    local v6 = workspace:GetServerTimeNow() - TimeSent;

    if math.max(1.8333333333333333 - v6, 0) <= 0.1 then
        return;
    end;

    local Character = p5.Character;
    local KuramaTransformation = Character:FindFirstChild("KuramaTransformation");

    if KuramaTransformation == nil then
        return;
    end;

    local CFrame2 = KuramaTransformation.RootPart.CFrame;
    u3({
        [0] = function() -- Line: 34
        end,

        [21] = function() -- Line: 37
            -- upvalues: u2 (ref), Character (copy), KuramaTransformation (copy), u1 (ref)
            u2:playSound({
                Sound = "BBZ Ninja Tail Bomb",
                Parent = Character.HumanoidRootPart
            });
            local v7 = script.JawVFX:Clone();
            task.delay(3, v7.Destroy, v7);
            v7.Parent = KuramaTransformation.RootPart.ROOT["ctrl-torso"].Spine.Spine1.Head.Jaw;
            u1.emit(v7);
        end,

        [56] = function() -- Line: 45
            -- upvalues: u2 (ref), Character (copy), CFrame2 (copy), Debris (ref), u1 (ref)
            u2:playSound({
                Sound = "BBZ Ninja Tail Bomb Shoot",
                Parent = Character.HumanoidRootPart
            });
            local v8 = script.Launch:Clone();
            task.delay(3, v8.Destroy, v8);
            v8.CFrame = CFrame2 * CFrame.new(0.517211914, 8.73797894, -8.52735615, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v8.Parent = Debris;
            u1.emit(v8);
        end,

        [105] = function() -- Line: 54
            -- upvalues: CFrame2 (copy), Debris (ref), u1 (ref)
            local v9 = script.Contact:Clone();
            task.delay(3, v9.Destroy, v9);
            v9.CFrame = CFrame2 * CFrame.new(0.517211914, 8.73797798, -56.0048218, -1, 0, 0, 0, 1, 0, 0, 0, -1);
            v9.Parent = Debris;
            u1.emit(v9);
        end
    }, {
        FPS = 60,
        PassedTime = v6
    });
end;