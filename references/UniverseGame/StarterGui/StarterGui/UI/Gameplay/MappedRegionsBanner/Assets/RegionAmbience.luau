  

 

local v1 = {};
local Petal = _G.Petal;

if not Petal then
    repeat
        Petal = _G.Petal;
        task.wait();
    until Petal;
end;

local v2 = Petal("Util");
local u3 = Petal("New");
local Tween = v2.Tween;
v1.Sounds = {
    ["Testing Place"] = "0",
    ["Center City"] = "rbxassetid://15578030997",
    ["Knight\'s Cavern"] = "rbxassetid://17242305444",
    ["Football Field"] = "0",
    ["Desert Approach"] = "rbxassetid://15578024575",
    ["The Desert"] = "rbxassetid://15578025946",
    ["The Floating Village"] = "rbxassetid://15578029473",
    ["The Port"] = "rbxassetid://15578035574",
    ["Center Wilds"] = "0",
    ["Infernal Cairn"] = "rbxassetid://15578032272",
    ["Joestar Mansion"] = "rbxassetid://15578034627",
    ["Realm of the Forgotten"] = "rbxassetid://15578033763",
    Space = "0",
    ["The Backrooms"] = "rbxassetid://9062050871",
    ["Joestar Mansion Foyer"] = "rbxassetid://15578036412",
    ["Valentine Island"] = "0",
    ["The Colloseum"] = "rbxassetid://15578037273",
    Metro = "rbxassetid://15581509219"
};
v1.CurrentSound = nil;

function v1.CreateSoundInstance(p4, p5) -- Line: 39
    -- upvalues: u3 (copy)
    local v6 = workspace.Map:FindFirstChild("Ambience") or u3("Sound")({
        Name = "Ambience",
        Parent = workspace.Map,
        SoundGroup = game:GetService("SoundService"):WaitForChild("Ambience"),
        SoundId = p4.Sounds[p5] or "0"
    });
    v6:Play();
    p4.CurrentSound = v6;

    return v6;
end;

function v1.ChangeTo(p7, p8) -- Line: 53
    -- upvalues: Tween (copy)
    local CurrentSound = p7.CurrentSound;

    if not CurrentSound then
        return p7:CreateSoundInstance(p8);
    end;

    local v9 = CurrentSound:Clone();
    v9:Pause();
    v9.SoundId = p7.Sounds[p8] or "0";
    v9.Parent = workspace.Map;
    v9.SoundGroup = game:GetService("SoundService"):WaitForChild("Ambience");
    v9.Volume = 0;
    v9.Looped = true;
    v9:Play();
    Tween(CurrentSound, 1.5, "Quad", "InOut", {
        Volume = 0
    });
    Tween(v9, 1.5, "Quad", "InOut", {
        Volume = 1
    });
    task.delay(1.5, function() -- Line: 68
        -- upvalues: CurrentSound (copy)
        CurrentSound:Destroy();
    end);
    p7.CurrentSound = v9;

    return v9;
end;

return v1;