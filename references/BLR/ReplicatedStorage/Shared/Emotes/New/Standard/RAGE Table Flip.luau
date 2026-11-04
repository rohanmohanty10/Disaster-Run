  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://111778665084468",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 10, Name: effect
        -- upvalues: Trove (copy)
        local v5 = Trove.new();

        for _, child in script:GetChildren() do
            if child:IsA("BasePart") then
                local v6 = child:Clone();
                v6.CanCollide = false;
                v6.Massless = true;
                v6.Anchored = false;
                v6.Parent = workspace.Debris;
                local v7 = v6:FindFirstChildWhichIsA("Motor6D");

                if v7 then
                    local ConnectTo = v7:FindFirstChild("ConnectTo");

                    if ConnectTo then
                        ConnectTo = p2:FindFirstChild(ConnectTo.Value);
                    end;

                    if ConnectTo then
                        v7.Part0 = ConnectTo;
                        v7.Part1 = v6;
                    end;
                end;

                v5:Add(v6);
            end;
        end;

        return v5;
    end
});