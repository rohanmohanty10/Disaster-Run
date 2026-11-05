  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u3 = Knit.GetService("ShopService");
local u4 = Dialogue.new();
u4:SetTitle("Black Market");
u4:SetStarterText("yo... pst.. got any items?");
u4:AddResponse("yeah i gotchu bro", function(p5) -- Line: 17
    -- upvalues: u4 (copy)
    game.ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowBlackMarket");
    u4:Destroy();
end);
local v6 = {
    Culler = {
        GunParts = 2,
        UCoins = 2000000
    },
    Sealer = {
        GunParts = 2,
        UCoins = 1500000
    },
    Contender = {
        GunParts = 1,
        UCoins = 1000000
    },
    Flintlock = {
        GunParts = 2,
        UCoins = 125000
    }
};
local v9 = u4:AddResponse("got anything you can make me?", function(p7) -- Line: 41
    -- upvalues: u2 (copy), u4 (copy)
    if u2:CheckRequirement("CheckAbilityLevel", 50):expect() then
        u4:SetText("sure, if you bring me some <TextColor3=255,150,75>Gun Parts<TextColor3=/> I could provide you with some weapons");

        return "Continue";
    end;

    u4:SetText("sorry but.. come ask again when you\'ve gained some more experience <Color=RareBlue>(LEVEL 50 ABILITY NEEDED)<Color=/>");

    return "ClearResponses";
end):LinkResponse("I got some", function() -- Line: 54
    -- upvalues: u2 (copy), u4 (copy)
    local v8 = u2:CheckRequirement("ItemCountCheck", "ITEM_580"):expect();

    if typeof(v8) == "number" and v8 > 0 then
        u4:SetText("good, now take your pick");

        return "Continue";
    end;

    u4:SetText("no, you do not <Color=RareBlue>(REQUIRED IN INVENTORY)<Color=/>");

    return "ClearResponses";
end);

if v9 then
    for i, v in v6 do
        v9:LinkResponse(`<font color="rgb(195,155,255)">{i}</font> - {v.GunParts}x <font color="rgb(255,150,75)">Gun Parts</font> & <font color="rgb(255,205,88)">{v.UCoins} UCoins</font>`, function() -- Line: 70
            -- upvalues: u3 (copy), i (copy), u4 (copy)
            local v10 = u3:RequestBlackMarketPurchase(i):expect();

            if v10 then
                if v10 and typeof(v10) == "string" then
                    u4:SetText(v10);
                elseif v10 and typeof(v10) ~= "string" then
                    u4:SetText("Enjoy");
                end;
            else
                u4:SetText("come back when you can fullfil my offer.");
            end;

            return "ClearResponses";
        end);
    end;
end;

return u4;