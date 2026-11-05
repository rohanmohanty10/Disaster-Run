  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local u9 = {
    Functions = {},

    GenerateParameters = function(p1) -- Line: 16, Name: GenerateParameters
        local v2 = p1 or {};
        v2.Sequence = v2.Sequence or nil;
        local Call = v2.Call;

        if not Call then
            if v2.Sequence then
                Call = v2.Sequence.Call or nil;
            else
                Call = nil;
            end;
        end;

        v2.Call = Call;
        local v3 = v2.Move or v2.Call and v2.Call.Move;

        if not v3 then
            if v2.Sequence then
                v3 = v2.Sequence.Move or nil;
            else
                v3 = nil;
            end;
        end;

        v2.Move = v3;
        local v4 = v2.Ability or v2.Move and v2.Move.Ability;

        if not v4 then
            if v2.Sequence then
                v4 = v2.Sequence.Ability or nil;
            else
                v4 = nil;
            end;
        end;

        v2.Ability = v4;
        local v5 = v2.Character or v2.Sequence and v2.Sequence.Character or (v2.Call and v2.Call.Character or v2.Move and v2.Move.Character);

        if not v5 then
            if v2.Ability then
                v5 = v2.Ability.Character or nil;
            else
                v5 = nil;
            end;
        end;

        v2.Character = v5;
        local v6;

        if v2.Character then
            v6 = game.Players:GetPlayerFromCharacter(v2.Character) or nil;
        else
            v6 = nil;
        end;

        v2.Player = v6;
        local v7 = v2.Sequence and v2.Sequence:GetState() or (v2.Call and v2.Call.State or v2.Move and v2.Move.State);

        if not v7 then
            if v2.Ability then
                v7 = v2.Ability.State or nil;
            else
                v7 = nil;
            end;
        end;

        v2.State = v7;
        local v8 = v2.Collector or v2.Sequence and v2.Sequence.Collector or (v2.Call and v2.Call.Collector or v2.Move and v2.Move.Collector);

        if not v8 then
            if v2.Ability then
                v8 = v2.Ability.Collector or nil;
            else
                v8 = nil;
            end;
        end;

        v2.Collector = v8;
        v2.Trove = v2.Move and v2.Move.Collector or v2.Ability and v2.Ability.Collector or (v2.Collector or nil);

        return v2;
    end
};

function u9.GetFunction(p10, p11) -- Line: 40
    -- upvalues: u9 (copy)
    local v12 = u9.GenerateParameters(p11);
    local v13;

    if v12.Move and v12.Move.Data.Functions then
        v13 = v12.Move.Data.Functions[p10] or nil;
    else
        v13 = nil;
    end;

    if v12.Ability and v12.Ability.Data.Functions then
        v13 = v12.Ability.Data.Functions[p10] or nil;
    end;

    return v13 or u9.Functions[p10];
end;

function u9.CallFunction(p14, p15, ...) -- Line: 52
    -- upvalues: u9 (copy)
    local v16 = u9.GenerateParameters(p15);

    if typeof(p14) == "function" then
        return p14(v16, ...);
    end;

    local v17 = typeof(p14) == "string" and u9.GetFunction(p14, v16);

    if v17 then
        return v17(v16, ...);
    end;
end;

function u9._Start() -- Line: 64
    -- upvalues: u9 (copy), ReplicatedRoot (copy), Core (copy)
    local function Add(p18) -- Line: 65
        -- upvalues: u9 (ref), Add (copy)
        if p18:IsA("ModuleScript") then
            if u9.Functions[p18.Name] then
                return;
            end;

            local v19 = require(p18);

            if typeof(v19) == "function" then
                u9.Functions[p18.Name] = v19;

                return;
            end;

            if typeof(v19) == "table" then
                for i, v in pairs(v19) do
                    if typeof(v) == "function" then
                        u9.Functions[i] = v;
                    end;
                end;
            end;
        else
            for _, child in pairs(p18:GetChildren()) do
                Add(child);
            end;
        end;
    end;

    Add(ReplicatedRoot.Assets.Functions);

    if Core.Context == "Server" then
        Add(Core.ServerAssets.Functions);
    end;
end;

return u9;