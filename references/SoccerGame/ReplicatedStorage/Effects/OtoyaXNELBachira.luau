  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local TeamJerseys = require(ReplicatedStorage.Shared.TeamJerseys);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local LocalPlayer = Players.LocalPlayer;
local u1 = tick();

return function(u2) -- Line: 18
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), ReplicatedStorage (copy), u1 (ref), TeamJerseys (copy), TweenService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Name = LocalPlayer.Team.Name;
    local GK = (ReplicatedStorage.Teams:FindFirstChild(Name) or ReplicatedStorage.Teams:FindFirstChild((`{Name}Team`))):FindFirstChild("GK");

    if GK and GK.Value == game.Players.LocalPlayer then
        return;
    end;

    if u1 > tick() then
        return;
    end;

    u1 = tick() + 3;
    local ChemicalUI = game.Players.LocalPlayer.PlayerGui.ChemicalUI;
    local u3 = ReplicatedStorage.Assets.UI.Reactions:Clone();
    u3.Parent = ChemicalUI;
    local Chemical = u3.Chemical;
    local ChemicalStroke = u3.ChemicalStroke;
    local PlrName = u3.PlrName;
    local Txt = u3.Txt;
    local Camera = Instance.new("Camera");
    Camera.Parent = Chemical;
    Camera.CFrame = CFrame.new(0, 0, 0) * CFrame.fromEulerAnglesXYZ(0, 0, (math.rad(-Chemical.AbsoluteRotation)));
    Chemical.CurrentCamera = Camera;
    ChemicalStroke.Position = UDim2.new(0.51, 0, 0.477, 0);
    task.spawn(function() -- Line: 50
        -- upvalues: u2 (copy), Chemical (copy), TeamJerseys (ref), ReplicatedStorage (ref)
        local v4 = workspace:FindFirstChild(u2.Player1);
        v4.Archivable = true;
        local v5 = v4:Clone();
        v5.Parent = Chemical.Inside;
        v5.HumanoidRootPart.CFrame = Chemical.Inside.Plr1.HumanoidRootPart.CFrame;
        v5.HumanoidRootPart.Anchored = true;
        local v6 = workspace:FindFirstChild(u2.Player2);
        v6.Archivable = true;
        local v7 = v6:Clone();
        v7.Parent = Chemical.Inside;
        v7.HumanoidRootPart.CFrame = Chemical.Inside.Plr2.HumanoidRootPart.CFrame;
        v7.HumanoidRootPart.Anchored = true;
        local v8 = game.Players:FindFirstChild(v5.Name);
        local v9 = game.Players:FindFirstChild(v7.Name);

        if v8.Team ~= game.Teams.Visitor then
            local Shirt = v5.Shirt;
            local v10 = TeamJerseys[v8.Team.Name];
            local Value = ReplicatedStorage.GameValues[`{v8.Team.Name}Index`].Value;
            Shirt.ShirtTemplate = v10[tostring(Value)].Shirt;
            local Pants = v5.Pants;
            local v11 = TeamJerseys[v8.Team.Name];
            local Value2 = ReplicatedStorage.GameValues[`{v8.Team.Name}Index`].Value;
            Pants.PantsTemplate = v11[tostring(Value2)].Pants;
        end;

        if v9.Team ~= game.Teams.Visitor then
            local Shirt = v7.Shirt;
            local v12 = TeamJerseys[v9.Team.Name];
            local Value = ReplicatedStorage.GameValues[`{v9.Team.Name}Index`].Value;
            Shirt.ShirtTemplate = v12[tostring(Value)].Shirt;
            local Pants = v7.Pants;
            local v13 = TeamJerseys[v9.Team.Name];
            local Value2 = ReplicatedStorage.GameValues[`{v9.Team.Name}Index`].Value;
            Pants.PantsTemplate = v13[tostring(Value2)].Pants;
        end;

        Chemical.Inside.Plr1:Destroy();
        Chemical.Inside.Plr2:Destroy();
        local v14 = v5.Humanoid:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.ChemicalReaction.Plr1);
        local v15 = v7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.ChemicalReaction.Plr2);
        v14:Play();
        v15:Play();
        v14:Destroy();
        v15:Destroy();
    end);
    u3.Chemical.Size = UDim2.fromScale(1.2, 0.35);
    u3.ChemicalStroke.Position = UDim2.fromScale(0.51, 0.38999999999999996);
    local v16 = TweenService:Create(u3, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.46, 0)
    });
    local u17 = TweenService:Create(Chemical.WeHave, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Offset = Vector2.new(0, 0)
    });
    local u18 = TweenService:Create(ChemicalStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.197, 0, 0.38999999999999996, 0),
        Position = UDim2.new(0.5, 0, 0.253, 0)
    });
    local u19 = TweenService:Create(PlrName, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.165, 0, 0.079, 0)
    });
    v16:Play();
    u17:Play();
    u18:Play();
    u19:Play();

    local function WriteText(u20, u21) -- Line: 114
        task.spawn(function() -- Line: 115
            -- upvalues: u21 (copy), u20 (copy)
            for i = 1, string.len(u21) do
                u20.Text = string.sub(u21, 1, i);
                task.wait(0.02);
                local _ = i;
            end;
        end);
    end;

    local Player2 = u2.Player2;
    task.spawn(function() -- Line: 115
        -- upvalues: Player2 (copy), PlrName (copy)
        for i = 1, string.len(Player2) do
            PlrName.Text = string.sub(Player2, 1, i);
            task.wait(0.02);
            local _ = i;
        end;
    end);
    task.delay(1, function() -- Line: 125
        -- upvalues: Txt (copy), TweenService (ref)
        local u22 = Txt;
        local u23 = ".. Lets win";
        task.spawn(function() -- Line: 115
            -- upvalues: u23 (copy), u22 (copy)
            for i = 1, string.len(u23) do
                u22.Text = string.sub(u23, 1, i);
                task.wait(0.02);
                local _ = i;
            end;
        end);
        TweenService:Create(Txt, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.769, 0, 0.421, 0)
        }):Play();
    end);
    task.delay(1.8, function() -- Line: 135
        -- upvalues: Txt (copy), u2 (copy), PlrName (copy)
        task.spawn(function() -- Line: 136
            -- upvalues: Txt (ref)
            for i = 1, 11 do
                Txt.Text = string.sub(".. Lets win", i, 11);
                task.wait(0.02);
                local _ = i;
            end;

            Txt.Text = "";
        end);
        task.spawn(function() -- Line: 143
            -- upvalues: u2 (ref), PlrName (ref)
            for i = 1, string.len(u2.Player2) do
                local Player22 = u2.Player2;
                local v24 = string.len(u2.Player2) - i;
                PlrName.Text = string.sub(Player22, 1, v24);
                task.wait(0.02);
                local _ = i;
            end;

            PlrName.Text = "";
        end);
    end);
    task.delay(2, function() -- Line: 152
        -- upvalues: TweenService (ref), u3 (copy), Chemical (copy), ChemicalStroke (copy)
        local u25 = TweenService:Create(u3, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = UDim2.new(0.5, 0, 0.44, 0)
        });
        local u26 = TweenService:Create(Chemical.WeHave, TweenInfo.new(0.85, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Offset = Vector2.new(0, -1)
        });
        u26:Play();
        local u27 = TweenService:Create(ChemicalStroke, TweenInfo.new(0.85, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.new(1.197, 0, 0, 0),
            Position = UDim2.new(0.49, 0, 0.007, 0)
        });
        u27:Play();
        u25:Play();
        task.delay(1, function() -- Line: 169
            -- upvalues: u25 (copy), u26 (copy), u27 (copy)
            u25:Destroy();
            u26:Destroy();
            u27:Destroy();
        end);
    end);
    task.delay(3, function() -- Line: 176
        -- upvalues: u19 (copy), u17 (copy), u18 (copy), u3 (copy)
        u19:Destroy();
        u17:Destroy();
        u18:Destroy();
        u3:Destroy();
    end);
end;