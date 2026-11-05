  

 

local v1 = {};
local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local AssetService = require(ReplicatedRoot.Services.AssetService);
require(ReplicatedRoot.Libraries.Classes.Trove);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local Hook = require(ReplicatedRoot.Libraries.Classes.Hook);

if Core.Flags.UseNewHitboxSystem == false then
    return v1;
end;

function v1.Init(u2) -- Line: 18
    -- upvalues: TableUtil (copy), AssetService (copy), Core (copy)
    u2.HitboxModules = {
        Cast = require(script.Types.Cast),
        NetworkCast = require(script.Types.NetworkCast)
    };

    function u2._Hitbox(p3) -- Line: 24
        -- upvalues: u2 (copy), TableUtil (ref), AssetService (ref), Core (ref)
        local u4 = p3 or {};
        local Caster = u4.Caster;
        local Move = u4.Move;

        if Move ~= nil and Caster == nil then
            Caster = Move.Character;
        end;

        local v5 = u4.ExtraInfo or (u4.ExtraStats or {});
        local v6 = u4.Info or (u4.Stats or {});

        if Move ~= nil then
            if typeof(v5) == "string" then
                v5 = u2.ResolveFromMove(Move, v5);
            end;

            if typeof(v6) == "string" then
                v6 = u2.ResolveFromMove(Move, v6);
            end;
        end;

        local v7 = TableUtil.Reconcile(v5, v6);
        local v8 = v7.Hitbox or v7;
        local Callback = u4.Callback;

        local function RunCallback(p9) -- Line: 48
            -- upvalues: Callback (copy), u4 (copy)
            if Callback then
                return Callback(u4, p9);
            end;
        end;

        if v8.CompensationType == nil and Move ~= nil then
            v8.CompensationType = "Regulate";
        end;

        local v10;

        if Caster then
            v10 = u2.GetMetadata(Caster, v8) or nil;
        else
            v10 = nil;
        end;

        local v11;

        if Caster then
            v11 = u2.GetObjects(Caster).RootPart or nil;
        else
            v11 = nil;
        end;

        local v12 = nil;

        if typeof(v8.RelativePart) == "Instance" then
            v12 = v8.RelativePart;
        elseif typeof(v8.RelativePart) == "string" then
            v12 = AssetService.ResolvePath({
                Root = Caster,
                Path = v8.RelativePart
            }) or Caster:FindFirstChild(v8.RelativePart, true);
        end;

        u4.Parameters = OverlapParams.new();
        u4.Parameters.FilterType = v8.Parameters and v8.Parameters.FilterType or Enum.RaycastFilterType.Include;
        u4.Parameters.FilterDescendantsInstances = v8.Parameters and v8.Parameters.FilterDescendantsInstances or { workspace.Living };
        u4.Parameters.CollisionGroup = v8.Parameters and (v8.Parameters.CollisionGroup or "Raycast") or "Raycast";
        u4.Parameters.MaxParts = v8.Parameters and (v8.Parameters.MaxParts or 0) or 0;
        u4.Info = v7;
        u4.HitboxInfo = v8;
        u4.Move = Move;
        u4.Caster = Caster;
        u4.WorldModel = u4.WorldModel or workspace;
        u4.Part = v8.Part;
        u4.Origin = v8.Origin or v10 and (v8.Predict ~= false and v10.Predicted or v10.CFrame) or CFrame.identity;
        u4.Size = v8.Size;
        u4.Offset = v8.Offset or CFrame.identity;
        u4.Cache = u4.Cache;

        if v11 and (v12 and (v8.OffsetRelativePart ~= false and v12 ~= v11)) then
            u4.Origin = u4.Origin * v11.CFrame:ToObjectSpace(v12.CFrame);
        end;

        if u4.Offset and u4.Offset ~= CFrame.identity then
            u4.Origin = u4.Origin * u4.Offset;
        end;

        u4.IgnoreNPCS = v8.IgnoreNPCS or (v7.IgnoreNPCS or false);
        u4.FriendlyFire = v8.FriendlyFire or (v7.FriendlyFire or false);
        u4.Hit = u4.Hit or {};
        u4.Query = nil;
        local v13 = u4.HitboxType or (v8.HitboxType or "Cast");
        local v14 = v13 == "ClientHitbox" and "NetworkCast" or (v13 == "ServerHitbox" and "Cast" or v13);
        local v15 = Caster:GetAttribute("NPC") and v14 == "NetworkCast" and "Cast" or v14;
        local v16 = u2.HitboxModules[v15];

        if v16 ~= nil then
            local v17 = v16.Cast(u4);

            if v16.Validate then
                v17 = v16.Validate(v17, u4) or v17;
            end;

            u4.Query = v17;
        end;

        local v18 = v8.QueryType or v8.Query;

        if v18 == "Characters" or v18 == nil then
            local v19 = {};

            for _, v in pairs(u4.Query) do
                if Caster and (not Caster or v:IsDescendantOf(Caster) and not v8.CanQueryCaster) then
                    if v7.Max and #u4.Hit >= v7.Max then
                        break;
                    end;
                else
                    local v20 = v.Parent:FindFirstChildOfClass("Humanoid");

                    if not (u4.Cache and u4.Cache[v.Parent]) then
                        if v20 and not v19[v.Parent] then
                            v19[v.Parent] = true;
                            local v21 = {
                                Character = v.Parent,
                                Part = v
                            };
                            local v22;

                            if Callback then
                                v22 = Callback(u4, v21);
                            else
                                v22 = nil;
                            end;

                            if v22 ~= false then
                                table.insert(u4.Hit, v21);
                            end;
                        end;

                        if v7.Max and #u4.Hit >= v7.Max then
                            break;
                        end;
                    end;
                end;
            end;
        elseif v18 == "Parts" then
            for _, v in pairs(u4.Query) do
                if not (u4.Cache and u4.Cache[v]) then
                    if not Caster or Caster and (not v:IsDescendantOf(Caster) or v7.IgnoreCaster == false) then
                        local v23;

                        if Callback then
                            v23 = Callback(u4, v);
                        else
                            v23 = nil;
                        end;

                        if v23 ~= false then
                            table.insert(u4.Hit, v);
                        end;
                    end;

                    if v7.Max and #u4.Hit >= v7.Max then
                        break;
                    end;
                end;
            end;
        end;

        local v24 = v15 ~= "NetworkCast" and (Caster and game.Players:GetPlayerFromCharacter(Caster));

        if v24 then
            local Settings = v24:FindFirstChild("Settings");

            if (Settings and Settings.HitboxDisplay.Value or v8.Debug == true) and v8.Hidden ~= true then
                Core.LegacyPath.Remotes.Output:FireClient(v24, "FX", "Visualize_Hitbox", u4.Origin, u4.Size, #u4.Hit > 0 and true or nil);
            end;
        end;

        return true;
    end;

    function u2.Hitbox(p25) -- Line: 187
        -- upvalues: u2 (copy)
        if u2.HitboxHook then
            local v26 = u2.HitboxHook:RunHook(p25);

            return v26 and v26.Hit or {};
        end;
    end;
end;

function v1.Start(u27) -- Line: 196
    -- upvalues: Hook (copy), Signal (copy)
    local v28 = Hook.new();
    v28:CreateStack("Inbound");
    v28:CreateStack("Event");
    v28:CreateStack("Outbound");
    u27.HitboxHook = v28;
    u27.HitboxCasted = Signal.new();
    u27.AddHook("Hitbox", v28);
    u27.HitboxHook:Hook("Event", "Main", 0, function(p29) -- Line: 211
        -- upvalues: u27 (copy)
        u27._Hitbox(p29);
    end);
    u27.HitboxHook:Hook("Outbound", "Return", 0, function(p30) -- Line: 215
        -- upvalues: u27 (copy)
        if p30 then
            local Caster = p30.Caster;
            local Hit = p30.Hit;

            if Caster:GetAttribute("NPC") and not Caster:GetAttribute("FriendlyFire") then
                for i = #Hit, 1, -1 do
                    if Hit[i].Character:GetAttribute("NPC") then
                        table.remove(Hit, i);
                    end;
                end;
            end;

            if p30.IgnoreNPCS then
                for i = #Hit, 1, -1 do
                    if Hit[i].Character:GetAttribute("NPC") then
                        table.remove(Hit, i);
                    end;
                end;
            end;

            local Stats = p30.Stats;
            local v31;

            if Stats then
                v31 = Stats.CheckPVPSafe;
            else
                v31 = Stats;
            end;

            local v32 = Stats and Stats.Damage and Stats.Damage > 0;

            if game.Players:GetPlayerFromCharacter(Caster) and (v32 or v31) then
                for i = #Hit, 1, -1 do
                    local Character = Hit[i].Character;

                    if Character:GetAttribute("PVPSafe") or Caster:GetAttribute("PVPSafe") and game.Players:GetPlayerFromCharacter(Character) then
                        table.remove(Hit, i);
                    end;
                end;
            end;

            if Caster and Caster:GetAttribute("HyperArmorFrozen") then
                table.clear(Hit);
            end;

            u27.HitboxCasted:Fire(p30);
        end;

        return false, p30;
    end);
end;

return v1;