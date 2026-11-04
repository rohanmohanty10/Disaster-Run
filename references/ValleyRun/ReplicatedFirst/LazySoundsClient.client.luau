 

 

local SoundService = game:GetService("SoundService");
local LazySound = require(script.Parent:WaitForChild("LazySound"));
local u1 = {
    game:GetService("ReplicatedStorage"),
    game:GetService("ReplicatedFirst"),
    game:GetService("StarterGui"),
    game:GetService("StarterPlayer")
};

local function inLibrary(p2) -- Line: 13
    -- upvalues: SoundService (copy), u1 (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio and p2:IsDescendantOf(GameAudio) then
        return true;
    end;

    for _, v in u1 do
        if p2:IsDescendantOf(v) then
            return true;
        end;
    end;

    return false;
end;

local function watch(p3) -- Line: 26
    -- upvalues: LazySound (copy), inLibrary (copy)
    local u4 = setmetatable({ p3 }, {
        __mode = "v"
    });
    p3:GetPropertyChangedSignal("Playing"):Connect(function() -- Line: 30
        -- upvalues: u4 (copy), LazySound (ref)
        local v5 = u4[1];

        if v5 and v5.Playing then
            LazySound.arm(v5);
        end;
    end);

    if p3.Playing then
        LazySound.arm(p3);

        return;
    end;

    if inLibrary(p3) then
        LazySound.stash(p3);

        return;
    end;

    if p3.SoundId ~= "" then
        LazySound.used[p3] = os.clock();
    end;
end;

game.DescendantAdded:Connect(function(p6) -- Line: 44, Name: added
    -- upvalues: watch (copy)
    if p6.ClassName == "Sound" then
        pcall(watch, p6);
    end;
end);

for _, descendant in game:GetDescendants() do
    if descendant.ClassName == "Sound" then
        pcall(watch, descendant);
    end;
end;

task.spawn(function() -- Line: 55
    -- upvalues: LazySound (copy)
    while true do
        task.wait(15);
        local os_clock_ret = os.clock();

        for i, v in LazySound.used do
            if os_clock_ret - v >= LazySound.IdleSeconds then
                if i.Playing then
                    LazySound.used[i] = os_clock_ret;
                else
                    pcall(LazySound.stash, i);
                end;
            end;
        end;
    end;
end);