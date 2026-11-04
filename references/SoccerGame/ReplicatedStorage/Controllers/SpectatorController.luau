  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");

if not RunService:IsRunning() then
    return {
        IsSpectating = true
    };
end;

local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Shared.Trove);
local TeamColors = require(ReplicatedStorage.Shared.TeamColors);
local Signal = require(Knit.Util.Signal);
local ControlModule = require(Knit.Player.PlayerScripts.PlayerModule.ControlModule);
local v1 = Knit.CreateController({
    Name = "SpectatorController",
    TargetChanged = Signal.new(),
    TargetListUpdated = Signal.new()
});

function v1.KnitInit(p2) -- Line: 27
    -- upvalues: Trove (copy), ReplicatedStorage (copy), Knit (copy)
    p2.IsSpectating = false;
    p2.Camera = workspace.CurrentCamera;
    p2.SpectateTargets = { "Ball" };
    p2.SpectatingTrove = Trove.new();
    p2.NametagConnectionTrove = Trove.new();
    p2.NametagBin = {};
    p2.GameState = ReplicatedStorage:WaitForChild("GameValues"):WaitForChild("State");
    p2.Player = Knit.Player;
end;

function v1.KnitStart(u3) -- Line: 42
    -- upvalues: Knit (copy), CollectionService (copy)
    u3.CameraController = Knit.GetController("CameraController");
    u3.GameState:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 45
        -- upvalues: u3 (copy)
        if u3.GameState.Value == "Lobby" and u3.IsSpectating then
            u3:StopSpectating();
        end;
    end);

    local function playerAdd(p4: userdata) -- Line: 51
        -- upvalues: u3 (copy)
        table.insert(u3.SpectateTargets, p4);
        table.sort(u3.SpectateTargets, function(p5, p6) -- Line: 54
            if p5 == "Ball" then
                return true;
            end;

            if p6 == "Ball" then
                return false;
            end;

            return p5.DisplayName < p6.DisplayName;
        end);

        if u3.IsSpectating then
            u3:_makeNametag(p4);
        end;

        u3.TargetListUpdated:Fire(p4);
    end;

    local function playerRemove(p7: userdata) -- Line: 73
        -- upvalues: u3 (copy)
        local table_find_ret = table.find(u3.SpectateTargets, p7);

        if not table_find_ret then
            warn("player was missing from spectator targets list..?");

            return;
        end;

        table.remove(u3.SpectateTargets, table_find_ret);

        if u3.IsSpectating then
            u3.NametagBin[p7]:Destroy();
            u3.NametagBin[p7] = nil;

            if u3.SpectatingTarget == p7 then
                local v8;

                if table_find_ret <= #u3.SpectateTargets then
                    v8 = u3.SpectateTargets[table_find_ret];
                else
                    v8 = u3.SpectateTargets[#u3.SpectateTargets];
                end;

                if v8 == nil then
                    u3:StopSpectating();
                else
                    u3:Spectate(v8);
                end;
            end;
        end;

        u3.TargetListUpdated:Fire(nil, p7);
    end;

    for _, v in CollectionService:GetTagged("PlayingTeam") do
        v.PlayerAdded:Connect(playerAdd);
        v.PlayerRemoved:Connect(playerRemove);

        for _, v2 in v:GetPlayers() do
            playerAdd(v2);
        end;
    end;
end;

function v1.Spectate(u9, p10) -- Line: 117
    -- upvalues: UserInputService (copy), ControlModule (copy)
    if u9.GameState.Value == "Lobby" then
        return;
    end;

    if not u9.IsSpectating then
        for _, v in u9.SpectateTargets do
            if v ~= "Ball" then
                u9:_makeNametag(v);
            end;
        end;
    end;

    u9.IsSpectating = true;
    u9.SpectatingTarget = p10;
    u9.TargetChanged:Fire(p10);
    u9.SpectatingTrove:Clean();

    if typeof(p10) == "Instance" then
        for i, v in u9.NametagBin do
            v.Enabled = i ~= p10;
        end;

        u9.SpectatingTrove:Connect(p10.CharacterAdded, function(p11) -- Line: 144
            -- upvalues: u9 (copy)
            u9.Camera.CameraSubject = p11.Humanoid;
        end);

        if p10.Character then
            u9.Camera.CameraSubject = p10.Character.Humanoid;
        end;
    else
        for _, v in u9.NametagBin do
            v.Enabled = true;
        end;

        local function findFootball(p12: userdata?) -- Line: 156
            -- upvalues: u9 (copy), findFootball (copy)
            local u13 = p12 or workspace:FindFirstChild("Football", true);

            if u13 then
                u9.Camera.CameraSubject = u13;
                u9.SpectatingTrove:Connect(u13:GetPropertyChangedSignal("Parent"), function() -- Line: 162
                    -- upvalues: u13 (copy), findFootball (ref)
                    if u13.Parent == nil then
                        findFootball();
                    end;
                end);

                return;
            end;

            local u14 = nil;
            u14 = u9.SpectatingTrove:Connect(workspace.DescendantAdded, function(p15) -- Line: 169
                -- upvalues: findFootball (ref), u14 (ref)
                if p15.Name == "Football" then
                    findFootball(p15);
                    u14:Disconnect();
                end;
            end);
        end;

        findFootball();
    end;

    u9.Player.PlayerGui.HUD.Enabled = false;
    u9.Player.PlayerGui.Spectate.Enabled = true;

    if UserInputService.TouchEnabled then
        u9.Player.PlayerGui.Mobile.Enabled = false;
        u9.Player.PlayerGui.MobileInLobby.Enabled = false;
    end;

    ControlModule:Disable();
end;

function v1.Spectating(p16) -- Line: 191
    return p16.IsSpectating;
end;

function v1.StopSpectating(p17, p18) -- Line: 196
    -- upvalues: ReplicatedStorage (copy), UserInputService (copy), ControlModule (copy)
    if p17.Camera.CameraType == Enum.CameraType.Scriptable then
        local Popup = require(ReplicatedStorage.Shared.Popup);

        if not p18 then
            Popup.Popup(nil, "Can\'t stop spectating right now!");
        end;

        return;
    end;

    p17.IsSpectating = false;
    p17.SpectatingTarget = nil;
    p17.TargetChanged:Fire(nil);
    p17.SpectatingTrove:Clean();
    p17.NametagConnectionTrove:Clean();

    for _, v in p17.NametagBin do
        v:Destroy();
    end;

    p17.NametagBin = {};
    p17.Camera.CameraSubject = p17.Player.Character.Humanoid;
    p17.Player.PlayerGui.HUD.Enabled = true;
    p17.Player.PlayerGui.Spectate.Enabled = false;

    if UserInputService.TouchEnabled then
        p17.Player.PlayerGui.Mobile.Enabled = true;
    end;

    ControlModule:Enable();
end;

function v1._makeNametag(p19: table, p20: userdata) -- Line: 230
    -- upvalues: ReplicatedStorage (copy), TeamColors (copy)
    local u21 = ReplicatedStorage.Assets.UI.SpectatorNametag:Clone();
    u21.DisplayName.Text = p20.DisplayName;
    u21.Username.Text = `@{p20.Name}`;
    local Name = p20.Team.Name;
    u21.DisplayName.TextColor3 = TeamColors[Name][ReplicatedStorage.GameValues[Name .. "Index"].Value];
    u21.Username.TextColor3 = TeamColors[Name][ReplicatedStorage.GameValues[Name .. "Index"].Value];
    local _, _, v22 = u21.DisplayName.TextColor3:ToHSV();
    local UIStroke = u21.DisplayName.UIStroke;
    local v23;

    if v22 <= 0.5 then
        v23 = Color3.new(1, 1, 1);
    else
        v23 = Color3.new(0, 0, 0);
    end;

    UIStroke.Color = v23;
    local UIStroke2 = u21.Username.UIStroke;
    local v24;

    if v22 <= 0.5 then
        v24 = Color3.new(1, 1, 1);
    else
        v24 = Color3.new(0, 0, 0);
    end;

    UIStroke2.Color = v24;
    local v25 = p19.NametagConnectionTrove:Extend();
    v25:Connect(p20.CharacterAdded, function(p26) -- Line: 246
        -- upvalues: u21 (copy)
        u21.Adornee = p26.HumanoidRootPart;
    end);

    if p20.Character then
        u21.Adornee = p20.Character.HumanoidRootPart;
    end;

    u21.Parent = p19.Player.PlayerGui;
    v25:AttachToInstance(u21);
    p19.NametagBin[p20] = u21;
end;

return v1;