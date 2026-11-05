  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Signal);
require(Knit.Util.Promise);
local _ = game.Players.LocalPlayer;
local u1 = Knit.CreateController({
    Name = "GroupController"
});

function u1.new() -- Line: 16
    -- upvalues: u1 (copy)
    local v2 = {
        Groups = {}
    };

    for i, v in u1 do
        v2[i] = v;
    end;

    return v2;
end;

function u1.AddGroup(p3, p4) -- Line: 28
    if p3:GetGroup(p4) then
        return p3:GetGroup(p4);
    end;

    p3.Groups[p4] = {
        Visible = false,
        Items = {}
    };

    return p3.Groups[p4];
end;

function u1.RemoveGroup(p5, p6) -- Line: 41
    p5.Groups[p6] = nil;
end;

function u1.GetGroup(p7, p8) -- Line: 45
    return p7.Groups[p8];
end;

function u1.GetGroups(p9) -- Line: 49
    return p9.Groups;
end;

function u1.AddItem(p10, p11, p12, p13) -- Line: 53
    local v14 = p10:GetGroup(p11);
    v14.Items[p12] = p13;

    return v14.Items[p12];
end;

function u1.RemoveItem(p15, p16, p17) -- Line: 59
    p15:GetGroup(p16).Items[p17] = nil;
end;

function u1.GetItem(p18, p19, p20) -- Line: 64
    return p18:GetGroup(p19).Items[p20];
end;

function u1.GetItems(p21, p22) -- Line: 69
    return p21:GetGroup(p22).Items;
end;

function u1.Clear(p23) -- Line: 74
    table.clear(p23.Groups);
end;

return u1;