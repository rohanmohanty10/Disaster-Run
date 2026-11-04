 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local LocalPlayer = Players.LocalPlayer;
local script_Parent = script.Parent;
local Frame = script_Parent.Frame;
local script_Commands = require(script.Commands);
local script_Arguments = script.Arguments;
local CmdrClient = ReplicatedStorage:WaitForChild("CmdrClient");
local u1 = require(CmdrClient);
local wiki = require(ReplicatedStorage.wiki);
local u2 = {};
local u3 = {};

for i, v in pairs(wiki.styles) do
    if not v.spec then
        u2[#u2 + 1] = { i, v };
    end;
end;

local u4 = {};

for i, v in pairs(wiki.styles) do
    if v.tempable then
        u4[#u4 + 1] = { i, v };
    end;
end;

function u3.MANAGE(u5) -- Line: 33
    -- upvalues: u1 (copy), StarterGui (copy), script_Arguments (copy), Frame (copy), LocalPlayer (copy), Players (copy), u4 (copy), u2 (copy), script_Parent (copy)
    if not u5.arguments then
        u1.Dispatcher:Send(u5.datatitle);
        StarterGui:SetCore("SendNotification", {
            Text = "No arguments, ran immediately",
            Duration = 3,
            Title = "Command " .. u5.datatitle .. " ran"
        });

        return;
    end;

    local u6 = {};
    local u7 = {};

    for i, v in u5.arguments do
        u6[i] = nil;
        local v8, u9;

        if typeof(v) == "table" and script_Arguments:FindFirstChild(v.Type) then
            local u10 = script_Arguments:FindFirstChild(v.Type):Clone();

            if v.Description and u10:FindFirstChild("desc") then
                u10.desc.Text = v.Description;
                u10.desc.Visible = true;
            end;

            if v.Name and u10:FindFirstChild("title") then
                u10.title.Text = v.Name;
                u10.title.Visible = true;
            end;

            u10.LayoutOrder = i;
            u10.Parent = Frame.Frame.options;
            table.insert(u7, u10);

            if v.Type == "player" then
                u6[i] = LocalPlayer.Name;
                local _ = script.Player;
                v8 = v;
                u9 = i;

                for i2 = 1, 2 do
                    local u11 = script.Player:Clone();
                    u11.LayoutOrder = 0;
                    u11.desc.Text = i2 == 1 and "All" or (i2 == 2 and "Others" or false);
                    u11.Parent = u10.list.Button;
                    u11.MouseButton1Click:Connect(function() -- Line: 75
                        -- upvalues: u10 (copy), u6 (copy), u9 (copy), u11 (copy)
                        for _, child in u10.list.Button:GetChildren() do
                            if child:IsA("TextButton") then
                                child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            end;
                        end;

                        u6[u9] = string.lower(u11.desc.Text);
                        u11.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end);
                    local _ = i2;
                end;

                for _, v2 in Players:GetPlayers() do
                    local u12 = script.Player:Clone();
                    u12.LayoutOrder = 0;
                    u12.desc.Text = string.format("%s (@%s)", v2.DisplayName, v2.Name);
                    u12.Parent = u10.list.Button;

                    if u6[u9] == u12.Name then
                        u12.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end;

                    coroutine.wrap(function() -- Line: 95
                        -- upvalues: Players (ref), v2 (copy), u12 (copy)
                        local success, result = pcall(function() -- Line: 96
                            -- upvalues: Players (ref), v2 (ref)
                            return Players:GetUserThumbnailAsync(v2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60);
                        end);

                        if success then
                            u12.icon.Image = result;
                        end;
                    end)();
                    u12.MouseButton1Click:Connect(function() -- Line: 104
                        -- upvalues: u10 (copy), u6 (copy), u9 (copy), v2 (copy), u12 (copy)
                        for _, child in u10.list.Button:GetChildren() do
                            if child:IsA("TextButton") then
                                child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            end;
                        end;

                        u6[u9] = v2.Name;
                        u12.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end);
                end;
            else
                u9 = i;
                v8 = v;
            end;

            if v8.Type == "number" then
                u6[u9] = v8.Autofill or 0;
                u10.Frame.Button.Text = v8.Autofill or u10.Frame.Button.Text;
                u10.Frame.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 121
                    -- upvalues: u10 (copy), u6 (copy), u9 (copy)
                    if tonumber(u10.Frame.Button.Text) then
                        u6[u9] = tonumber(u10.Frame.Button.Text);
                    end;
                end);
            end;

            if v8.Type == "boolean" then
                local v13;

                if v8.Autofill == nil then
                    v13 = false;
                else
                    v13 = v8.Autofill or false;
                end;

                u6[u9] = v13;
                u10.Frame.Button.Text = u6[u9] and "Yes" or "No";
                u10.Frame.Button.MouseButton1Down:Connect(function() -- Line: 133
                    -- upvalues: u6 (copy), u9 (copy), u10 (copy)
                    u6[u9] = not u6[u9];
                    u10.Frame.Button.Text = u6[u9] and "Yes" or "No";
                end);
            end;

            if v8.Type == "string" then
                u6[u9] = v8.Autofill or "";
                u10.Frame.Button.Text = v8.Autofill or u10.Frame.Button.Text;
                u10.Frame.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 144
                    -- upvalues: u10 (copy), u6 (copy), u9 (copy)
                    if tostring(u10.Frame.Button.Text) then
                        u6[u9] = tostring(u10.Frame.Button.Text);
                    end;
                end);
            end;

            if v8.Type == "color3" then
                local u14 = 255;
                local u15 = 255;
                local u16 = 255;

                local function update_colors() -- Line: 157
                    -- upvalues: u10 (copy), u14 (ref), u15 (ref), u16 (ref)
                    u10.Color.BackgroundColor3 = Color3.fromRGB(u14, u15, u16);
                end;

                u6[u9] = { u14, u15, u16 };
                u10.Red.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 163
                    -- upvalues: u10 (copy), u14 (ref), u6 (copy), u9 (copy), u15 (ref), u16 (ref)
                    if tonumber(u10.Red.Button.Text) then
                        u14 = tonumber(u10.Red.Button.Text);
                    end;

                    u6[u9] = { u14, u15, u16 };
                    u10.Color.BackgroundColor3 = Color3.fromRGB(u14, u15, u16);
                end);
                u10.Green.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 170
                    -- upvalues: u10 (copy), u15 (ref), u6 (copy), u9 (copy), u14 (ref), u16 (ref)
                    if tonumber(u10.Green.Button.Text) then
                        u15 = tonumber(u10.Green.Button.Text);
                    end;

                    u6[u9] = { u14, u15, u16 };
                    u10.Color.BackgroundColor3 = Color3.fromRGB(u14, u15, u16);
                end);
                u10.Blue.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 177
                    -- upvalues: u10 (copy), u16 (ref), u6 (copy), u9 (copy), u14 (ref), u15 (ref)
                    if tonumber(u10.Blue.Button.Text) then
                        u16 = tonumber(u10.Blue.Button.Text);
                    end;

                    u6[u9] = { u14, u15, u16 };
                    u10.Color.BackgroundColor3 = Color3.fromRGB(u14, u15, u16);
                end);
                u10.Color.BackgroundColor3 = Color3.fromRGB(u14, u15, u16);
            end;

            if v8.Type == "psstyles" then
                u6[u9] = u4[#u4][1];

                for i2, v2 in u4 do
                    local u17 = v2[1];
                    local u18 = v2[2];
                    local u19 = script.Player:Clone();
                    u19.LayoutOrder = i2;
                    u19.desc.Text = u17;
                    u19.Parent = u10.list.Button;

                    if u6[u9] == u17 then
                        u19.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end;

                    print(u17, u18);
                    coroutine.wrap(function() -- Line: 206
                        -- upvalues: u18 (copy), u19 (copy)
                        if u18.icon then
                            u19.icon.Image = u18.icon;
                        end;
                    end)();
                    u19.MouseButton1Click:Connect(function() -- Line: 212
                        -- upvalues: u10 (copy), u6 (copy), u9 (copy), u17 (copy), u19 (copy)
                        for _, child in u10.list.Button:GetChildren() do
                            if child:IsA("TextButton") then
                                child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            end;
                        end;

                        u6[u9] = u17;
                        u19.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end);
                end;
            end;

            if v8.Type == "stylepublic" then
                u6[u9] = "isagi";

                for i2, v2 in u2 do
                    local u20 = v2[1];
                    local u21 = v2[2];
                    local u22 = script.Player:Clone();
                    u22.LayoutOrder = i2;
                    u22.desc.Text = u20;
                    u22.Parent = u10.list.Button;

                    if u6[u9] == u20 then
                        u22.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end;

                    print(u20, u21);
                    coroutine.wrap(function() -- Line: 243
                        -- upvalues: u21 (copy), u22 (copy)
                        if u21.icon then
                            u22.icon.Image = u21.icon;
                        end;
                    end)();
                    u22.MouseButton1Click:Connect(function() -- Line: 249
                        -- upvalues: u10 (copy), u6 (copy), u9 (copy), u20 (copy), u22 (copy)
                        for _, child in u10.list.Button:GetChildren() do
                            if child:IsA("TextButton") then
                                child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            end;
                        end;

                        u6[u9] = u20;
                        u22.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end);
                end;
            end;
        else
            u9 = i;
            v8 = v;
        end;

        if typeof(v8) == "string" and script_Arguments:FindFirstChild(v8) then
            local u23 = script_Arguments:FindFirstChild(v8):Clone();
            print(u9);
            u23.LayoutOrder = u9;
            u23.Parent = Frame.Frame.options;
            table.insert(u7, u23);

            if v8 == "player" then
                u6[u9] = LocalPlayer.Name;
                local _ = script.Player;

                for i2 = 1, 2 do
                    local u24 = script.Player:Clone();
                    u24.LayoutOrder = 0;
                    u24.desc.Text = i2 == 1 and "All" or (i2 == 2 and "Others" or false);
                    u24.Parent = u23.list.Button;
                    u24.MouseButton1Click:Connect(function() -- Line: 280
                        -- upvalues: u23 (copy), u6 (copy), u9 (copy), u24 (copy)
                        for _, child in u23.list.Button:GetChildren() do
                            if child:IsA("TextButton") then
                                child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            end;
                        end;

                        u6[u9] = string.lower(u24.desc.Text);
                        u24.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end);
                    local _ = i2;
                end;

                for _, v2 in Players:GetPlayers() do
                    local u25 = script.Player:Clone();
                    u25.LayoutOrder = 0;
                    u25.desc.Text = string.format("%s (@%s)", v2.DisplayName, v2.Name);
                    u25.Parent = u23.list.Button;

                    if u6[u9] == u25.Name then
                        u25.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end;

                    coroutine.wrap(function() -- Line: 300
                        -- upvalues: Players (ref), v2 (copy), u25 (copy)
                        local success, result = pcall(function() -- Line: 301
                            -- upvalues: Players (ref), v2 (ref)
                            return Players:GetUserThumbnailAsync(v2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60);
                        end);

                        if success then
                            u25.icon.Image = result;
                        end;
                    end)();
                    u25.MouseButton1Click:Connect(function() -- Line: 309
                        -- upvalues: u23 (copy), u6 (copy), u9 (copy), v2 (copy), u25 (copy)
                        for _, child in u23.list.Button:GetChildren() do
                            if child:IsA("TextButton") then
                                child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            end;
                        end;

                        u6[u9] = v2.Name;
                        u25.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end);
                end;
            end;

            if v8 == "number" then
                u6[u9] = 0;
                u23.Frame.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 324
                    -- upvalues: u23 (copy), u6 (copy), u9 (copy)
                    if tonumber(u23.Frame.Button.Text) then
                        u6[u9] = tonumber(u23.Frame.Button.Text);
                    end;
                end);
            end;

            if v8 == "boolean" then
                u6[u9] = false;
                u23.Frame.Button.MouseButton1Down:Connect(function() -- Line: 334
                    -- upvalues: u6 (copy), u9 (copy), u23 (copy)
                    u6[u9] = not u6[u9];
                    u23.Frame.Button.Text = u6[u9] and "Yes" or "No";
                end);
            end;

            if v8 == "string" then
                u6[u9] = "";
                u23.Frame.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 343
                    -- upvalues: u23 (copy), u6 (copy), u9 (copy)
                    if tostring(u23.Frame.Button.Text) then
                        u6[u9] = tostring(u23.Frame.Button.Text);
                    end;
                end);
            end;

            if v8 == "color3" then
                local u26 = 255;
                local u27 = 255;
                local u28 = 255;

                local function _() -- Line: 356
                    -- upvalues: u23 (copy), u26 (ref), u27 (ref), u28 (ref)
                    u23.Color.BackgroundColor3 = Color3.fromRGB(u26, u27, u28);
                end;

                u6[u9] = { u26, u27, u28 };
                u23.Red.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 362
                    -- upvalues: u23 (copy), u26 (ref), u6 (copy), u9 (copy), u27 (ref), u28 (ref)
                    if tonumber(u23.Red.Button.Text) then
                        u26 = tonumber(u23.Red.Button.Text);
                    end;

                    u6[u9] = { u26, u27, u28 };
                    u23.Color.BackgroundColor3 = Color3.fromRGB(u26, u27, u28);
                end);
                u23.Green.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 369
                    -- upvalues: u23 (copy), u27 (ref), u6 (copy), u9 (copy), u26 (ref), u28 (ref)
                    if tonumber(u23.Green.Button.Text) then
                        u27 = tonumber(u23.Green.Button.Text);
                    end;

                    u6[u9] = { u26, u27, u28 };
                    u23.Color.BackgroundColor3 = Color3.fromRGB(u26, u27, u28);
                end);
                u23.Blue.Button:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 376
                    -- upvalues: u23 (copy), u28 (ref), u6 (copy), u9 (copy), u26 (ref), u27 (ref)
                    if tonumber(u23.Blue.Button.Text) then
                        u28 = tonumber(u23.Blue.Button.Text);
                    end;

                    u6[u9] = { u26, u27, u28 };
                    u23.Color.BackgroundColor3 = Color3.fromRGB(u26, u27, u28);
                end);
                u23.Color.BackgroundColor3 = Color3.fromRGB(u26, u27, u28);
            end;

            if v8 == "stylepublic" then
                u6[u9] = "isagi";

                for i2, v2 in u2 do
                    local u29 = v2[1];
                    local u30 = v2[2];
                    local u31 = script.Player:Clone();
                    u31.LayoutOrder = i2;
                    u31.desc.Text = u29;
                    u31.Parent = u23.list.Button;

                    if u6[u9] == u29 then
                        u31.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end;

                    coroutine.wrap(function() -- Line: 404
                        -- upvalues: u30 (copy), u31 (copy)
                        if u30.icon then
                            u31.icon.Image = u30.icon;
                        end;
                    end)();
                    u31.MouseButton1Click:Connect(function() -- Line: 410
                        -- upvalues: u23 (copy), u6 (copy), u9 (copy), u29 (copy), u31 (copy)
                        for _, child in u23.list.Button:GetChildren() do
                            if child:IsA("TextButton") then
                                child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            end;
                        end;

                        u6[u9] = u29;
                        u31.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end);
                end;
            end;

            if v8 == "psstyles" then
                u6[u9] = u4[#u4][1];

                for i2, v2 in u4 do
                    local u32 = v2[1];
                    local u33 = v2[2];
                    local u34 = script.Player:Clone();
                    u34.LayoutOrder = i2;
                    u34.desc.Text = u32;
                    u34.Parent = u23.list.Button;

                    if u6[u9] == u32 then
                        u34.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end;

                    coroutine.wrap(function() -- Line: 440
                        -- upvalues: u33 (copy), u34 (copy)
                        if u33.icon then
                            u34.icon.Image = u33.icon;
                        end;
                    end)();
                    u34.MouseButton1Click:Connect(function() -- Line: 446
                        -- upvalues: u23 (copy), u6 (copy), u9 (copy), u32 (copy), u34 (copy)
                        for _, child in u23.list.Button:GetChildren() do
                            if child:IsA("TextButton") then
                                child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            end;
                        end;

                        u6[u9] = u32;
                        u34.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
                    end);
                end;
            end;
        end;
    end;

    script_Parent.Frame.choice.Visible = false;
    script_Parent.Frame.Frame.Visible = true;
    script_Parent.Frame.commands.Visible = false;
    local u35 = {};
    table.insert(u35, script_Parent.Frame.Frame.UseButton.MouseButton1Click:Once(function() -- Line: 467
        -- upvalues: script_Parent (ref), u35 (copy), u7 (copy), u5 (copy), u6 (copy), StarterGui (ref), u1 (ref)
        script_Parent.Frame.choice.Visible = true;
        script_Parent.Frame.Frame.Visible = false;
        script_Parent.Frame.commands.Visible = true;

        for _, v in u35 do
            v:Disconnect();
        end;

        for _, v in u7 do
            pcall(game.Destroy, v);
        end;

        local datatitle = u5.datatitle;

        for _, v in u6 do
            if typeof(v) == "table" then
                local v36 = v;
                local v37 = nil;

                for i, v2 in v do
                    if v37 == nil then
                        v37 = v2 .. ",";
                    elseif i == #v36 then
                        v37 = v37 .. v2;
                    else
                        v37 = v37 .. tostring(v2) .. ",";
                    end;
                end;

                datatitle = datatitle .. " " .. tostring(v37);
            else
                datatitle = datatitle .. " " .. tostring(v);
            end;
        end;

        StarterGui:SetCore("SendNotification", {
            Duration = 5,
            Title = "Command " .. u5.datatitle .. " ran",
            Text = datatitle
        });
        u1.Dispatcher:Send(datatitle);
    end));
    table.insert(u35, script_Parent.Frame.Frame.CancelButton.MouseButton1Click:Once(function() -- Line: 512
        -- upvalues: script_Parent (ref), u35 (copy), u7 (copy), StarterGui (ref)
        script_Parent.Frame.choice.Visible = true;
        script_Parent.Frame.Frame.Visible = false;
        script_Parent.Frame.commands.Visible = true;

        for _, v in u35 do
            v:Disconnect();
        end;

        for _, v in u7 do
            pcall(game.Destroy, v);
        end;

        StarterGui:SetCore("SendNotification", {
            Title = "Command cancelled",
            Text = "bottom text",
            Duration = 2
        });
    end));
end;

function u3.new() -- Line: 535
    -- upvalues: script_Commands (copy), Frame (copy), u3 (copy)
    for _, v in script_Commands do
        local v38 = script.AdvancedSettingToggle:Clone();
        v38.desc.Text = v.description;
        v38.title.Text = v.name;
        v38.Parent = Frame.commands;
        v38.Frame.Button.MouseButton1Click:Connect(function() -- Line: 541
            -- upvalues: u3 (ref), v (copy)
            u3.MANAGE(v);
        end);
    end;
end;

return u3;