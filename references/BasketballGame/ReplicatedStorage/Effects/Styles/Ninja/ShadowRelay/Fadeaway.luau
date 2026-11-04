 
 

game:GetService("RunService");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u1 = require("@game/ReplicatedStorage/Packages/Janitor");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u3 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");
local u4 = require("@game/ReplicatedStorage/Shared/Utility/Sequencer");
local Debris = workspace:WaitForChild("Debris");

return function(p5: any, p6: table) -- Line: 15
    -- upvalues: Players (copy), u1 (copy), u3 (copy), u4 (copy), Debris (copy), u2 (copy)
    local TimeSent = p6.TimeSent;
    local v7 = workspace:GetServerTimeNow() - TimeSent;
    local math_max_ret = math.max(1.15 - v7, 0);

    if math_max_ret <= 0.1 then
        return;
    end;

    local Character = p6.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    Players:GetPlayerFromCharacter(Character);
    local u8 = u1.new();
    u8:Add(task.delay(math_max_ret, function() -- Line: 30
        -- upvalues: u8 (copy)
        u8:Destroy();
    end));
    u3:playSound({
        Sound = "BBZ Ninja Ninja Fade",
        Parent = HumanoidRootPart
    }).TimePosition = v7;
    u8:Add(u4({
        [0] = function() -- Line: 38
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref)
            local v9 = script.Step:Clone();
            task.delay(3, v9.Destroy, v9);
            v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                -0.47064209,
                -3.02500439,
                -0.213685989,
                -1.00000143,
                5.02914936e-8,
                2.23517844e-8,
                -5.02914972e-8,
                1.00000274,
                1.45985169e-7,
                2.23517862e-8,
                -1.45985169e-7,
                -1.00000274
            );
            v9.Parent = Debris;
            u2.emit(v9);
        end,

        [39] = function() -- Line: 46
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref)
            local v10 = script.throew:Clone();
            task.delay(3, v10.Destroy, v10);
            v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                -0.47064209,
                1.8100059,
                -0.213693619,
                1.00000143,
                5.02914936e-8,
                -2.23517844e-8,
                5.02914972e-8,
                1.00000274,
                -1.45985169e-7,
                -2.23517862e-8,
                -1.45985169e-7,
                1.00000274
            );
            v10.Parent = Debris;
            u2.emit(v10);
        end
    }, {
        FPS = 60,
        PassedTime = v7
    }));
end;