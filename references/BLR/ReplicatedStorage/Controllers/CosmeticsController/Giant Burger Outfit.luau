  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(u2, p3) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), CollectionService (copy)
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

    for _, child in ReplicatedStorage.Assets.Misc.BurgerOutfit:GetChildren() do
        local v7 = u2:FindFirstChild(child.Name);
        local v8 = child:Clone();
        local v9 = v8:GetAttribute("Offset") or CFrame.new();
        v8:PivotTo(v7:GetPivot() * v9);
        v8.Parent = v7;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = v7;
        WeldConstraint.Part1 = v8;
        WeldConstraint.Parent = v8;
        CollectionService:AddTag(v8, (`Cosmetic{p3}`));
    end;

    for _, child in u2:GetChildren() do
        if child:IsA("Accessory") then
            u5[child] = true;
            child.Parent = nil;
        end;
    end;

    u4 = u2.ChildAdded:Connect(function(p10) -- Line: 57
        -- upvalues: u5 (copy)
        if p10:IsA("Accessory") then
            u5[p10] = true;
            p10.Parent = nil;
        end;
    end);

    if PlayerFromCharacter then
        PlayerFromCharacter:GetAttributeChangedSignal((`EquippedCosmetic{p3}`)):Once(function() -- Line: 65
            -- upvalues: ReplicatedStorage (ref), u2 (copy), u6 (ref), u5 (copy), u2 (copy), u4 (ref)
            for _, child in ReplicatedStorage.Assets.Misc.FriesOutfit:GetChildren() do
                local v11 = u2:FindFirstChild(child.Name);

                if v11 and child:IsA("BasePart") then
                    v11.Transparency = 0;
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