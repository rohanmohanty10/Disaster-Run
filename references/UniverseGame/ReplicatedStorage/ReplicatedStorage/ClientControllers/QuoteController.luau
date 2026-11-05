  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Signal = require(Knit.Util.Signal);
require(Knit.Util.Promise);
local v1 = require(PathShortcuts.ClientControllers.GroupController).new();
local LocalPlayer = game.Players.LocalPlayer;
local u2 = nil;
local u3 = nil;
local u4 = Knit.CreateController({
    Name = "QuoteController",
    QuoteData = nil,
    Parent = v1,
    Updated = Signal.new(),
    VisibilityUpdated = Signal.new()
});
u4.__index = v1;
setmetatable(u4, u4);

function u4.AddGroup(p5, p6) -- Line: 27
    local v7 = p5.Parent:AddGroup(p6);
    v7.Quotes = v7.Items;

    return v7;
end;

u4.AddQuote = v1.AddItem;
u4.RemoveQuote = v1.RemoveItem;
u4.GetQuote = v1.GetItem;
u4.GetQuotes = v1.GetItems;

function u4.Update(p8) -- Line: 38
    -- upvalues: u4 (copy), LocalPlayer (copy), u3 (ref)
    u4:Clear();
    local Data = LocalPlayer.Data;
    local v9 = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("QuoteSkinOverride") or Data.Skin:GetAttribute("SkinName");
    local v10 = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("QuoteAbilityOverride") or Data.Ability:GetAttribute("AbilityName");
    local v11 = u3.GetQuoteInfo(v10, v9);

    if not (v11 and v11.Groups) then
        p8.QuoteData = nil;
        p8.Updated:Fire();

        return;
    end;

    p8.QuoteData = v11;

    for i, v in pairs(v11.Groups) do
        local v12 = p8:AddGroup(i);

        for i2, v2 in pairs(v) do
            v12[i2] = v2;
        end;
    end;

    for i, v in pairs(v11.Quotes) do
        if not p8:GetGroup(i) then
            p8:AddGroup(i);
        end;

        for i2, v2 in ipairs(v) do
            local v13 = {};

            for i3, v3 in pairs(v2) do
                v13[i3] = v3;
            end;

            if not v13.Index then
                v13.Index = i2;
            end;

            p8:AddQuote(i, i2, v13);
        end;
    end;

    p8.Updated:Fire();
end;

function u4.KnitStart(u14) -- Line: 84
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), PathShortcuts (copy), u4 (copy), LocalPlayer (copy)
    u2 = Knit.GetService("QuoteService");
    u3 = require(PathShortcuts.ReplicatedModules.Quotes);

    local function Update() -- Line: 89
        -- upvalues: u4 (ref)
        task.defer(function() -- Line: 90
            -- upvalues: u4 (ref)
            u4:Update();
        end);
    end;

    u2.SetGroupVisible:Connect(function(p15, p16) -- Line: 96
        -- upvalues: u14 (copy)
        local v17 = u14:GetGroup(p15);

        if not v17 then
            return;
        end;

        v17.Visible = p16;
        u14.VisibilityUpdated:Fire();
    end);
    u2.SetQuoteVisible:Connect(function(p18, p19, p20) -- Line: 104
        -- upvalues: u14 (copy)
        local v21 = u14:GetQuote(p18, p19);

        if not v21 then
            return;
        end;

        v21.Visible = p20;
        u14.VisibilityUpdated:Fire();
    end);
    u2.ClearGroupsVisible:Connect(function() -- Line: 112
        -- upvalues: u14 (copy)
        for _, v in u14:GetGroups() do
            v.Visible = false;
        end;

        u14.VisibilityUpdated:Fire();
    end);
    local Data = LocalPlayer:WaitForChild("Data");
    Data.Ability.AttributeChanged:Connect(Update);
    Data.Skin.AttributeChanged:Connect(Update);
    task.defer(function() -- Line: 90
        -- upvalues: u4 (ref)
        u4:Update();
    end);
    local u22 = {};
    LocalPlayer.CharacterAdded:Connect(function(p23) -- Line: 127
        -- upvalues: u22 (copy), Update (copy), u4 (ref)
        for _, v in u22 do
            v:Disconnect();
        end;

        table.clear(u22);
        local v24 = p23:GetAttributeChangedSignal("QuoteAbilityOverride");
        table.insert(u22, v24:Connect(Update));
        local v25 = p23:GetAttributeChangedSignal("QuoteSkinOverride");
        table.insert(u22, v25:Connect(Update));
        task.defer(function() -- Line: 90
            -- upvalues: u4 (ref)
            u4:Update();
        end);
    end);
end;

return u4;