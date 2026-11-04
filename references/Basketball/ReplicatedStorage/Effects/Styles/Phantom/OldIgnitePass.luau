 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 12
    -- upvalues: VfxManager (copy), TweenService (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u4 = script["Right Arm"].Grip:Clone();
    u4.Parent = Character:FindFirstChild("Right Arm");
    task.delay(0.15 - v3, function() -- Line: 21
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.Emit(u4);
        task.wait(2);
        u4:Destroy();
    end);
    local u5 = CFrame.new(1.2, 0.5, -1) * CFrame.Angles(1.5707963267948966, 0, 0);
    local u6 = script.windBeamies["wind beams"]:Clone();
    u6.Parent = workspace.Debris;
    task.delay(0.81 - v3, function() -- Line: 30
        -- upvalues: u6 (copy), HumanoidRootPart (copy), u5 (copy), VfxManager (ref)
        u6.CFrame = HumanoidRootPart.CFrame * u5;
        VfxManager.Emit(u6["fIRST TOUCH"]);
    end);
    task.delay(1.2 - v3, function() -- Line: 35
        -- upvalues: u6 (copy), HumanoidRootPart (copy), u5 (copy), VfxManager (ref), TweenService (ref)
        u6.CFrame = HumanoidRootPart.CFrame * u5;
        VfxManager.Emit(u6);

        for _, v in {
            u6.beam1.b44,
            u6.beam2.bb33,
            u6.beam3.b22,
            u6.beam4.b11
        } do
            v.Enabled = true;
            TweenService:Create(v, TweenInfo.new(0.4), {
                TextureSpeed = 0
            }):Play();
            task.spawn(function() -- Line: 48
                -- upvalues: v (copy)
                for i = 0, 1, 0.1 do
                    v.Transparency = NumberSequence.new(i);
                    task.wait(0.07);
                    local _ = i;
                end;
            end);
        end;

        task.delay(2, function() -- Line: 57
            -- upvalues: u6 (ref)
            u6:Destroy();
        end);
    end);
end;