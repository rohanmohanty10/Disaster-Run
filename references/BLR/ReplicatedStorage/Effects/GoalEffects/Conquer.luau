  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), SoundManager (copy), UserInputService (copy), VfxManager (copy)
    local Conquer = ReplicatedStorage.Assets.GoalEffects.Conquer;
    local u2 = Conquer.Floor:Clone();
    local u3 = Conquer.Part:Clone();
    task.spawn(function() -- Line: 15
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("Conquer", 0.75, game.SoundService.SFX, 250);
    end);
    local Descendants = u2:GetDescendants();

    for _, v in pairs(Descendants) do
        if v:IsA("ParticleEmitter") then
            if UserInputService.TouchEnabled then
                v.Rate = v.Rate / 10;
            else
                v.Rate = v.Rate / 5;
            end;
        end;
    end;

    local Descendants2 = u3:GetDescendants();

    for _, v in pairs(Descendants2) do
        if v:IsA("ParticleEmitter") then
            if UserInputService.TouchEnabled then
                v.Rate = v.Rate / 10;
            else
                v.Rate = v.Rate / 5;
            end;
        end;
    end;

    table.clear(Descendants2);
    table.clear(Descendants);
    u2.Parent = workspace;
    u3.Parent = workspace;
    VfxManager.Enable(u3, true);
    VfxManager.Enable(u2, true);
    u2.CFrame = p1.Pos * CFrame.new(0, -0.8, 0);
    u3.CFrame = p1.Pos;
    local v4 = Conquer.Frames.Black:Clone();
    local v5 = Conquer.Frames.Dark:Clone();
    local v6 = Conquer.Frames["Dark Red"]:Clone();
    local v7 = Conquer.Frames["White+Back"]:Clone();
    v4.Parent = game.Lighting;
    task.wait(0.03);
    v4:Destroy();
    v5.Parent = game.Lighting;
    task.wait(0.03);
    v5:Destroy();
    v6.Parent = game.Lighting;
    task.wait(0.03);
    v6:Destroy();
    v7.Parent = game.Lighting;
    task.wait(0.03);
    v7:Destroy();
    local v8 = Conquer.Lighting:Clone();
    local Children = v8:GetChildren();

    for _, v in pairs(Children) do
        v.Parent = game.Lighting;
    end;

    v8:Destroy();
    task.wait(4);
    VfxManager.Enable(u3, false);
    VfxManager.Enable(u2, false);
    task.delay(2, function() -- Line: 85
        -- upvalues: u3 (copy), u2 (copy), Children (copy)
        u3:Destroy();
        u2:Destroy();

        for _, v in Children do
            v:Destroy();
        end;
    end);
end;