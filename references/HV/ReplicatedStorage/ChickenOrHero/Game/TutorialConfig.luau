 

 

local u4 = {
    Steps = { "Crate", "Knife", "RunnerAbility", "ChaserAbility", "BuyAdrenaline" },
    Crate = "HalloweenTreat",
    FallbackCrate = "Basic",
    RunnerAbility = "OneHitShield",
    ChaserAbility = "BearTrap",
    Item = "Adrenaline",
    FirstDay = 20745,
    TestName = "First Tutorial",
    ConfigKey = "TutorialMode",

    available = function(p1) -- Line: 34, Name: available
        local CrateCatalog = require(script.Parent.Parent:WaitForChild("Crates"):WaitForChild("CrateCatalog"));
        local v2;

        if type(p1) == "string" then
            v2 = CrateCatalog.get(p1);
        else
            v2 = false;
        end;

        if not v2 then
            return false;
        end;

        if not v2.Halloween then
            return table.find(CrateCatalog.Order, p1) ~= nil;
        end;

        local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
        local EndsAt = require(script.Parent:WaitForChild("HalloweenShopConfig")).EndsAt;
        local v3;

        if FFlags.HalloweenShop == true then
            v3 = EndsAt == nil and true or os.time() < EndsAt;
        else
            v3 = false;
        end;

        return v3;
    end
};

function u4.crateNow() -- Line: 48
    -- upvalues: u4 (copy)
    if u4.available(u4.Crate) then
        return u4.Crate;
    end;

    return u4.FallbackCrate;
end;

u4.Text = {
    Crate = "Open your FREE %s",
    Knife = "Equip your new knife",
    RunnerAbility = "Equip your first Runner ability",
    ChaserAbility = "Equip your first Chaser ability",
    BuyAdrenaline = "Get your first item"
};
u4.DoneText = "You\'re all set! You\'ll join when the next match begins.";

function u4.index(p5) -- Line: 62
    -- upvalues: u4 (copy)
    return table.find(u4.Steps, p5);
end;

return table.freeze(u4);