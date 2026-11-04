  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://110734267749399",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 10, Name: effect
        -- upvalues: Trove (copy)
        local v5 = Trove.new();
        local v6 = script:FindFirstChild("Props"):Clone();
        local v7 = {};

        for _, child in v6:GetChildren() do
            if child:IsA("BasePart") then
                child.CanCollide = false;
                child.Massless = true;
                child.Anchored = false;
                child.Parent = workspace.Debris;
                v7[child.Name] = child;
                v5:Add(child);
            end;
        end;

        for _, v in v7 do
            for _, child in v:GetChildren() do
                if child:IsA("Motor6D") then
                    if child.Part0 then
                        local v8 = v7[child.Part0.Name];

                        if v8 then
                            child.Part0 = v8;
                        end;
                    else
                        local ConnectTo = child:FindFirstChild("ConnectTo");

                        if ConnectTo then
                            child.Part0 = p2:FindFirstChild(ConnectTo.Value);
                        end;
                    end;

                    if child.Part1 then
                        local v9 = v7[child.Part1.Name];

                        if v9 then
                            child.Part1 = v9;
                        end;
                    else
                        local ConnectToPart1 = child:FindFirstChild("ConnectToPart1");

                        if ConnectToPart1 then
                            child.Part1 = p2:FindFirstChild(ConnectToPart1.Value);
                        end;
                    end;
                end;
            end;
        end;

        local v10 = p2:FindFirstChildWhichIsA("BodyColors");

        if v10 then
            local LeftArmColor3 = v10.LeftArmColor3;

            for _, v in v7 do
                if v:IsA("UnionOperation") then
                    v.Color = LeftArmColor3;
                end;
            end;
        end;

        v6:Destroy();

        return v5;
    end
});