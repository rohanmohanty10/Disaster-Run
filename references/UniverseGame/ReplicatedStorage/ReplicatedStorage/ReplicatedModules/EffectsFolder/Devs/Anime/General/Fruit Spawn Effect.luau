  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 9
    -- upvalues: EffectsHandler (copy), Players (copy)
    if not p1 then
        return;
    end;

    local v2 = p1:WaitForChild("Mysterious Devil Fruit", 5);

    if not v2 then
        return;
    end;

    local v3 = v2:GetAttribute("Color");
    local v4 = math.floor(v3.R * 255);
    local v5 = math.floor(v3.G * 255);
    local v6 = math.floor(v3.B * 255);
    EffectsHandler.CallEffect("SystemMessage", (`[ITEM NOTIFIER] A MYSTERIOUS <font color="rgb({v4}, {v5}, {v6})">{string.upper(v2:GetAttribute("ToolName"))}</font> HAS SPAWNED!`));
    local v7 = script.BillboardGui:Clone();
    v7.Frame.Label.TextColor3 = v3;
    v7.Parent = v2;
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://17300403909";
    Sound.Volume = 10;
    Sound.Parent = workspace;
    Sound:Play();
    Sound.Stopped:Connect(function() -- Line: 36
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);

    while v7:IsDescendantOf(game) do
        local Character = Players.LocalPlayer.Character;

        if Character then
            Character = Character:WaitForChild("HumanoidRootPart", 3);
        end;

        if Character then
            v7.Frame.Label.Text = `{string.split(v2:GetAttribute("ToolName"), " Devil Fruit")[1]}: {math.floor((Character.Position - p1.Position).Magnitude)}m`;
        end;

        task.wait(0.1);
    end;

    v7:Destroy();
end;