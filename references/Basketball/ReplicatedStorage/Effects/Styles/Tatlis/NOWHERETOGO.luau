 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), Debris (copy), VfxManager (copy), SfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    Char:FindFirstChild("Left Arm");
    Char:FindFirstChild("Head");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task ~= "END" then
        if p2.Task ~= "Initiate" then
            if p2.Task == "Final" then
                local stunPart = p2.stunPart;
                local u3 = script.PAINTFINAL:Clone();

                if stunPart then
                    u3:PivotTo(stunPart.CFrame * CFrame.Angles(0, 0, 1.5707963267948966));
                end;

                u3.Parent = Debris;
                VfxManager.Enable(u3, true);
                local u4 = SfxManager:playSound({
                    Sound = "BBZ Tatlis Snap PaintPuddleLoop",
                    Parent = u3.PrimaryPart
                });
                task.delay(2, function() -- Line: 68
                    -- upvalues: VfxManager (ref), u3 (copy), u4 (copy)
                    VfxManager.Enable(u3, false);
                    VfxManager.DestroyEffect(u3, 3);
                    u4:Destroy();
                end);
                Essentials:UnhideCharacter(Char, { Char:FindFirstChild("BALL", true), Char:FindFirstChild("PlrBall") });
                local v5 = script.StartupImpact:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.9828461408615112, -1.4171972274780273, 0.547882080078125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 3);
            end;

            return;
        end;

        local u6 = { Char:FindFirstChild("BALL", true), Char:FindFirstChild("PlrBall") };
        Essentials:HideCharacter(Char, u6, nil, 0.0001);
        task.delay(10, function() -- Line: 53
            -- upvalues: Essentials (ref), Char (copy), u6 (copy)
            Essentials:UnhideCharacter(Char, u6);
        end);

        return;
    end;

    local stunPart = p2.stunPart;
    local u7 = script.PAINTEND:Clone();
    u7:PivotTo(stunPart.CFrame * CFrame.Angles(0, 0, 1.5707963267948966));
    u7.Parent = Debris;
    VfxManager.Enable(u7, true);
    local u8 = SfxManager:playSound({
        Sound = "BBZ Tatlis Snap PaintPuddleLoop",
        Parent = u7.PrimaryPart
    });
    task.delay(4, function() -- Line: 38
        -- upvalues: VfxManager (ref), u7 (copy), u8 (copy)
        VfxManager.Enable(u7, false);
        VfxManager.DestroyEffect(u7, 3);
        u8:Destroy();
    end);
end;