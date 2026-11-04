 
 

local CollectionService = game:GetService("CollectionService");
local TypeRegistry = require(script.Parent.TypeRegistry);
local Registry = require(script.Parent.Force.Registry);
local script_Index = require(script.Index);
local script_Entries = require(script.Entries);
local script_Pieces = require(script.Pieces);
local script_Display = require(script.Display);
local script_Owned = require(script.Owned);
local script_HandOver = require(script.HandOver);
local script_Batch = require(script.Batch);

return function(u1) -- Line: 65
    -- upvalues: TypeRegistry (copy), CollectionService (copy), script_Index (copy), script_Entries (copy), script_Batch (copy), script_Owned (copy), Registry (copy), script_Pieces (copy), script_Display (copy), script_HandOver (copy)
    u1._reactorPlays = {};
    u1._reactorCutting = {};

    function u1._isReactor(p2) -- Line: 73
        local v3 = (p2:IsA("Model") or p2:IsA("BasePart")) and p2:GetAttribute("IsReactor") == true;

        return v3;
    end;

    function u1.TransformReactor(p4, u5, p6) -- Line: 80
        -- upvalues: TypeRegistry (ref), CollectionService (ref), script_Index (ref), u1 (copy)
        if u5:GetAttribute("Transformed") then
            return;
        end;

        TypeRegistry.createConfig(u5, p6);
        u5:SetAttribute("Transformed", true);
        u5:SetAttribute("Qwinkle", true);
        u5:SetAttribute("EmitCount", 1);
        u5:SetAttribute("EmitDuration", 0);
        u5:SetAttribute("EmitDelay", 0);
        u5:SetAttribute("IsEmitter", true);
        u5:SetAttribute("EmissionMode", "Emit");
        u5:SetAttribute("AnimateLoop", false);
        CollectionService:AddTag(u5, script_Index.TAG);
        pcall(function() -- Line: 92
            -- upvalues: u1 (ref), u5 (copy)
            u1.TransformCompleted:Fire(u5);
        end);
    end;

    local function roughBounds(p7) -- Line: 97
        if p7:IsA("Model") then
            local BoundingBox, v8 = p7:GetBoundingBox();

            return BoundingBox.Position, v8.Magnitude / 2;
        end;

        local Position = p7.ExtentsCFrame.Position;
        local v9 = p7.ExtentsSize.Magnitude / 2;

        for _, descendant in ipairs(p7:GetDescendants()) do
            if descendant:IsA("BasePart") then
                v9 = math.max(v9, (descendant.ExtentsCFrame.Position - Position).Magnitude + descendant.ExtentsSize.Magnitude / 2);
            end;
        end;

        return Position, v9;
    end;

    local function couldReach(p10, p11) -- Line: 113
        -- upvalues: TypeRegistry (ref), script_Index (ref), roughBounds (copy)
        local Config = TypeRegistry.getConfig(p11);

        if not (Config and script_Index.groupMatches(p10.group, Config:GetAttribute("Group") or "")) then
            return false;
        end;

        local v12, v13 = roughBounds(p11);

        return script_Index.reaches(p10.field, v12, v13);
    end;

    function u1._tellEntry(u14, u15, p16, p17) -- Line: 126
        -- upvalues: script_Entries (ref), script_Batch (ref)
        local waiting = u15.waiting;

        if not (p17 or waiting) then
            script_Entries.follow(u14, u15, p16);

            return;
        end;

        if u15.wounds then
            u15.wounds:strike(p16);
        end;

        if waiting then
            if not table.find(waiting, p16) then
                table.insert(waiting, p16);
            end;

            return;
        end;

        local u18 = { p16 };
        u15.waiting = u18;
        script_Batch.hold(function(p19) -- Line: 143
            -- upvalues: u15 (copy), u14 (copy), u18 (ref), script_Entries (ref)
            u15.waiting = nil;
            local reactor = u15.reactor;
            local owner = u15.owner;

            if u14._reactorPlays[reactor] ~= u15 or owner and owner.leaving then
                return;
            end;

            local v20 = p19 or owner ~= nil;

            for _, v in ipairs(u18) do
                if u14._reactorPlays[reactor] == u15 then
                    script_Entries.follow(u14, u15, v, v20);
                end;
            end;

            if u14._reactorPlays[reactor] == u15 and not u15.pData then
                script_Entries.discard(u14, u15);
            end;
        end);
    end;

    local function tellReactors(p21, p22) -- Line: 166
        -- upvalues: script_Index (ref), couldReach (copy), script_Entries (ref)
        for _, v in ipairs(script_Index.reactors()) do
            local v23 = p21._reactorPlays[v];
            local v24 = false;

            if v23 then
                if not script_Index.groupMatches(p22.group, v23.group) then
                    v23 = nil;
                end;
            elseif couldReach(p22, v) then
                local v25;
                v23, v25 = script_Entries.entryFor(p21, v, nil, p22);
                v24 = v23 ~= nil;

                if v25 then
                    script_Entries.owe(v25, p22);
                end;
            end;

            if v23 then
                p21:_tellEntry(v23, p22, v24);
            end;
        end;

        p21:_followReacted(p22);
    end;

    function u1._reactToForce(p26, p27) -- Line: 193
        -- upvalues: script_Batch (ref), tellReactors (copy)
        if not p26.Connection then
            return;
        end;

        script_Batch.pass(tellReactors, p26, p27);
    end;

    function u1.UpdateReactor(p28, p29, p30, p31) -- Line: 198
        -- upvalues: script_Entries (ref), script_Owned (ref), Registry (ref)
        local _entry = p29._entry;
        local reactor = _entry.reactor;

        if not reactor.Parent or p28._reactorPlays[reactor] ~= _entry then
            script_Entries.putBack(_entry);

            if p28._reactorPlays[reactor] == _entry then
                p28._reactorPlays[reactor] = nil;
                script_Owned.gone(p28, _entry.owner, false);
            end;

            return true;
        end;

        local v32 = Registry.slowest(_entry.play.times);
        local v33;

        if p29._tsOverride == nil or p31 >= (p29._tsOverrideUntil or 0) then
            v33 = nil;
        else
            v33 = p29._tsOverride;
            v32 = v33;
        end;

        local v34 = p29._timeFrozen == true;
        local v35 = v34 and 0 or p30 * math.max(v32, 0);
        local v36 = script_Entries.step(_entry, v35, p30, v33, v34);

        if v36 == "active" then
            return false;
        end;

        if v36 == "done" then
            p28._reactorPlays[reactor] = nil;
            script_Owned.gone(p28, _entry.owner, true);
        elseif script_Owned.spent(_entry) then
            script_Entries.discard(p28, _entry, true);
        end;

        return true;
    end;

    function u1.EmitReactor(p37, p38, p39, p40) -- Line: 240
        -- upvalues: script_Entries (ref)
        if not (p38 and p38.Parent) then
            return;
        end;

        local v41 = p37._reactorPlays[p38];

        if v41 then
            script_Entries.discard(p37, v41);
        end;

        script_Entries.forget(p37._reactorCutting[p38]);

        if not script_Entries.emitOrigin(p40) then
            return;
        end;

        local v42, v43 = script_Entries.entryFor(p37, p38, p40);

        if v43 then
            v43.place = true;
            v43.emitCtx = p40;
        end;

        if not v42 then
            return;
        end;

        v42.play:place();

        if not script_Entries.resume(p37, v42) then
            script_Entries.discard(p37, v42);
        end;
    end;

    function u1.RestoreReactor(p44, p45) -- Line: 261
        -- upvalues: script_Entries (ref)
        script_Entries.forget(p44._reactorCutting[p45]);
        local v46 = p44._reactorPlays[p45];

        if v46 then
            script_Entries.discard(p44, v46);
        end;
    end;

    function u1.RestoreAllReactors(p47) -- Line: 269
        -- upvalues: script_Entries (ref), script_Owned (ref)
        for _, v in pairs(p47._reactorCutting) do
            script_Entries.forget(v);
        end;

        for _, v in pairs(table.clone(p47._reactorPlays)) do
            script_Entries.discard(p47, v);
        end;

        for _, v in ipairs(table.clone(p47._reacted)) do
            script_Owned.gone(p47, v, false);
        end;
    end;

    function u1.ShowStrandedReactors(p48) -- Line: 286
        -- upvalues: script_Index (ref), script_Pieces (ref), script_Display (ref)
        for _, v in ipairs(script_Index.reactors()) do
            if not p48._reactorPlays[v] then
                for _, v2 in ipairs(script_Pieces.parts(v)) do
                    if v2.LocalTransparencyModifier ~= 0 then
                        script_Display.unhide(v2);
                    end;
                end;
            end;
        end;
    end;

    function u1.PrepareReactor(p49, p50) -- Line: 301
        -- upvalues: script_Entries (ref)
        script_Entries.prepare(p49, p50);
    end;

    function u1.PrepareReactors(p51) -- Line: 306
        -- upvalues: script_Index (ref)
        for _, v in ipairs(script_Index.reactors()) do
            p51:PrepareReactor(v);
        end;
    end;

    script_HandOver(u1);
    Registry.onAdded(function(p52) -- Line: 314
        -- upvalues: u1 (copy)
        u1:_reactToForce(p52);
    end);
end;