  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Color = workspace.Field.Field.Color;

return function(u1) -- Line: 13
    -- upvalues: SoundManager (copy), ReplicatedStorage (copy), Color (copy), RunService (copy)
    local Player = u1.Player;
    local u2 = script.saemetavisionvfxpart:Clone();
    local u3 = script["GRID FLOOR BEAM"]:Clone();
    u2.Parent = workspace;
    u3.Parent = workspace;
    workspace.Field.Field.Color = Color3.new(0, 0, 0);
    local u4 = nil;
    local u5 = SoundManager.SpawnSound("NELIsagiMetavisionLoop", 0.7, workspace, 150, true, true);
    u5:Play();
    local u6 = {};

    local function Disable() -- Line: 34
        -- upvalues: u6 (copy), ReplicatedStorage (ref), u4 (ref), u5 (ref), u2 (copy), u3 (copy), Color (ref), Disable (ref)
        task.spawn(function() -- Line: 36
            -- upvalues: u6 (ref), ReplicatedStorage (ref)
            for _, v in u6 do
                v:Destroy();
            end;

            local Highlight = ReplicatedStorage.Football.Value:FindFirstChild("Highlight");

            if Highlight then
                Highlight.FillColor = Color3.new(1, 1, 1);
            end;
        end);

        if u4 then
            u4:Disconnect();
            u4 = nil;
        end;

        if u5 then
            u5:Stop();
            u5:Destroy();
            u5 = nil;
        end;

        u2:Destroy();
        u3:Destroy();
        workspace.Field.Field.Color = Color;

        if Disable then
            Disable = nil;
        end;
    end;

    u4 = RunService.RenderStepped:Connect(function() -- Line: 60
        -- upvalues: ReplicatedStorage (ref), u6 (copy), Disable (ref), u1 (copy), Player (copy)
        local Value = ReplicatedStorage.Football.Value;

        if Value.Parent == workspace then
            for _, v in u6 do
                v:Destroy();
            end;

            local Highlight = Value:FindFirstChild("Highlight");

            if Highlight then
                Highlight.FillColor = Color3.new(1, 0, 0);
            end;
        elseif Value.Parent:FindFirstChild("Humanoid") then
            local Parent = Value.Parent;

            if not Parent:FindFirstChild("MetavisionHighlightIsagi") then
                local Highlight = Instance.new("Highlight");
                Highlight.FillColor = Color3.new(1, 0, 0);
                Highlight.FillTransparency = 0.5;
                Highlight.Name = "MetavisionHighlightIsagi";
                Highlight.Parent = Parent;
                table.insert(u6, Highlight);
            end;
        end;

        if ReplicatedStorage.GameValues.State.Value ~= "Playing" then
            if Disable then
                Disable();
            end;

            return;
        end;

        if u1.Omnivision and (not Player.Character.Values.HasBall.Value and Disable) then
            Disable();
        end;

        if u1.Upgraded then
            if Player.PlayerStats.AwakeningBar.Value <= 0 or (Player.PlayerStats.InAwakening.Value == false or Player.Team == game.Teams.Visitor) then
                if Disable then
                    Disable();
                end;
            end;
        elseif Player.PlayerStats.InAwakening.Value == true or Player.Team == game.Teams.Visitor then
            if Disable then
                Disable();
            end;
        end;
    end);

    if not u1.Upgraded then
        task.delay(u1.Omnivision and 8 or 15, function() -- Line: 109
            -- upvalues: Disable (ref)
            if Disable then
                Disable();
            end;
        end);
    end;
end;