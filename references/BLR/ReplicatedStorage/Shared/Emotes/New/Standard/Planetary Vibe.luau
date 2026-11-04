  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://114038468360892",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = script.HumanoidRootPart:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame);
        v6.Parent = workspace.Debris;
        v6.Anchored = false;
        v6.CanCollide = false;
        v6.Massless = true;
        Essentials:Weld(p2.HumanoidRootPart, v6, v6);
        v5:Add(v6);

        for _, child in script.Planets:GetChildren() do
            if child:IsA("MeshPart") then
                local v7 = child:Clone();
                local OffsetCFrame = child:FindFirstChild("OffsetCFrame");
                local v8 = OffsetCFrame and OffsetCFrame.Value or CFrame.new();
                v7.CFrame = p2.HumanoidRootPart.CFrame * v8;
                v7.Parent = workspace.Debris;
                v7.Anchored = false;
                v7.CanCollide = false;
                v7.Massless = true;
                local Weld = Instance.new("Weld");
                Weld.Part0 = p2.HumanoidRootPart;
                Weld.Part1 = v7;
                Weld.C0 = v8;
                Weld.Parent = v7;
                v5:Add(v7);
            end;
        end;

        return v5;
    end
});