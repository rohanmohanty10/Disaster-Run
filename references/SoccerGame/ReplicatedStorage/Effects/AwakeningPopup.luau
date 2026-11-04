  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 12
    -- upvalues: SpectatorController (copy), Popup (copy), SoundManager (copy)
    task.spawn(function() -- Line: 13
        -- upvalues: u1 (copy), SpectatorController (ref), Popup (ref), SoundManager (ref)
        local v2 = u1.Plrs or { u1.Plr };
        local v3 = {};

        for _, v in v2 do
            if v then
                table.insert(v3, v.Name);
            end;
        end;

        if #v3 == 0 then
            return;
        end;

        local v4 = #v2 > 1;
        local v5 = v4 and "Overtime Awakenings Spawn in " or "Awakening Spawns in ";

        for i = 5, 1, -1 do
            if game.Players.LocalPlayer.Team ~= game.Teams.Visitor or SpectatorController.IsSpectating then
                Popup.Popup(game.Players.LocalPlayer, v5 .. tostring(i));
            end;

            task.wait(1);
            local _ = i;
        end;

        if not (game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating or table.find(v2, game.Players.LocalPlayer)) then
            SoundManager.SpawnSound("Gain", 0.5, game.SoundService.SFX, 1);

            if v4 then
                Popup.Popup(game.Players.LocalPlayer, "OVERTIME AWAKENINGS SPAWNED ON " .. table.concat(v3, " & "));

                return;
            end;

            Popup.Popup(game.Players.LocalPlayer, "AWAKENING SPAWNED IN ON " .. v3[1]);
        end;
    end);
end;