  

 

local v1 = {};
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
require(Core.ReplicatedLibraries.Classes.Trove);
require(Core.ReplicatedServices.TagService);

function v1.Init(u2) -- Line: 8
    local TraitHandler = require(game.ReplicatedStorage.ReplicatedModules:WaitForChild("PVEPackage"):WaitForChild("TraitHandler"));
    TraitHandler.IsTraitType("MeterTrait");

    function u2.GetTraitInfo(u3, p4) -- Line: 12
        -- upvalues: TraitHandler (copy)
        local v5 = p4 or {};
        local v6 = {
            Trait = v5.Trait or nil
        };
        local v7;

        if v5.Trait then
            v7 = v5.Hexed or false;
        else
            v7 = nil;
        end;

        v6.Hexed = v7;

        if v6.Trait == nil then
            local v10, v11 = xpcall(function() -- Line: 20
                -- upvalues: u3 (copy), TraitHandler (ref)
                local v8 = game.Players:GetPlayerFromCharacter(u3);

                if v8 then
                    return TraitHandler.GetTraitFromPlayer(v8);
                end;

                return TraitHandler.GetTraitFromPlayer(u3);
            end, function(p9) -- Line: 27
                warn((`Failed to resolve trait: \n{p9}\n{debug.traceback()}`));
            end);

            if v10 and v11 then
                v6.Trait = v11.Trait;
                v6.Hexed = v11.Hexed;
            end;
        end;

        return v6;
    end;

    function u2.GetTraitValues(p12, p13, p14) -- Line: 40
        -- upvalues: u2 (copy), TraitHandler (copy)
        local v15 = p13 or {};

        if p14 then
            for i, v in pairs(p14) do
                v15[i] = v;
            end;
        end;

        local u16 = u2.GetTraitInfo(p12, v15);
        local Type = v15.Type;
        local u17 = v15.Key or "Value";
        local Arguments = v15.Arguments;
        local u18 = {};
        xpcall(function() -- Line: 56
            -- upvalues: TraitHandler (ref), u16 (copy), u18 (copy), u17 (copy), Type (copy), Arguments (copy)
            TraitHandler.CallTraitWithMetadata(u16, {
                Parser = function(p19) -- Line: 58, Name: Parser
                    -- upvalues: u18 (ref), u17 (ref)
                    if typeof(p19) == "table" then
                        for i, v in pairs(p19) do
                            u18[i] = v;
                        end;

                        return;
                    end;

                    u18[u17] = p19;
                end,

                CheckCallback = function(p20) -- Line: 67, Name: CheckCallback
                    -- upvalues: Type (ref)
                    if Type == nil then
                        return true;
                    end;

                    if not p20.TraitTypes and Type ~= "None" then
                        return false;
                    end;

                    if typeof(Type) == "string" then
                        if table.find(p20.TraitTypes, Type) then
                            return true;
                        end;
                    elseif typeof(Type) == "table" then
                        local v21 = true;

                        for _, v in pairs(Type) do
                            if not table.find(p20.TraitTypes, v) then
                                v21 = false;
                                break;
                            end;
                        end;

                        if v21 then
                            return true;
                        end;
                    end;

                    return false;
                end,

                Args = Arguments
            });
        end, function(p22) -- Line: 95
            warn((`Failed to resolve trait callback: \n{p22}\n{debug.traceback()}`));
        end);

        return u18;
    end;
end;

return v1;