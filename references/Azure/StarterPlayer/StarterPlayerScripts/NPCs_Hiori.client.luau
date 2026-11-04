 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local Dummy = workspace:WaitForChild("map"):WaitForChild("lobby"):WaitForChild("hiori"):FindFirstChild("Dummy");
local u2 = {};

local function createAnimData(p3) -- Line: 18
    -- upvalues: u2 (copy)
    if not u2[p3] then
        u2[p3] = {};
    end;

    return u2[p3];
end;

LocalPlayer.CharacterAdded:Connect(function(p4) -- Line: 14, Name: characterAdded
    -- upvalues: u1 (ref)
    u1 = p4:WaitForChild("HumanoidRootPart");
end);

if not u2[Dummy] then
    u2[Dummy] = {};
end;

local v5 = u2[Dummy];
v5.Idle = animationUtil:loadAnimation(Dummy, script.Idle);
v5.Idle.Looped = true;
v5.Idle:Play();