  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Signal = require(Knit.Util.Signal);
require(Knit.Util.Promise);
local GroupController = require(PathShortcuts.ClientControllers.GroupController);
local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
local AbilityService = require(ReplicatedRoot.Services.Gameplay.AbilityService);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = Knit.CreateController({
    Name = "MoveIndicatorController",
    Updated = Signal.new(),
    VisibilityUpdated = Signal.new(),
    StateVisibilityUpdate = Signal.new()
});

for i, v in GroupController do
    if not u1[i] then
        u1[i] = v;
    end;
end;

u1.AddMove = GroupController.AddItem;
u1.RemoveMove = GroupController.RemoveItem;
u1.GetMove = GroupController.GetItem;
u1.GetMoves = GroupController.GetItems;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;

function u1.new() -- Line: 44
    -- upvalues: GroupController (copy), u1 (copy)
    local v7 = GroupController.new();

    for i, v in u1 do
        v7[i] = v;
    end;

    return v7;
end;

function u1.GetMovesetOld(p8) -- Line: 52
    -- upvalues: LocalPlayer (copy), u5 (ref), u6 (ref), u4 (ref)
    local v9 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v10 = LocalPlayer.Data.Skin:GetAttribute("SkinName");
    local v11 = u5.GetStats(v9, v10).Moveset or u6 and u6.Movesets[u4[LocalPlayer.Data.Ability.Value]];

    return v11;
end;

function u1.GetMoveset(p12) -- Line: 57
    -- upvalues: LocalPlayer (copy), u4 (ref), AbilityService (copy), u5 (ref), u6 (ref)
    local v13 = u4[LocalPlayer.Data.Ability.Value] or LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v14 = LocalPlayer.Data.Skin:GetAttribute("SkinName");
    local v15 = AbilityService.GetAbilityInfo(v13);

    if v15 and not v15.IsLegacy then
        local v16 = AbilityService.GetAbilityData({
            Ability = v13
        });

        if v16.Moveset then
            return v16.Moveset;
        end;
    end;

    local v17 = u5.GetStats(v13, v14);

    if v17 then
        return v17.Moveset;
    end;

    return u6 and u6.Movesets[u4[LocalPlayer.Data.Ability.Value]];
end;

function u1.AddGroup(p18, p19) -- Line: 75
    -- upvalues: GroupController (copy)
    local v20 = GroupController.AddGroup(p18, p19);
    v20.Moves = v20.Items;

    return v20;
end;

local u21 = nil;

function u1.Update(p22) -- Line: 83
    -- upvalues: LocalPlayer (copy), u5 (ref), u3 (ref), u21 (ref)
    local v23 = p22:GetMoveset();

    if not v23 then
        return;
    end;

    for i, v in v23.Groups do
        if not p22:GetGroup(i) then
            local v24 = p22:AddGroup(i);

            for i2, v2 in v do
                v24[i2] = v2;
            end;

            if not v24.Priority then
                v24.Priority = 0;
            end;
        end;
    end;

    local v25 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v26 = u5.GetStats(v25);

    if not v26 then
        return;
    end;

    local Stats = v26.Stats;

    if type(v23.MovesInfo) == "table" then
        for i, v in v23.MovesInfo do
            local State = v.State;
            local v27 = p22:GetGroup(State);

            if not v27 then
                v27 = p22:AddGroup(State);

                if not v27.Priority then
                    v27.Priority = 0;
                end;
            end;

            local DefaultKeybind = v.DefaultKeybind;
            local v28 = {};

            if type(v.IndicatorInfo) == "table" then
                for i2, v2 in v.IndicatorInfo do
                    v28[i2] = v2;
                end;
            end;

            if not v28.MoveName then
                v28.MoveName = i;
            end;

            if not v28.Input then
                v28.Input = DefaultKeybind;
            end;

            local v29 = p22:GetItem(State, i);

            if v28.Visible == nil then
                if v29 and v29.MoveVisible ~= nil then
                    v28.Visible = v29.MoveVisible;
                    v28.MoveVisible = v29.MoveVisible;
                else
                    v28.Visible = v27.Visible;
                end;
            end;

            if not v28.DisplayName then
                v28.DisplayName = v.DisplayName;
            end;

            p22:AddMove(State, i, v28);
        end;
    else
        for i, v in Stats do
            if v.Indicators then
                for _, v2 in v.Indicators do
                    if not p22:GetGroup(v2.Group) then
                        local v30 = p22:AddGroup(v2.Group);

                        if not v30.Priority then
                            v30.Priority = 0;
                        end;
                    end;

                    local v31 = {};

                    for i2, v3 in v2 do
                        v31[i2] = v3;
                    end;

                    if not v31.Input then
                        local v32 = nil;

                        if type(v23.Moves) == "table" then
                            for i2, v3 in v23.Moves do
                                if v3 == i then
                                    v32 = i2;
                                    break;
                                end;
                            end;
                        end;

                        v31.Input = v32;
                    end;

                    p22:AddMove(v2.Group, v2.Name or v.MoveName, v31);
                end;
            end;
        end;
    end;

    for i, _ in u3:GetEquippedSubPowers():expect() do
        local v33 = p22:GetGroup("SubPowers");
        local v34 = u21.Moveset.MovesInfo[i] or {};
        local v35 = {};

        if type(v34.IndicatorInfo) == "table" then
            for i2, v in v34.IndicatorInfo do
                v35[i2] = v;
            end;
        end;

        if not v35.MoveName then
            v35.MoveName = i;
        end;

        if not v35.Input then
            v35.Input = v34.DefaultKeybind or nil;
        end;

        if v35.Visible == nil then
            v35.Visible = v33.Visible;
        end;

        if not v35.DisplayName then
            v35.DisplayName = v34.DisplayName;
        end;

        v35.IsSubPower = true;
        p22:AddMove("SubPowers", i, v35);
    end;

    p22.Updated:Fire();
end;

function u1.KnitStart(p36) -- Line: 229
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), u4 (ref), PathShortcuts (copy), u5 (ref), u6 (ref), u1 (copy), u21 (ref), LocalPlayer (copy), AbilityService (copy)
    u2 = Knit.GetService("MoveIndicatorService");
    u3 = Knit.GetService("SubPowerService");
    u4 = require(PathShortcuts.StandsModule);
    u5 = require(PathShortcuts.ReplicatedModules.StatsHandler);
    u6 = require(PathShortcuts.ReplicatedModules:WaitForChild("Movesets"));
    local u37 = u1.GetSingleton();
    u2.SetGroupVisible:Connect(function(p38, p39) -- Line: 240
        -- upvalues: u37 (copy)
        u37:GetGroup(p38).Visible = p39;
        u37.VisibilityUpdated:Fire();
    end);
    u2.SetMoveVisible:Connect(function(p40, p41, p42) -- Line: 247
        -- upvalues: u37 (copy)
        u37:GetMove(p40, p41).MoveVisible = p42;
        u37.VisibilityUpdated:Fire();
    end);
    u2.SetStateVisible:Connect(function(p43, p44) -- Line: 252
        -- upvalues: u37 (copy)
        u37:GetGroup(p43).Show = p44;
        u37.StateVisibilityUpdate:Fire();
    end);
    u21 = u5.GetStats("SubPowers");

    local function CharacterAdded(p45) -- Line: 261
        -- upvalues: LocalPlayer (ref), u37 (copy)
        while LocalPlayer.Data.Ability.Value == 0 do
            task.wait();
        end;

        u37:Clear();
        u37:Update();
    end;

    if LocalPlayer.Character then
        task.spawn(CharacterAdded, LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(CharacterAdded);
    AbilityService.AbilityCached:Connect(function(p46) -- Line: 274
        -- upvalues: LocalPlayer (ref), u4 (ref), u37 (copy)
        local v47 = u4[LocalPlayer.Data.Ability.Value] or LocalPlayer.Data.Ability:GetAttribute("AbilityName");
        LocalPlayer.Data.Skin:GetAttribute("SkinName");

        if p46 == v47 then
            task.defer(function() -- Line: 278
                -- upvalues: u37 (ref)
                u37:Clear();
                u37:Update();
            end);
        end;
    end);
end;

local u48 = u1.new();

function u1.GetSingleton() -- Line: 288
    -- upvalues: u48 (copy)
    return u48;
end;

return u1;