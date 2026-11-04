 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local Children = workspace:WaitForChild("map"):WaitForChild("lobby"):WaitForChild("quest"):GetChildren();
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
local v5 = 0;

for _, v in Children do
    v:GetPivot();
    local Dummy = v:WaitForChild("Dummy");
    local Dummy2 = v:WaitForChild("Dummy2");

    if not u2[Dummy] then
        u2[Dummy] = {};
    end;

    local v6 = u2[Dummy];

    if not u2[Dummy2] then
        u2[Dummy2] = {};
    end;

    local v7 = u2[Dummy2];
    v6.Idle = animationUtil:loadAnimation(Dummy, script.Idle1);
    v7.Idle = animationUtil:loadAnimation(Dummy2, script.Idle2);
    v6.Idle.Looped = true;
    v7.Idle.Looped = true;
    v6.Idle:Play();
    v7.Idle:Play();
    v6.Close = animationUtil:loadAnimation(Dummy, script.Close1);
    v7.Close = animationUtil:loadAnimation(Dummy2, script.Close2);
    v6.Close.Priority = Enum.AnimationPriority.Action2;
    v7.Close.Priority = Enum.AnimationPriority.Action2;
end;

while task.wait() do
    if u1 then
        for _, v in Children do
            local Pivot = v:GetPivot();
            local Dummy = v.Dummy;
            local Dummy2 = v.Dummy2;

            if not u2[Dummy] then
                u2[Dummy] = {};
            end;

            local v8 = u2[Dummy];

            if not u2[Dummy2] then
                u2[Dummy2] = {};
            end;

            local v9 = u2[Dummy2];

            if (Pivot.Position - u1.Position).Magnitude < 10 and not (v8.Close.IsPlaying or (v9.Close.IsPlaying or os.clock() - v5 <= 7)) then
                v5 = os.clock();
                v8.Close:Play();
                v9.Close:Play();
            end;
        end;

        task.wait(1);
    else
        task.wait(1);
    end;
end;