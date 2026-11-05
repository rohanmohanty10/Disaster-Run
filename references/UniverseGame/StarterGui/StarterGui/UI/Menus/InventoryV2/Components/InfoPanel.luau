  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemData = require(ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedStorage.ReplicatedModules.Types);
local u1 = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core")).GetClientService("RigPreviewService");
require(ReplicatedStorage.ReplicatedModules.StatsHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local AbilityNameToId = require(ReplicatedStorage.ReplicatedModules.AbilityNameToId);
require(ReplicatedStorage.ReplicatedRoot.Libraries.Skins);
local Stands = require(ReplicatedStorage.ReplicatedModules.Stands);
local u2 = require("../Lib/Utility");
require("../Lib/Types");
local u3 = require("../Lib/Icons");
local Assets = script.Parent.Parent.Assets;
local Rarities = ItemData.Rarities;
local u4 = Color3.fromRGB(218, 218, 218);

local function ComputeItemTags(p5, p6) -- Line: 28
    -- upvalues: ItemData (copy), Stands (copy)
    local v7 = p6 or ItemData.GetItemInfo(p5.ItemId);
    local v8 = {};

    if p5.Premium then
        local v9 = { 1, "Premium", Color3.fromRGB(255, 250, 103) };
        table.insert(v8, v9);
    end;

    if p5.UnusualInfo then
        local v10 = { 2, "Unusual", Color3.fromHSV((p5.UnusualInfo.UnusualHueId or 1) * 5 / 360, 1, 1) };
        table.insert(v8, v10);
    end;

    if p5.Serial then
        local v11 = { 0, `Serial: #{p5.Serial}`, Color3.fromRGB(255, 160, 92) };
        table.insert(v8, v11);
    end;

    if v7.Type then
        local v12 = { -1, `{v7.Type}`, Color3.fromRGB(236, 217, 211) };
        table.insert(v8, v12);
    end;

    if v7.Tradeable == false then
        local v13 = { 5, "Untradeable", Color3.fromRGB(236, 61, 61) };
        table.insert(v8, v13);
    end;

    if p5.Trait then
        local v14 = { 3, `{p5.Trait.Name}`, ItemData.Rarities[p5.Trait.Rarity].Color };
        table.insert(v8, v14);
    end;

    if p5.Type == "Skin" then
        local v15 = tonumber(string.match(p5.ItemId, "SKIN_(%d+)_"));
        local v16 = ItemData.GetItemInfo("ABILITY_" .. v15);

        if v16 then
            local v17 = {
                4,
                `{Stands[v15]}`,
                ItemData.Rarities[v16.Rarity or 1].Color,
                true
            };
            table.insert(v8, v17);
        end;
    end;

    return v8;
end;

local function ClearViewport(p18) -- Line: 69
    local v19 = p18:FindFirstChildWhichIsA("WorldModel");

    if v19 == nil then
        v19 = Instance.new("WorldModel");
        v19.Parent = p18;
    end;

    v19:ClearAllChildren();
end;

local function MakeModelViewport(p20, u21) -- Line: 79
    -- upvalues: AbilityNameToId (copy), AnimationHandler (copy)
    local v22 = p20:FindFirstChildWhichIsA("WorldModel");
    u21.Parent = v22;
    local v23 = u21:GetAttribute("AbilityId");
    local u24 = AbilityNameToId.GetAbilityName(v23);
    local u25 = u21:GetAttribute("SkinName");
    local Camera = Instance.new("Camera");
    Camera.CFrame = CFrame.new(0, 0, -7.5) * CFrame.Angles(0, 3.141592653589793, 0);
    Camera.Parent = v22;
    Camera.FieldOfView = 50;
    p20.CurrentCamera = Camera;
    local _, _ = pcall(function() -- Line: 97
    end);
    pcall(function() -- Line: 102
        -- upvalues: AnimationHandler (ref), u24 (copy), u25 (copy), u21 (copy)
        local v26 = AnimationHandler.CreateAnimationByName(u24, u25, "SummonedIdle");
        local v27 = AnimationHandler.CreateAnimationByName(u24, u25, "Summoned-Idle");
        local v28 = AnimationHandler.CreateAnimationByName(u24, u25, "Idle");

        if v26 then
            u21:FindFirstChildOfClass("Humanoid"):LoadAnimation(v26):Play();
        end;

        if v27 then
            u21:FindFirstChildOfClass("Humanoid"):LoadAnimation(v27):Play();
        end;

        if v28 then
            u21:FindFirstChildOfClass("Humanoid"):LoadAnimation(v28):Play();
        end;
    end);
end;

local function MakeEmoteViewport(p29, p30, p31) -- Line: 122
    local v32 = p29:FindFirstChildWhichIsA("WorldModel");
    local v33 = p30:Clone();
    v33.Parent = v32;
    v33.PrimaryPart = v33:FindFirstChild("HumanoidRootPart");
    v33:PivotTo(CFrame.new(0, v33:GetExtentsSize().Y / 2, 0) * CFrame.Angles(0, 3.141592653589793, 0));
    local v34 = v33:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator");
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://" .. p31;
    local v35 = v34:LoadAnimation(Animation);
    v35.Looped = true;
    v35:Play();
    local _, v36 = v32:GetBoundingBox();
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 8;
    Camera.Parent = v32;
    p29.CurrentCamera = Camera;
    local v37 = math.max(v36.X, v36.Y, v36.Z) * 0.5;
    local v38 = math.rad(Camera.FieldOfView * 0.5);
    local v39 = v37 / math.tan(v38) * 1.1;
    local v40 = Vector3.new(0, v36.Y * 0.45, 0);
    Camera.CFrame = CFrame.lookAt(v40 + Vector3.new(0, 0, v39), v40);
end;

local u41 = {
    Item = "ITEM_",
    Skin = "SKIN_",
    Ability = "ABILITY_",
    Emote = "EMOTE_"
};

local function GetItemType(p42) -- Line: 160
    -- upvalues: u41 (copy)
    for i, v in u41 do
        if string.find(p42.ItemId, v) then
            return i;
        end;
    end;
end;

local function ApplyIcon(p43, p44) -- Line: 168
    -- upvalues: u3 (copy)
    local v45 = u3[p44];

    if v45 then
        p43.Image = v45.Atlas;
        p43.ImageRectSize = Vector2.new(256, 256);
        p43.ImageRectOffset = v45.ImageRectOffset;
    end;
end;

return function(u46, u47) -- Line: 178
    -- upvalues: Rarities (copy), ItemData (copy), u2 (copy), ComputeItemTags (copy), Assets (copy), u1 (copy), MakeModelViewport (copy), MakeEmoteViewport (copy), Fusion (copy), u4 (copy), u3 (copy)
    local u48 = nil;

    local function UpdateInfoPanel() -- Line: 181
        -- upvalues: u47 (copy), u46 (copy), Rarities (ref), ItemData (ref), u2 (ref), ComputeItemTags (ref), Assets (ref), u48 (ref), u1 (ref), MakeModelViewport (ref), MakeEmoteViewport (ref)
        local v49 = u47.FocusedItem:get();

        if not v49 then
            u46.NameLabel.Text = "Nothing";
            u46.DescriptionLabel.Text = "...";
            u46.RarityLabel.Text = "...";
            u46.RarityLabel.TextColor3 = Rarities[1].Color;
            u46.CreatorLabel.Text = "...";

            for _, v in u46.Tags:QueryDescendants("Frame") do
                v:Destroy();
            end;

            local Preview = u46.Preview;
            local v50 = Preview:FindFirstChildWhichIsA("WorldModel");

            if v50 == nil then
                v50 = Instance.new("WorldModel");
                v50.Parent = Preview;
            end;

            v50:ClearAllChildren();

            return;
        end;

        local v51 = ItemData.GetItemInfo(v49.ItemId);
        local v52 = v51.DisplayName or v51.Name;
        local v53 = `" {v51.Description} "` or " ... ";
        local v54 = v51.Rarity or 1;
        local v55 = u2.DecodeUUID(v49.Identifier);
        u46.NameLabel.Text = v52;
        u46.DescriptionLabel.Text = v53;
        u46.RarityLabel.Text = Rarities[v54].Name;
        u46.RarityLabel.TextColor3 = Rarities[v54].Color;
        u46.CreatorLabel.Text = `Created {os.date("%x at %X", v55.Time)} by {v55.Creator or "???"}`;
        local v56 = ComputeItemTags(v49, v51);

        for _, child in u46.Tags:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        for i = 1, #v56 do
            local v57 = v56[i];
            local v58 = Assets.Tag:Clone();
            v58.LayoutOrder = v57[1];
            v58.Label.Text = v57[2];
            v58.UIStroke.Color = v57[3];
            v58.Label.TextColor3 = v57[3];
            v58.Parent = u46.Tags;
            v58.Visible = true;
        end;

        local Type = v49.Type;

        if Type ~= "Skin" and Type ~= "Ability" then
            if Type == "Emote" then
                local v59 = ItemData.GetItemInfo(v49.ItemId);
                local Preview = u46.Preview;
                local v60 = Preview:FindFirstChildWhichIsA("WorldModel");

                if v60 == nil then
                    v60 = Instance.new("WorldModel");
                    v60.Parent = Preview;
                end;

                v60:ClearAllChildren();

                if v59.DisplayInfo then
                    u46.Preview.Label.Visible = false;
                    MakeEmoteViewport(u46.Preview, script["Mysterious Man"], v59.DisplayInfo.Animations[1]);

                    return;
                end;

                u46.Preview.Label.Visible = true;
            end;

            return;
        end;

        local u61;

        if Type == "Skin" then
            u61 = string.match(v49.ItemId, "SKIN_(%d+)_");
        else
            u61 = string.match(v49.ItemId, "_(%d+)");
        end;

        local u62;

        if Type == "Skin" then
            u62 = string.match(v49.ItemId, "SKIN_%d+_(%d+)");
        else
            u62 = nil;
        end;

        if u48 then
            task.cancel(u48);
            u48 = nil;
        end;

        u48 = task.spawn(function() -- Line: 248
            -- upvalues: u1 (ref), u61 (ref), u62 (ref), u46 (ref), MakeModelViewport (ref)
            local v63 = u1:LoadPreviewRig(tonumber(u61), (tonumber(u62))):expect();
            local Preview = u46.Preview;
            local v64 = Preview:FindFirstChildWhichIsA("WorldModel");

            if v64 == nil then
                v64 = Instance.new("WorldModel");
                v64.Parent = Preview;
            end;

            v64:ClearAllChildren();

            if not v63 then
                u46.Preview.Label.Visible = true;

                return;
            end;

            u46.Preview.Label.Visible = false;
            MakeModelViewport(u46.Preview, v63:Clone());
        end);
    end;

    Fusion.Hydrate(u46.Actions)({
        [Fusion.Children] = Fusion.ForValues(u47.FocusedItemActions, function(u65) -- Line: 277
            -- upvalues: Assets (ref), u4 (ref), u3 (ref), Fusion (ref), u47 (copy)
            if (u65.Kind or "Button") ~= "Button" then
                return nil;
            end;

            local v66 = Assets.ActionButton:Clone();
            v66.LayoutOrder = u65.Order or 1;
            v66.Label.Text = u65.Label;
            v66.Label.TextColor3 = u65.Color or u4;
            v66.Icon.ImageColor3 = u65.Color or u4;
            v66.UIStroke.Color = u65.Color or u4;
            v66.BackgroundColor3 = u65.Color or u4;

            if u65.FullSize then
                v66.Size = UDim2.fromScale(1, v66.Size.Y.Scale);
            end;

            if u65.IconName then
                local Icon = v66.Icon;
                local v67 = u3[u65.IconName];

                if v67 then
                    Icon.Image = v67.Atlas;
                    Icon.ImageRectSize = Vector2.new(256, 256);
                    Icon.ImageRectOffset = v67.ImageRectOffset;
                end;
            end;

            v66.Visible = true;
            local u68 = Fusion.Value(false);
            Fusion.Hydrate(v66)({
                [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 307
                    -- upvalues: u47 (ref), u65 (copy)
                    u47.UIEngine:PlaySound("Inventory/inv_click");

                    if u65.Callback then
                        u65.Callback();
                    end;
                end,

                [Fusion.OnEvent("MouseEnter")] = function() -- Line: 314
                    -- upvalues: u47 (ref), u68 (copy)
                    u47.UIEngine:PlaySound("Inventory/inv_hover");
                    u68:set(true);
                end,

                [Fusion.OnEvent("MouseLeave")] = function() -- Line: 318
                    -- upvalues: u68 (copy)
                    u68:set(false);
                end,

                BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 322
                    -- upvalues: u68 (copy)
                    return u68:get() and 0.85 or 1;
                end), 25, 1)
            });

            return v66;
        end, Fusion.cleanup)
    });
    Fusion.Hydrate(u46.RarityGradient)({
        BackgroundColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 332
            -- upvalues: u47 (copy), Rarities (ref), ItemData (ref)
            local v69 = u47.FocusedItem:get();

            if v69 == nil then
                return Rarities[1].Color;
            end;

            return Rarities[ItemData.GetItemInfo(v69.ItemId).Rarity or 1].Color;
        end), 17.5, 0.95)
    });
    local u70 = Fusion.Spring(Fusion.Computed(function() -- Line: 341
        -- upvalues: u47 (copy)
        return u47.InfoPanelOpen:get() and UDim2.fromScale(0.4, 1) or UDim2.fromScale(0, 1);
    end), 30, 0.95);
    Fusion.Hydrate(u46.Parent)({
        Size = u70,
        Visible = Fusion.Computed(function() -- Line: 347
            -- upvalues: u70 (copy)
            return u70:get().X.Scale > 0.002;
        end)
    });
    Fusion.Observer(u47.FocusedItem):onChange(function() -- Line: 352
        -- upvalues: u47 (copy), UpdateInfoPanel (copy)
        if u47.FocusedItem:get() and not u47.InfoPanelOpen:get() then
            u47.InfoPanelOpen:set(true);
        end;

        UpdateInfoPanel();
    end);
    UpdateInfoPanel();
end;