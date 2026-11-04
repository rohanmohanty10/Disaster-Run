  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://137095847823125",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = script.Aura:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame);
        v6.Parent = workspace.Debris;
        v6.Anchored = false;
        v6.CanCollide = false;
        v6.Massless = true;
        Essentials:Weld(p2.HumanoidRootPart, v6, v6);
        v5:Add(v6);
        local v7 = script.Highlight:Clone();
        v7.Parent = p2;
        v5:Add(v7);

        for _, v in { "HRP_Attachment", "HRP_white" } do
            local v8 = script:FindFirstChild(v):Clone();
            v8.Parent = p2.HumanoidRootPart;
            v5:Add(v8);
        end;

        local v9 = script.HeadEYE:Clone();
        v9.Parent = p2.Head;
        v5:Add(v9);
        local v10 = p2:FindFirstChild("Left Arm") or p2:FindFirstChild("LeftHand");

        if v10 then
            for _, child in script:GetChildren() do
                if child.Name:find("LeftCursehand") then
                    local v11 = child:Clone();
                    v11.Parent = v10;
                    v5:Add(v11);
                end;
            end;
        end;

        local v12 = p2:FindFirstChild("Right Arm") or p2:FindFirstChild("RightHand");

        if v12 then
            for _, child in script:GetChildren() do
                if child.Name:find("RightCursehand") then
                    local v13 = child:Clone();
                    v13.Parent = v12;
                    v5:Add(v13);
                end;
            end;
        end;

        return v5;
    end
});