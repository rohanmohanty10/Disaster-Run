  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Classes.Entity);
require(ReplicatedRoot.Assets.Classes.Character);
require(ReplicatedRoot.Services.StateService);
require(ReplicatedRoot.Services.HandlerService);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
require(ReplicatedRoot.Libraries.Networking.Replica);

return {
    ClassName = "CharacterClient",

    EntityInit = function(u1, p2) -- Line: 15, Name: EntityInit
        -- upvalues: ReplicatedRoot (copy), Core (copy)
        if u1.Replica ~= nil then
            if u1.Replica.Data.MoveFlags then
                u1.MoveFlags = u1.Replica.Data.MoveFlags;
            end;

            u1.Replica:OnChange(function(p3, p4, p5) -- Line: 21
                -- upvalues: u1 (copy)
                if p3 == "Set" and p4[1] == "MoveFlags" then
                    if p4[2] then
                        u1.MoveFlags[p4[2]] = p5;
                        u1.MoveFlagChanged:Fire(p4[2], p5);

                        return;
                    end;

                    local MoveFlags = u1.MoveFlags;
                    u1.MoveFlags = p5;

                    for i, v in pairs(u1.MoveFlags) do
                        if v ~= MoveFlags[i] then
                            u1.MoveFlagChanged:Fire(i, v);
                        end;
                    end;
                end;
            end);
        end;

        local MoveService = require(ReplicatedRoot.Services.Gameplay.MoveService);
        local v6 = Core.GetLegacyService("MoveIndicatorController");
        local StateHandler = require(game.ReplicatedStorage.ReplicatedModules.StateHandler);
        local u7 = v6.GetSingleton();

        local function UpdateIndicator(p8) -- Line: 46
            -- upvalues: MoveService (copy), u1 (copy), u7 (copy), StateHandler (copy)
            if not p8.Enabled then
                return;
            end;

            local v9 = {};

            for _, v in pairs(p8:GetBinds()) do
                if v.Flag then
                    v9[v.Flag] = true;
                end;
            end;

            local v10 = false;

            for i, v in pairs(p8.Flags) do
                if not v9[i] and MoveService.GetMoveFlag(u1.Character, i) ~= v then
                    v10 = true;
                end;
            end;

            local v11 = not v10 and true or false;
            local v12 = (p8.Data.Info or {}).State or "Universal";

            if not u7:GetGroup(v12) then
                return;
            end;

            local v13 = u7:GetMove(v12, p8.Name);

            if v13 and v13.MoveVisible ~= v11 then
                StateHandler.SetState(u1.Character, `{p8.Name}_Move`, v11, {
                    Attributes = {
                        Move = true
                    }
                });
                v13.MoveVisible = v11;
                u7.VisibilityUpdated:Fire();
            end;
        end;

        local function UpdateIndicators() -- Line: 114
            -- upvalues: u1 (copy), UpdateIndicator (copy)
            for _, v in u1.Moves do
                xpcall(UpdateIndicator, function(p14) -- Line: 116
                    warn(p14, debug.traceback());
                end, v);
            end;
        end;

        UpdateIndicators();
        u1.MoveAdded:Connect(function(u15) -- Line: 123
            -- upvalues: UpdateIndicator (copy)
            u15.Collector:Connect(u15.OnEnabled, function() -- Line: 124
                -- upvalues: UpdateIndicator (ref), u15 (copy)
                UpdateIndicator(u15);
            end);
            u15.Collector:Connect(u15.OnDisabled, function() -- Line: 127
                -- upvalues: UpdateIndicator (ref), u15 (copy)
                UpdateIndicator(u15);
            end);
        end);
        u1.MoveFlagChanged:Connect(function() -- Line: 132
            -- upvalues: UpdateIndicators (copy)
            UpdateIndicators();
        end);
    end
};