  

 

local _ = game.ReplicatedStorage["Client Assets"];
game:GetService("TweenService");
local _ = task.wait;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
EffectsHandler.GetEffect("Emit Particle V3");

return function(p1) -- Line: 13
    if not (p1 and p1:IsDescendantOf(workspace)) then
        return;
    end;

    if not p1:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    local Humanoid = p1:FindFirstChild("Humanoid");

    if not Humanoid then
        return;
    end;

    local Animator = Humanoid:FindFirstChild("Animator");

    if not Animator then
        return;
    end;

    local u2 = {
        CrawlTransition = { 10010413439, "Action4" },
        CrawlMovement = { 10010413439, "Action3" },
        CrawlIdle = { 10010413439, "Action3" }
    };

    local function LoadAnim(p3) -- Line: 32
        -- upvalues: u2 (copy), Animator (copy)
        local v4 = u2[p3];
        local Animation = Instance.new("Animation");
        Animation.AnimationId = `rbxassetid://{v4[1]}`;
        local v5 = Animator:LoadAnimation(Animation);
        v5.Priority = Enum.AnimationPriority[v4[2]];

        return v5;
    end;

    local CrawlTransition = u2.CrawlTransition;
    local Animation = Instance.new("Animation");
    Animation.AnimationId = `rbxassetid://{CrawlTransition[1]}`;
    local v6 = Animator:LoadAnimation(Animation);
    v6.Priority = Enum.AnimationPriority[CrawlTransition[2]];
    v6:Play();

    while v6.IsPlaying and (p1.Parent and p1:GetAttribute("Crawling")) do
        task.wait();
    end;

    if not p1.Parent then
        return;
    end;

    local CrawlIdle = u2.CrawlIdle;
    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = `rbxassetid://{CrawlIdle[1]}`;
    local v7 = Animator:LoadAnimation(Animation2);
    v7.Priority = Enum.AnimationPriority[CrawlIdle[2]];
    local CrawlMovement = u2.CrawlMovement;
    local Animation3 = Instance.new("Animation");
    Animation3.AnimationId = `rbxassetid://{CrawlMovement[1]}`;
    local v8 = Animator:LoadAnimation(Animation3);
    v8.Priority = Enum.AnimationPriority[CrawlMovement[2]];
    v7.Looped = true;
    v8.Looped = true;

    while p1.Parent and p1:GetAttribute("Crawling") do
        if Humanoid.MoveDirection.Magnitude > 0 then
            v7:Stop();

            if not v8.IsPlaying then
                v8:Play();
            end;
        else
            v8:Stop();

            if not v7.IsPlaying then
                v7:Play();
            end;
        end;

        task.wait();
    end;

    v7:Stop();
    v8:Stop();
    v6:Stop();
end;