 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local SilverScreenEffect = require(script.Parent.Parent.ScreenEffects.SilverScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: Players (copy), SfxManager (copy), Debris (copy), VfxManager (copy), LocalPlayer (copy), SilverScreenEffect (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Monster Ascend" then
        local v4 = p2.InZone and 1.2 or 1;
        task.delay(0.43333333333333335 / v4, function() -- Line: 33
            -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            SfxManager:playSound({
                Sound = "BBZ Silver Monster Ascend Jump",
                Parent = HumanoidRootPart
            });
            local v5 = script.MonsterAscend.Jump:Clone();
            v5.Parent = Debris;
            v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, -1);
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 4);
        end);
        task.delay((1 - v3) / v4, function() -- Line: 43
            -- upvalues: LocalPlayer (ref), Character (copy), SilverScreenEffect (ref), SfxManager (ref), HumanoidRootPart (copy), Debris (ref), BALL (copy), VfxManager (ref)
            if LocalPlayer.Character == Character then
                SilverScreenEffect();
            end;

            SfxManager:playSound({
                Sound = "BBZ Silver Monster Ascend Shoot",
                Parent = HumanoidRootPart
            });
            local v6 = script.MonsterAscend.Throw:Clone();
            v6.Parent = Debris;
            v6.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(0, 1.5707963267948966, 2.0943951023931953);
            VfxManager.Emit(v6);
            VfxManager.DestroyEffect(v6, 2);
        end);

        return;
    end;

    if p2.Task ~= "Earthshaker Start" then
        if p2.Task == "Earthshaker Jump" then
            local v7 = HumanoidRootPart:FindFirstChild("BBZ Silver Earthshaker Loop");

            if v7 then
                TweenService:Create(v7, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
                VfxManager.DestroyEffect(v7, 0.25);
            end;

            SfxManager:playSound({
                Sound = "BBZ Silver Earthshaker Jump",
                Parent = HumanoidRootPart
            });

            if LocalPlayer.Character == Character then
                SilverScreenEffect();
            end;

            local v8 = script.Earthshaker.Jump:Clone();
            v8.Parent = Debris;
            v8:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v8, 2);
            shared.vfx.emit(v8);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Silver Earthshaker Start",
        Parent = HumanoidRootPart
    });
    SfxManager:playSound({
        Sound = "BBZ Silver Earthshaker Loop",
        Duration = 3,
        Parent = HumanoidRootPart
    });
end;