 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Humanoid = Instance.new("Humanoid");
Humanoid.Parent = script;
local Animator = Instance.new("Animator");
Animator.Parent = Humanoid;
task.wait(1);
local v1 = nil;

for _, descendant in ReplicatedStorage.Assets.CamAnimations:GetDescendants() do
    if descendant:IsA("Animation") and descendant.AnimationId ~= "" then
        if v1 then
            v1:Stop();
        end;

        v1 = Animator:LoadAnimation(descendant);
        v1:Play();
    end;
end;

for _, descendant in script:GetDescendants() do
    if descendant:IsA("Animation") and descendant.AnimationId ~= "" then
        if v1 then
            v1:Stop();
        end;

        v1 = Animator:LoadAnimation(descendant);
        v1:Play();
    end;
end;

Humanoid:Destroy();