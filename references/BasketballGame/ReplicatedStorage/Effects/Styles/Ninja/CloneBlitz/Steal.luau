 
 

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u1 = require("@game/ReplicatedStorage/Packages/Janitor");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u3 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");
local u4 = require("@game/ReplicatedStorage/Shared/Utility/Sequencer");
local Debris = workspace:WaitForChild("Debris");

return function(p5: any, p6: table) -- Line: 16
    -- upvalues: Players (copy), u1 (copy), u4 (copy), Debris (copy), u2 (copy), ReplicatedStorage (copy), u3 (copy)
    local TimeSent = p6.TimeSent;
    local v7 = workspace:GetServerTimeNow() - TimeSent;
    local math_max_ret = math.max(1.2833333333333334 - v7, 0);

    if math_max_ret <= 0.1 then
        return;
    end;

    local Character = p6.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    Players:GetPlayerFromCharacter(Character);
    local _ = HumanoidRootPart.CFrame;
    Character.Archivable = true;
    local u8 = u1.new();
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    u8:Add(function() -- Line: 38
        -- upvalues: Humanoid (copy)
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
    end, true, "ShowName");
    u8:Add(u4({
        [0] = function() -- Line: 43
        end,

        [9] = function() -- Line: 46
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref)
            local v9 = script.Jump:Clone();
            task.delay(3, v9.Destroy, v9);
            v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.207305908, 1.07836103, 0.500007629, -1, 0, 8.74227766e-8, 0, 1, 0, -8.74227766e-8, 0, -1);
            v9.Parent = Debris;
            u2.emit(v9);
        end,

        [22] = function() -- Line: 53
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref)
            local v10 = script.pass:Clone();
            task.delay(3, v10.Destroy, v10);
            v10:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.207321167, 13.5289783, -5.15101814, -1, 0, 8.74227766e-8, 0, 1, 0, -8.74227766e-8, 0, -1));
            v10.Parent = Debris;
            u2.emit(v10);
        end,

        [43] = function() -- Line: 60
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref)
            local v11 = script.Emit:Clone();
            task.delay(3, v11.Destroy, v11);
            v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.207321167, 6.99783373, -16.5971375, -1, 0, 8.74227766e-8, 0, 1, 0, -8.74227766e-8, 0, -1);
            v11.Parent = Debris;
            u2.emit(v11);
        end
    }, {
        FPS = 60,
        PassedTime = v7
    }));
    u8:Add(task.delay(math_max_ret, function() -- Line: 72
        -- upvalues: u8 (copy)
        u8:Destroy();
    end));

    for i = 1, 2 do
        local u12 = u8:Add(Character:Clone());
        u12.PlrBall:Destroy();
        u12.Humanoid.RequiresNeck = false;
        u12.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        u12.PrimaryPart = u12.HumanoidRootPart;
        u12.PrimaryPart.Anchored = true;
        local v13 = i;

        for _, v in u12:QueryDescendants("Script,LocalScript") do
            v:Destroy();
        end;

        if u12:FindFirstChild("Torso") and (u12:FindFirstChild("FrontJersey") and u12:FindFirstChild("BackJersey")) then
            u12.FrontJersey.Adornee = u12.Torso;
            u12.BackJersey.Adornee = u12.Torso;
        end;

        u12.Parent = workspace.Debris;
        local u14 = u8:Add(u12.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Ninja[`BlockShotClone{v13}`]));
        u14:Play();
        local u15 = false;
        local u16 = false;
        u8:Add(task.spawn(function() -- Line: 102
            -- upvalues: u12 (copy), u14 (copy), u15 (ref), HumanoidRootPart (copy), TimeSent (copy)
            u12:PivotTo(CFrame.new(0, 10000, 0));

            repeat
                task.wait();
            until u14.Length > 0 or (u12 == nil or u12.Parent == nil);

            if u12 == nil or u12.Parent == nil then
                return;
            end;

            u15 = true;
            u12:PivotTo(HumanoidRootPart.CFrame);
            u14.TimePosition = workspace:GetServerTimeNow() - TimeSent;
        end));
        u8:Add(task.delay(1.1166666666666667 - v7, function() -- Line: 111
            -- upvalues: u16 (ref), u12 (copy), u8 (copy)
            u16 = false;
            u12:Destroy();
            u8:Remove("ShowName");
        end));

        if v13 == 2 then
            u8:Add(task.delay(0.4666666666666667 - v7, function() -- Line: 118
                -- upvalues: u12 (copy), u2 (ref)
                local v17 = script.A2:Clone();
                task.delay(3, v17.Destroy, v17);
                v17.Parent = u12.Torso;
                u2.emit(v17);
            end));
        elseif v13 == 1 and v13 == 2 then
            u8:Add(task.delay(0.5166666666666667 - v7, function() -- Line: 126
                -- upvalues: u12 (copy), u2 (ref)
                local v18 = script.A2:Clone();
                task.delay(3, v18.Destroy, v18);
                v18.Parent = u12.Torso;
                u2.emit(v18);
            end));
        end;
    end;

    u3:playSound({
        Sound = "BBZ Ninja Shadow Block",
        Parent = HumanoidRootPart
    }).TimePosition = v7;
end;