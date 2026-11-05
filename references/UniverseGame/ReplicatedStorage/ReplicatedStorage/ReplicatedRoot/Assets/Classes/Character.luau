  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Classes.Entity);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local CombatService = require(ReplicatedRoot.Services.CombatService);
require(ReplicatedRoot.Libraries.Networking.Replica);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);

return {
    ClassName = "Character",

    ClassInit = function(u1, p2) -- Line: 44, Name: ClassInit
        -- upvalues: Signal (copy), CombatService (copy)
        local Object = u1.Object;

        if Object == nil then
            return;
        end;

        u1.Player = game.Players:GetPlayerFromCharacter(u1.Object);
        u1.Character = u1.Object;
        u1.Humanoid = Object:WaitForChild("Humanoid");
        u1.RootPart = Object:WaitForChild("HumanoidRootPart");
        u1.Abilities = {};
        u1.Rigs = {};
        u1.Sequences = {};
        u1.Moves = {};
        u1.MoveFlags = {};
        u1.MoveAdded = u1.Collector:Construct(Signal);
        u1.MoveRemoved = u1.Collector:Construct(Signal);
        u1.MoveFlagChanged = u1.Collector:Construct(Signal);
        u1.Cooldowns = {};
        u1.CooldownAdded = u1.Collector:Construct(Signal);
        u1.CooldownRemoved = u1.Collector:Construct(Signal);
        u1.CooldownsUpdated = u1.Collector:Construct(Signal);
        u1.CooldownThread = nil;

        local function HandleCooldowns() -- Line: 73
            -- upvalues: u1 (copy), CombatService (ref)
            while u1 and (u1.Character and u1.Character:IsDescendantOf(game)) do
                local v3 = task.wait();
                local v4 = false;

                for i, v in pairs(u1.Cooldowns) do
                    if v.Time then
                        v.Time = math.max(0, v.Time - v3);

                        if v.Time <= 0 and v.ServerSynced == false then
                            CombatService.ClearCooldown(u1.Character, i);
                        end;

                        v4 = true;
                    end;
                end;

                u1.CooldownsUpdated:Fire(v3);

                if not v4 then
                    break;
                end;
            end;

            u1.CooldownThread = nil;
        end;

        u1.CooldownAdded:Connect(function(p5) -- Line: 97
            -- upvalues: u1 (copy), HandleCooldowns (copy)
            if u1.CooldownThread == nil then
                u1.CooldownThread = task.spawn(HandleCooldowns);
            end;
        end);
        u1.Collector:Add(function() -- Line: 103
            -- upvalues: u1 (copy)
            if u1.CooldownThread then
                task.cancel(u1.CooldownThread);
                u1.CooldownThread = nil;
            end;
        end);
    end
};