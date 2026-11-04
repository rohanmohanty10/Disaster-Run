  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1, u2, p3) -- Line: 17, Name: SaeMetaVision
    -- upvalues: RunService (copy), ReplicatedStorage (copy), SpectatorController (copy)
    local u4 = {};
    local u5 = {};
    local u6 = {};
    local u7 = nil;

    local function DISABLE() -- Line: 32
        -- upvalues: u1 (copy), u6 (copy), u7 (ref), u4 (copy), u5 (copy), DISABLE (ref)
        if u1.ABC then
            u1.ABC:Clean();
        end;

        for _, v in pairs(u6) do
            task.defer(function() -- Line: 36
                -- upvalues: v (copy)
                for _, v2 in pairs(v) do
                    if v2.CooldownTween then
                        v2.CooldownTween:Cancel();
                    end;

                    if v2.Template then
                        v2.Template:Destroy();
                    end;
                end;
            end);
        end;

        if u7 then
            u7:Disconnect();
            u7 = nil;
        end;

        for _, v in pairs(u4) do
            v:Destroy();
        end;

        for _, v in pairs(u5) do
            if v and v.Connected then
                v:Disconnect();
            end;
        end;

        if DISABLE then
            DISABLE = nil;
        end;
    end;

    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 62
        -- upvalues: ReplicatedStorage (ref), DISABLE (ref), SpectatorController (ref), u2 (copy)
        if ReplicatedStorage.GameValues.State.Value ~= "Playing" then
            if DISABLE then
                DISABLE();
            end;

            return;
        end;

        if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
            return;
        end;

        local v9 = {};

        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= u2 and v.Character then
                table.insert(v9, v.Character);
            end;
        end;
    end);
    table.insert(u5, u2.CharacterRemoving:Once(function() -- Line: 80
        -- upvalues: DISABLE (ref)
        if DISABLE then
            DISABLE();
        end;
    end));
end;