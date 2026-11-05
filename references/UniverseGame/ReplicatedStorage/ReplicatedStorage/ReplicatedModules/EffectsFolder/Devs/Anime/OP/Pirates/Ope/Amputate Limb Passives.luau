  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

return function(p2, p3, p4) -- Line: 9
    -- upvalues: EffectsHandler (copy), u1 (copy)
    local HumanoidRootPart = p2.HumanoidRootPart;

    while p2:IsDescendantOf(game) and p2:GetAttribute("Amputated") do
        EffectsHandler.CallEffect("Generate Quasiduck Lightning", p2, {
            Size = 0.2,
            Color = ColorSequence.new(p4 or Color3.fromRGB(97, 118, 236)),
            Speed = u1:NextNumber(9.25, 10.75),
            CFrames = { HumanoidRootPart.CFrame * CFrame.new(u1:NextNumber(-2, 2), math.random(-3, 2), u1:NextNumber(-1.5, 1.5)), p3[math.random(1, #p3)].Part1.CFrame * CFrame.new(u1:NextNumber(-1, 1), u1:NextNumber(-1.35, 0.85), u1:NextNumber(-1, 1)) },
            Length = u1:NextNumber(0.9, 1.5)
        }).Frequency = u1:NextNumber(0.4, 0.9);
        task.wait(u1:NextNumber(0.2, 0.8));
    end;
end;