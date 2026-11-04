  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://92000422058028",
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
        local v7 = script.Head:Clone();
        v7:PivotTo(p2.Head.CFrame);
        v7.Parent = workspace.Debris;
        v7.Anchored = false;
        v7.CanCollide = false;
        v7.Massless = true;
        v7.Transparency = 1;
        Essentials:Weld(p2.Head, v7, v7);
        v5:Add(v7);
        local v8 = script.Highlight:Clone();
        v8.Parent = p2;
        v5:Add(v8);

        for _, child in script:GetChildren() do
            if child:IsA("MeshPart") then
                local v9 = child:Clone();
                local OffsetCFrame = child:FindFirstChild("OffsetCFrame");
                local v10 = OffsetCFrame and OffsetCFrame.Value or CFrame.new();
                v9.CFrame = p2.HumanoidRootPart.CFrame * v10;
                v9.Parent = workspace.Debris;
                v9.Anchored = false;
                v9.CanCollide = false;
                v9.Massless = true;
                local Weld = Instance.new("Weld");
                Weld.Part0 = p2.HumanoidRootPart;
                Weld.Part1 = v9;
                Weld.C0 = v10;
                Weld.Parent = v9;
                v5:Add(v9);
            end;
        end;

        return v5;
    end
});