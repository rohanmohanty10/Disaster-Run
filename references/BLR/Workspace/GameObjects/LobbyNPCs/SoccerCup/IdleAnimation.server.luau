  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Parent = script.Parent;
local Humanoid = script_Parent:WaitForChild("Humanoid");
local HumanoidRootPart = script_Parent:WaitForChild("HumanoidRootPart");
local Animator = Humanoid:WaitForChild("Animator");
local v1 = ReplicatedStorage.Assets.Misc.TrophyEmote:Clone();
v1.Parent = HumanoidRootPart;

for _, child in v1:GetChildren() do
    local v2 = child:FindFirstChildOfClass("Motor6D");

    if v2 then
        v2.Part0 = HumanoidRootPart;
        v2.Part1 = child;
    end;
end;

local v3 = ReplicatedStorage.Assets.Emotes:WaitForChild("Raise the Trophy");
task.wait(2);
local v4 = Animator:LoadAnimation(v3);
v4.Looped = true;
v4:Play();