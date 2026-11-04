 
 

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
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Activate" then
        if p2.Task == "Activate2" then
            SfxManager:playSound({
                Sound = "BBZ Psychic Headache Victim",
                Parent = Char.Head
            });
            local Model = Instance.new("Model");
            Model.Parent = Debris;

            for _, child in script.OffBall:GetChildren() do
                if Char:FindFirstChild(child.Name) then
                    local v3 = child:Clone();
                    v3.CFrame = Char:FindFirstChild(child.Name).CFrame;
                    v3.Parent = Model;
                    Essentials:Weld(v3, Char:FindFirstChild(child.Name));
                end;
            end;

            VfxManager.Enable(Model, true);
            task.delay(2, function() -- Line: 72
                -- upvalues: Model (copy), VfxManager (ref)
                if Model then
                    VfxManager.Enable(Model, false);
                    VfxManager.DestroyEffect(Model, 3);
                end;
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Psychic teleport pass",
        Parent = HumanoidRootPart
    });
    local u4 = script.OnBall.BALL:Clone();
    u4.CFrame = BALL.CFrame;
    u4.Parent = Debris;
    Essentials:Weld(u4, BALL);
    local u5 = script.OnBall.TPImpact:Clone();
    u5.CFrame = BALL.CFrame;
    u5.Parent = Debris;
    Essentials:Weld(u5, BALL);
    task.delay(0.217, function() -- Line: 38
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.Enable(u4, true);
    end);
    task.delay(0.917, function() -- Line: 42
        -- upvalues: VfxManager (ref), u5 (copy)
        VfxManager.Emit(u5);
    end);
    task.delay(1.4, function() -- Line: 46
        -- upvalues: VfxManager (ref), u5 (copy), u4 (copy)
        VfxManager.Emit(u5);
        VfxManager.Enable(u4, false);
        VfxManager.DestroyEffect(u5, 3);
        VfxManager.DestroyEffect(u4, 3);
    end);
end;