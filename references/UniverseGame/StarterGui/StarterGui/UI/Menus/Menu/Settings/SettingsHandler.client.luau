  

 

if game.PlaceId == 5431771993 and game.Players.LocalPlayer.UserId == 314716019 then
    script.Parent:SetAttribute("Menu", "Settings");

    return;
end;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local LocalPlayer = game.Players.LocalPlayer;
local Parent = script.Parent;
local Settings = LocalPlayer:WaitForChild("Settings");
local ReplicatedAssets = ReplicatedStorage.ReplicatedAssets;
local u1 = {
    PartsList = {},
    Connections = {},
    MapFolders = { workspace.Map:WaitForChild("Decoration", 5) }
};
local u7 = {
    ["Damage Indicator"] = {
        Type = "Toggle",
        Value = true
    },
    ["Stun Indicator"] = {
        Type = "Toggle",
        Value = true
    },
    ["Mute Music"] = {
        Type = "Toggle",
        Value = false,

        Function = function(p2) -- Line: 36, Name: Function
            -- upvalues: u1 (copy)
            local u3 = workspace.ServerInformation.MusicPlayer:FindFirstChildWhichIsA("Sound");

            if p2 == true then
                u1.Connections.MuteConnection = u3.Changed:Connect(function(p4) -- Line: 39
                    -- upvalues: u3 (copy)
                    if p4 == "Volume" and u3.Volume ~= 0 then
                        u3.Volume = 0;
                    end;
                end);
                u3.Volume = 0;

                return;
            end;

            if u1.Connections.MuteConnection then
                u1.Connections.MuteConnection:Disconnect();
            end;

            u3.Volume = 0.5;
        end
    },
    ["Low GFX"] = {
        Type = "Toggle",
        Value = false,

        Function = function(p5) -- Line: 57, Name: Function
            -- upvalues: u1 (copy), ReplicatedAssets (copy)
            if not p5 then
                for _, v in ipairs(u1.MapFolders) do
                    v.Parent = workspace.Map;
                end;

                for i, v in pairs(u1.PartsList) do
                    i.Material = v;
                end;

                return;
            end;

            for _, v in ipairs(u1.MapFolders) do
                v.Parent = ReplicatedAssets;
            end;

            u1.PartsList = {};

            for _, descendant in pairs(workspace.Map:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    u1.PartsList[descendant] = descendant.Material;
                    descendant.Material = "SmoothPlastic";
                end;
            end;
        end
    },
    ["Camera Shake"] = {
        Type = "Toggle",
        Value = true
    },
    ["Reduced Particles"] = {
        Type = "Toggle",
        Value = false
    },
    Gore = {
        Type = "Toggle",
        Value = false
    },
    Trading = {
        Type = "Toggle",
        Value = false,

        Function = function(p6) -- Line: 98, Name: Function
            game.ReplicatedStorage.Remotes.Settings:FireServer("Trading", p6);
        end
    }
};
local v13 = {
    Toggle = function(u8, p9) -- Line: 105
        -- upvalues: Settings (copy), u7 (copy)
        local BoolValue = Instance.new("BoolValue");
        BoolValue.Name = u8;
        BoolValue.Value = p9.Value;
        BoolValue.Parent = Settings;
        BoolValue.Changed:Connect(function(p10) -- Line: 111
            -- upvalues: u7 (ref), u8 (copy)
            u7[u8].Value = p10;
        end);
    end,

    Slider = function(p11, p12) -- Line: 116
    end
};

for i, v in pairs(u7) do
    v13[v.Type](i, v);
end;

Parent.MouseButton1Down:Connect(function() -- Line: 129
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), u7 (copy), Settings (copy)
    if LocalPlayer.PlayerGui:FindFirstChild("SettingsGUI") then
        return;
    end;

    local u14 = ReplicatedStorage["Client Assets"].Universal.SettingsGUI:Clone();
    local Assets = u14.Assets;
    local Page = u14.BGImage.Page;

    local function updateCanvasSize() -- Line: 135
        -- upvalues: Page (copy)
        Page.CanvasSize = UDim2.new(0, 0, 0, #Page:GetChildren() * 80 + 50);
    end;

    for i, v in pairs(u7) do
        local u15 = Assets.SettingSample:Clone();

        if Settings[i].Value then
            u15.SETTINGBG.BackgroundColor3 = Color3.fromRGB(120, 109, 255);
        else
            u15.SETTINGBG.BackgroundColor3 = Color3.fromRGB(249, 75, 69);
        end;

        u15.SETTINGBG.SETTING.Text = i;
        u15.Position = UDim2.new(0.5, 0, 0, #Page:GetChildren() * 80 + 50);
        u15.Visible = true;
        u15.Parent = Page;
        Page.CanvasSize = UDim2.new(0, 0, 0, #Page:GetChildren() * 80 + 50);
        u15.SETTINGBG.SETTING.MouseButton1Click:Connect(function() -- Line: 152
            -- upvalues: Settings (ref), i (copy), u15 (copy), Assets (copy), v (copy), u7 (ref)
            Settings[i].Value = not Settings[i].Value;

            if Settings[i].Value then
                u15.SETTINGBG.BackgroundColor3 = Color3.fromRGB(120, 109, 255);
            else
                u15.SETTINGBG.BackgroundColor3 = Color3.fromRGB(249, 75, 69);
            end;

            Assets.Click:Play();

            if v.Function then
                pcall(function() -- Line: 161
                    -- upvalues: v (ref), Settings (ref), i (ref)
                    v.Function(Settings[i].Value);
                end);
            end;

            if v.OneTime then
                u7[i] = nil;
            end;
        end);
    end;

    u14.Parent = LocalPlayer.PlayerGui;
    u14.BGImage.Close.MouseButton1Click:Connect(function() -- Line: 172
        -- upvalues: u14 (copy)
        u14:Destroy();
    end);
end);