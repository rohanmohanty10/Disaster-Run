  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("UserInputService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), VfxManager (copy), Essentials (copy), TweenService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and (game.Players.LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (game.Players.LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        table.clear(p1);

        return;
    end;

    local Team = p1.Team;
    local u2 = ReplicatedStorage.Assets.GoalEffects.Vaporwave.VFX.Effect:Clone();
    local Pos = p1.Pos;
    u2.Parent = workspace.Debris;
    u2.CFrame = Team and Team.Name == "Away" and Pos * CFrame.new(0, 4.8, 0) * CFrame.Angles(0, -3.141592653589793, 0) or Pos * CFrame.new(0, 4.8, 0);
    VfxManager.Emit(u2);
    local Field = workspace.Field:FindFirstChild("Field");

    if Field then
        local Color = Essentials:GetInitialData(Field, { "Color" }).Color;
        TweenService:Create(Field, TweenInfo.new(1), {
            Color = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.delay(3, function() -- Line: 34
            -- upvalues: TweenService (ref), Field (copy), Color (copy)
            TweenService:Create(Field, TweenInfo.new(1), {
                Color = Color
            }):Play();
        end);
    end;

    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Enabled = true;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            TweenService:Create(descendant, TweenInfo.new(1), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
            task.delay(3, function() -- Line: 47
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
                task.wait(1);
                descendant.Enabled = false;
            end);
        end;
    end;

    task.delay(5, function() -- Line: 55
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;