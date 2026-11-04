  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(u2, p3) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), CollectionService (copy)
    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(u2);
    local u4 = nil;
    local u5 = {};
    local u6 = nil;

    local function returnAccessories() -- Line: 20
        -- upvalues: u6 (ref), u5 (copy), u2 (copy), u4 (ref)
        if u6 then
            return;
        end;

        u6 = true;

        for i, _ in u5 do
            i.Parent = u2;
        end;

        if u4 then
            u4:Disconnect();
        end;
    end;

    for _, child in ReplicatedStorage.Assets.Misc.FriesOutfit:GetChildren() do
        if u2:FindFirstChild(child.Name) and child:IsA("BasePart") then
            local v7 = child:Clone();
            v7:PivotTo(u2[child.Name]:GetPivot());

            if child.Name == "Torso" then
                v7:PivotTo(v7:GetPivot() * CFrame.new(0, -0.4, 0));
            end;

            if child.Name == "Left Arm" then
                v7:PivotTo(v7:GetPivot() * CFrame.new(-0.05, 0, 0));
            end;

            if child.Name == "Right Arm" then
                v7:PivotTo(v7:GetPivot() * CFrame.new(0.05, 0, 0));
            end;

            if child.Name == "Head" then
                v7:PivotTo(v7:GetPivot() * CFrame.new(0, 0.35, -0.2));
            end;

            v7.Parent = u2[child.Name];

            if child.Name ~= "Left Arm" and child.Name ~= "Right Arm" then
                u2[child.Name].Transparency = 1;
            end;

            Essentials:Weld(v7, u2[child.Name]);
            CollectionService:AddTag(v7, (`Cosmetic{p3}`));
        end;
    end;

    for _, child in u2:GetChildren() do
        if child:IsA("Accessory") then
            u5[child] = true;
            child.Parent = nil;
        end;
    end;

    u4 = u2.ChildAdded:Connect(function(p8) -- Line: 68
        -- upvalues: u5 (copy)
        if p8:IsA("Accessory") then
            u5[p8] = true;
            p8.Parent = nil;
        end;
    end);

    if PlayerFromCharacter then
        PlayerFromCharacter:GetAttributeChangedSignal((`EquippedCosmetic{p3}`)):Once(function() -- Line: 76
            -- upvalues: ReplicatedStorage (ref), u2 (copy), u6 (ref), u5 (copy), u2 (copy), u4 (ref)
            for _, child in ReplicatedStorage.Assets.Misc.FriesOutfit:GetChildren() do
                local v9 = u2:FindFirstChild(child.Name);

                if v9 and child:IsA("BasePart") then
                    v9.Transparency = 0;
                end;
            end;

            if u6 then
                return;
            end;

            u6 = true;

            for i, _ in u5 do
                i.Parent = u2;
            end;

            if u4 then
                u4:Disconnect();
            end;
        end);
    end;
end;

return v1;