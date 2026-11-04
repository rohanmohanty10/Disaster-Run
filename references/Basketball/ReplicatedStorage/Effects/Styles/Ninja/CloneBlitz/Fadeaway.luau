 
 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u1 = require("@game/ReplicatedStorage/Packages/Janitor");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u3 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");
local u4 = require("@game/ReplicatedStorage/Shared/Utility/Sequencer");
local Debris = workspace:WaitForChild("Debris");

return function(p5: any, p6: table) -- Line: 15
    -- upvalues: Players (copy), u1 (copy), u3 (copy), u4 (copy), Debris (copy), u2 (copy), TweenService (copy)
    local TimeSent = p6.TimeSent;
    local u7 = workspace:GetServerTimeNow() - TimeSent;
    local math_max_ret = math.max(1.0333333333333334 - u7, 0);

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
    local u9 = u8:Add(script.Highlight:Clone());
    u9.Parent = Character;
    u3:playSound({
        Sound = "BBZ Ninja Clone Blitz Fadeaway",
        Parent = Character.HumanoidRootPart
    }).TimePosition = u7;
    u8:Add(u4({
        [0] = function() -- Line: 41
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref), u7 (copy), TweenService (ref), u9 (copy)
            local v10 = script.BodyStart:Clone();
            task.delay(3, v10.Destroy, v10);
            v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                0.108337402,
                0.585259914,
                -0.314149857,
                -1,
                1.00582916e-7,
                4.47035475e-8,
                1.0058293e-7,
                1,
                2.91969513e-7,
                -4.47035191e-8,
                2.91969513e-7,
                -1
            );
            v10.Parent = Debris;
            u2.emit(v10);
            local v11 = 0.21666666666666667 - u7;

            if v11 >= 0.1 then
                TweenService:Create(u9, TweenInfo.new(v11, Enum.EasingStyle.Linear), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                }):Play();

                return;
            end;

            u9.FillTransparency = 1;
            u9.OutlineTransparency = 1;
        end,

        [17] = function() -- Line: 60
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref), u7 (copy), u9 (copy), TweenService (ref)
            local v12 = script.BodyStart2:Clone();
            task.delay(3, v12.Destroy, v12);
            v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                0.108337402,
                0.585259914,
                -0.314149857,
                -1,
                1.00582916e-7,
                4.47035475e-8,
                1.0058293e-7,
                1,
                2.91969513e-7,
                -4.47035191e-8,
                2.91969513e-7,
                -1
            );
            v12.Parent = Debris;
            u2.emit(v12);
            task.defer(function() -- Line: 67
                -- upvalues: u7 (ref), u9 (ref), TweenService (ref)
                local v13 = 0.5166666666666667 - u7 - 0.3;

                if v13 < 0.1 then
                    u9.FillTransparency = 1;
                    u9.OutlineTransparency = 1;

                    return;
                end;

                u9.FillTransparency = 0.5;
                u9.OutlineTransparency = 0.5;
                TweenService:Create(u9, TweenInfo.new(v13, Enum.EasingStyle.Linear), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                }):Play();
            end);
        end,

        [38] = function() -- Line: 83
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref), u7 (copy), u9 (copy), TweenService (ref)
            task.defer(function() -- Line: 85
                -- upvalues: HumanoidRootPart (ref), Debris (ref), u2 (ref)
                local v14 = script.THGROW:Clone();
                task.delay(3, v14.Destroy, v14);
                v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                    -0.396316528,
                    1.40509129,
                    -1.94159889,
                    1,
                    6.47555822e-8,
                    -8.90058658e-8,
                    -1.0058293e-7,
                    0.866025269,
                    -0.500000238,
                    4.47035191e-8,
                    0.500000238,
                    0.866025269
                );
                v14.Impact_Kick.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                    -0.377593994,
                    1.20116234,
                    -1.6915884,
                    1,
                    1.00582916e-7,
                    -4.47035475e-8,
                    -1.0058293e-7,
                    1,
                    -2.91969513e-7,
                    4.47035191e-8,
                    2.91969513e-7,
                    1
                );
                v14.Parent = Debris;
                u2.emit(v14);
            end);
            local v15 = 0.85 - u7 - 0.6333333333333333;

            if v15 < 0.1 then
                u9.FillTransparency = 1;
                u9.OutlineTransparency = 1;

                return;
            end;

            u9.FillTransparency = 0.5;
            u9.OutlineTransparency = 0.5;
            TweenService:Create(u9, TweenInfo.new(v15, Enum.EasingStyle.Linear), {
                FillTransparency = 1,
                OutlineTransparency = 1
            }):Play();
        end
    }, {
        FPS = 60,
        PassedTime = u7
    }));
end;