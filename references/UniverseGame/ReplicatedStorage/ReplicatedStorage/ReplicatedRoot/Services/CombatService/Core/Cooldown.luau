  

 

local v1 = {};
local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Classes.Promise);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local CommonUtil = require(ReplicatedRoot.Libraries.Utility.CommonUtil);
local TagService = require(ReplicatedRoot.Services.TagService);
require(ReplicatedRoot.Services.StateService);
require(ReplicatedRoot.Services.SequenceService);
local WorldService = require(ReplicatedRoot.Services.Gameplay.WorldService);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local Cooldown = require(ReplicatedRoot.Libraries.Networking.Packets.Cooldown);

function v1.Init(u2) -- Line: 22
    -- upvalues: WorldService (copy), TableUtil (copy), TagService (copy), CommonUtil (copy), Core (copy), Cooldown (copy)
    function u2.GetCooldowns(p3) -- Line: 23
        -- upvalues: WorldService (ref)
        local v4 = WorldService.GetCharacterEntity(p3);

        return v4 and v4.Cooldowns or {};
    end;

    function u2.FindCooldown(p5, p6) -- Line: 28
        -- upvalues: u2 (copy)
        if typeof(p6) == "table" and p6.Name ~= nil then
            p6 = p6.Name;
        end;

        return u2.GetCooldowns(p5)[p6];
    end;

    function u2.HasCooldown(p7, p8) -- Line: 36
        -- upvalues: u2 (copy)
        return u2.GetCooldown(p7, p8) ~= nil;
    end;

    function u2.SetCooldown(p9, p10, p11) -- Line: 44
        -- upvalues: WorldService (ref), TableUtil (ref), u2 (copy), TagService (ref), CommonUtil (ref), Core (ref), Cooldown (ref)
        if not p9:GetAttribute("URF") then
            local v12 = game.Players:GetPlayerFromCharacter(p9);
            local v13 = WorldService.GetCharacterEntity(p9);
            local v14 = p10 or {};

            if p11 then
                v14 = TableUtil.Reconcile(p11, v14);
            end;

            local Name = v14.Name;
            local Time = v14.Time;
            local v15 = v14.Length or Time;
            local v16 = workspace:GetServerTimeNow();
            local v17 = v14.ExternalScaleModifier or 1;
            local v18 = v14.ReductionFloor or 0.75;
            local v19 = v14.IgnoreExternal or false;
            local v20 = v14.IgnoreTags or v19;

            if v14.ServerCreated then
                local v21 = v13.Cooldowns[Name];
                local v22 = v16 - v14.ServerCreated;

                if v22 > 0 then
                    Time = Time - v22;
                elseif v21 then
                    return;
                end;
            end;

            local v23 = {};

            if (v14.IgnoreTraits or v19) ~= true then
                local v24 = u2.GetTraitValues(p9, {
                    Type = "CooldownTrait",
                    Key = "CooldownReduction"
                });
                local CooldownReduction = v24.CooldownReduction;

                if CooldownReduction then
                    table.insert(v23, 1 - CooldownReduction);
                end;

                local CooldownMultiplier = v24.CooldownMultiplier;

                if CooldownMultiplier then
                    table.insert(v23, CooldownMultiplier);
                end;
            end;

            if v20 ~= true then
                local v25 = TagService.GetContainer(p9);

                if v25 then
                    local v26 = {};

                    for _, v in pairs(TagService.GetTags(v25)) do
                        if v:IsA("NumberValue") or v:IsA("IntValue") then
                            if v.Name == "CooldownMultiplier" then
                                table.insert(v23, v.Value);
                            elseif v.Name == "CooldownReduction" then
                                table.insert(v26, v.Value);
                            end;
                        end;
                    end;

                    if #v26 > 0 then
                        local v27 = CommonUtil.CombineMultipliers(v26);
                        local v28 = math.max(v27, v18);
                        table.insert(v23, v28);
                    end;
                end;
            end;

            if #v23 > 0 then
                local v29 = CommonUtil.CombineMultipliers(v23);
                local v30 = math.lerp(1, v29, v17);
                Time = Time * v30;
                v15 = v15 * v30;
            end;

            local v31 = {
                Name = Name,
                MoveName = v14.MoveName or Name,
                Time = Time,
                Length = v15,
                Created = v16,
                ServerSynced = v14.ServerCreated ~= nil
            };

            if Core.Context == "Server" and v12 ~= nil then
                local Cooldowns = v12:FindFirstChild("Cooldowns");

                if Cooldowns then
                    local StringValue = Instance.new("StringValue");
                    StringValue.Name = v31.MoveName;
                    StringValue:SetAttribute("Start", v16);
                    StringValue:SetAttribute("Duration", Time);
                    StringValue.Parent = Cooldowns;
                    v31.Object = StringValue;
                end;

                Cooldown.SetCooldown.sendTo({
                    Character = p9,
                    Name = v31.Name,
                    MoveName = v31.MoveName,
                    Time = v31.Time,
                    Length = v31.Length,
                    ServerCreated = v31.Created
                }, v12);
            end;

            v13.Cooldowns[Name] = v31;
            v13.CooldownAdded:Fire(v31);

            return v31;
        end;
    end;

    function u2.ClearCooldown(p32, p33) -- Line: 164
        -- upvalues: WorldService (ref), Core (ref), Cooldown (ref)
        local v34 = game.Players:GetPlayerFromCharacter(p32);
        local v35 = WorldService.GetCharacterEntity(p32);
        local v36 = v35.Cooldowns[p33];

        if v36 then
            if v36.Object then
                v36.Object:Destroy();
            end;

            v35.Cooldowns[p33] = nil;
            v35.CooldownRemoved:Fire(v36);

            if Core.Context == "Server" and v34 ~= nil then
                Cooldown.ClearCooldown.sendTo({
                    Character = p32,
                    Name = p33
                }, v34);
            end;
        end;
    end;
end;

function v1.Start(u37) -- Line: 186
    -- upvalues: Core (copy), Cooldown (copy)
    if Core.Context == "Client" then
        Cooldown.SetCooldown.listen(function(p38) -- Line: 188
            -- upvalues: u37 (copy)
            u37.SetCooldown(p38.Character, {
                IgnoreExternal = true,
                Name = p38.Name,
                Time = p38.Time,
                Length = p38.Length,
                ServerCreated = p38.ServerCreated
            });
        end);
        Cooldown.ClearCooldown.listen(function(p39) -- Line: 198
            -- upvalues: u37 (copy)
            u37.ClearCooldown(p39.Character, p39.Name);
        end);
    end;
end;

return v1;