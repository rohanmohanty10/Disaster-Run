  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observers = require(ReplicatedStorage.Packages.Observers);
local Trove = require(ReplicatedStorage.Packages.Trove);
local makePlayerModel = require(ReplicatedStorage.Shared.utils.makePlayerModel);
local CosmeticsController = require(ReplicatedStorage.Controllers.CosmeticsController);
local _ = Players.LocalPlayer;

return Observers.observeTag("CosmeticViewport", function(u1: userdata) -- Line: 11
    -- upvalues: Trove (copy), ReplicatedStorage (copy), CosmeticsController (copy), makePlayerModel (copy)
    local u2 = false;
    local u3 = nil;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = u1;
    local u4 = nil;

    local function updatePlayingEmote() -- Line: 20
        -- upvalues: u3 (ref), u1 (copy), u4 (ref), Trove (ref), ReplicatedStorage (ref), CosmeticsController (ref)
        if not u3 then
            return;
        end;

        local Attribute = u1:GetAttribute("Cosmetic");

        if Attribute == "" then
            Attribute = nil;
        end;

        if u4 then
            u4();
            u4 = nil;
        end;

        if not Attribute then
            u3:PivotTo(CFrame.new(0, 100, 0));

            return;
        end;

        local v5 = Trove.new();
        local Humanoid = u3.Humanoid;

        if Attribute and Attribute ~= "" then
            if ReplicatedStorage.Assets.Cosmetics:WaitForChild(Attribute):GetAttribute("Gloves") then
                for _, child in ReplicatedStorage.Assets.Cosmetics:WaitForChild(Attribute):GetChildren() do
                    Humanoid:AddAccessory((v5:Clone(child)));
                end;
            elseif ReplicatedStorage.Assets.Cosmetics:FindFirstChild(Attribute) then
                Humanoid:AddAccessory((v5:Clone(ReplicatedStorage.Assets.Cosmetics:FindFirstChild(Attribute))));
            else
                CosmeticsController:setupCosmetic(u3, Attribute, 1);
            end;
        end;

        u4 = v5:WrapClean();
        u3:PivotTo(CFrame.new(0, -3, -5) * CFrame.Angles(0, 3.141592653589793, 0));
    end;

    local u6 = u1:GetAttributeChangedSignal("Cosmetic"):Connect(updatePlayingEmote);
    task.spawn(function() -- Line: 62
        -- upvalues: u3 (ref), makePlayerModel (ref), u2 (ref), WorldModel (copy), updatePlayingEmote (copy)
        u3 = makePlayerModel(true);

        if not u2 then
            u3:PivotTo(CFrame.new(0, 100, 0));
            u3.Parent = WorldModel;
            updatePlayingEmote();
        end;
    end);

    return function() -- Line: 71
        -- upvalues: u2 (ref), WorldModel (copy), u6 (copy)
        u2 = true;
        WorldModel:Destroy();
        u6:Disconnect();
    end;
end);