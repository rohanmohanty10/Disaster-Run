  

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local u2 = nil;
local u3;

if game:GetService("RunService"):IsServer() then
    u3 = Instance.new("RemoteEvent");
    u3.Name = "PopupEvent";
    u3.Parent = ReplicatedStorage;
else
    u3 = ReplicatedStorage:WaitForChild("PopupEvent");
    u2 = require(ReplicatedStorage.Controllers.SpectatorController);
end;

function u1.Blackframe(p4) -- Line: 22
    -- upvalues: TweenService (copy), Debris (copy)
    local Frame = Instance.new("Frame");
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Parent = p4.PlayerGui.Pack;
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.Size = UDim2.new(2, 0, 1, 0);
    Frame.Position = UDim2.new(2, 0, 0.5, 0);
    Frame.ZIndex = 9;
    local v5 = TweenService:Create(Frame, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.new(-1, 0, 0.5, 0)
    });
    v5:Play();
    Debris:AddItem(v5, 2);
end;

local function uiPopup(p6, u7, p8) -- Line: 39
    -- upvalues: ReplicatedStorage (copy), TweenService (copy), Debris (copy), SoundManager (copy)
    local u9;

    if p8 then
        u9 = nil;
    else
        u9 = ReplicatedStorage.Assets.UI.Notification:Clone();
        u9.Parent = p6.PlayerGui.Misc;
        u9.Position = UDim2.new(-2, 0, 0.2, 0);
        local v10 = TweenService:Create(u9, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.2, 0)
        });
        v10:Play();
        Debris:AddItem(v10, 0.55);
    end;

    u7.Parent = p6.PlayerGui.Misc;
    u7.Position = UDim2.new(2, 0, 0.2, 0);
    local v11 = TweenService:Create(u7, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.2, 0)
    });
    v11:Play();
    Debris:AddItem(v11, 0.55);
    SoundManager.SpawnSound("Notification", 0.15, p6.PlayerGui, 1);
    task.delay(2, function() -- Line: 60
        -- upvalues: u9 (ref), TweenService (ref), Debris (ref), u7 (copy)
        if u9 then
            local v12 = TweenService:Create(u9, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                Position = UDim2.new(2, 0, 0.2, 0)
            });
            v12:Play();
            Debris:AddItem(v12, 0.8);
            Debris:AddItem(u9, 0.9);
        end;

        local v13 = TweenService:Create(u7, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            Position = UDim2.new(-2, 0, 0.2, 0)
        });
        v13:Play();
        Debris:AddItem(v13, 0.8);
        Debris:AddItem(u7, 0.9);
    end);
end;

function u1.Money(u14, u15) -- Line: 76
    -- upvalues: TweenService (copy), Debris (copy)
    task.spawn(function() -- Line: 77
        -- upvalues: u14 (copy), u15 (copy), TweenService (ref), Debris (ref)
        local u16 = u14.PlayerGui.MoneyPopups.Txt:Clone();
        u16.Parent = u14.PlayerGui.MoneyPopups;
        u16.Size = UDim2.new(0, 0, 0, 0);
        u16.Text = "+$" .. u15;
        u16.Visible = true;
        local v17 = TweenService:Create(u16, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.23, 0, 0.23, 0)
        });
        v17:Play();
        Debris:AddItem(v17, 0.5);
        local v18 = TweenService:Create(u16, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.92, 0, 0.2, 0)
        });
        v18:Play();
        Debris:AddItem(v18, 2);
        task.delay(1, function() -- Line: 92
            -- upvalues: TweenService (ref), u16 (copy), Debris (ref)
            local v19 = TweenService:Create(u16, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                TextTransparency = 1
            });
            v19:Play();
            Debris:AddItem(v19, 2);
        end);
    end);
end;

function u1.Strokes(u20) -- Line: 101
    -- upvalues: ReplicatedStorage (copy), Debris (copy), TweenService (copy)
    task.spawn(function() -- Line: 102
        -- upvalues: ReplicatedStorage (ref), Debris (ref), u20 (copy), TweenService (ref)
        local v21 = ReplicatedStorage.Assets.UI.StrokeM:Clone();
        local v22 = ReplicatedStorage.Assets.UI.StrokeL:Clone();
        local v23 = ReplicatedStorage.Assets.UI.StrokeR:Clone();
        Debris:AddItem(v21, 4);
        Debris:AddItem(v22, 4);
        Debris:AddItem(v23, 4);
        v21.Parent = u20.PlayerGui.Misc;
        v23.Parent = u20.PlayerGui.Misc;
        v22.Parent = u20.PlayerGui.Misc;
        v21.Position = UDim2.new(1.5, 0, -2.5, 0);
        v22.Position = UDim2.new(-1, 0, 2.5, 0);
        v23.Position = UDim2.new(0, 0, 2.5, 0);
        local v24 = TweenService:Create(v21, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.5, 0)
        });
        local v25 = TweenService:Create(v22, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 0, 0.5, 0)
        });
        local v26 = TweenService:Create(v23, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, 0, 0.5, 0)
        });
        Debris:AddItem(v24, 3);
        Debris:AddItem(v25, 3);
        Debris:AddItem(v26, 3);
        v25:Play();
        task.wait(0.12);
        v24:Play();
        task.wait(0.12);
        v26:Play();
        task.wait(0.7);
        local v27 = TweenService:Create(v21, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(-0.5, 0, 2.5, 0)
        });
        local v28 = TweenService:Create(v22, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, 0, -1.5, 0)
        });
        local v29 = TweenService:Create(v23, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(2, 0, -1.5, 0)
        });
        v28:Play();
        task.wait(0.12);
        v27:Play();
        task.wait(0.12);
        v29:Play();
        Debris:AddItem(v27, 3);
        Debris:AddItem(v28, 3);
        Debris:AddItem(v29, 3);
    end);
end;

function u1.SubtitleNoTeam(p30, p31, p32) -- Line: 163
    -- upvalues: u1 (copy)
    u1.Subtitle(p30, p31, p32, true);
end;

function u1.Subtitle(p33: any, p34: any, p35: any, p36: boolean) -- Line: 167
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if p36 or (p33.Team ~= game.Teams.Visitor or u2.IsSpectating) then
        local Children = p33.PlayerGui.Misc.Subtitles:GetChildren();

        for _, v in pairs(Children) do
            v:Destroy();
        end;

        table.clear(Children);
        local v37 = ReplicatedStorage.Assets.UI.Popup:Clone();
        v37.Parent = p33.PlayerGui.Misc.Subtitles;
        v37.Font = Enum.Font.ArialBold;
        v37.BackgroundTransparency = 1;
        v37.Size = UDim2.new(1, 0, 0.1, 0);
        v37.Text = p34;
        v37.Position = UDim2.new(0.5, 0, 0.8, 0);
        v37.ZIndex = 99;
        local v38 = script:FindFirstChild(p34);

        if v38 then
            v38:Clone().Parent = v37;
        end;

        if type(p35) == "number" then
            task.delay(p35, v37.Destroy, v37);
        else
            task.delay(3, v37.Destroy, v37);
        end;

        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = v37;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        local v39 = string.len(p34) / 50;
        local math_clamp_ret = math.clamp(v39, 0.35, 1);
        v37.Size = UDim2.new(math_clamp_ret, 0, 0.075, 0);
    end;
end;

function u1.Popup(p40, u41, u42) -- Line: 212
    -- upvalues: SoundManager (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy)
    local u43 = p40 or game.Players.LocalPlayer;

    if u41 then
        task.spawn(function() -- Line: 218
            -- upvalues: u41 (copy), SoundManager (ref), u43 (ref), ReplicatedStorage (ref), TweenService (ref), Debris (ref), u42 (copy)
            if u41:sub(1, 6) == "Set to" then
                local v44 = u41:sub(8, #u41 - 1);
                local u45 = SoundManager.SpawnSoundId(v44, 0.5);
                task.delay(4, function() -- Line: 222
                    -- upvalues: u45 (copy)
                    u45:Stop();
                end);
            else
                SoundManager.SpawnSound("Notification", 0.5, u43.PlayerGui, 1);
            end;

            local Misc = u43.PlayerGui:WaitForChild("Misc");
            local u46 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u46.Parent = Misc.Popups;
            u46.Size = UDim2.new(0, 0, 0, 0);
            u46.Text = u41;
            local v47 = string.len(u41) / 50;
            local v48 = math.clamp(v47, 0.35, 1) + 0.12;
            local v49 = TweenService:Create(u46, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = UDim2.new(v48, 0, 0.149, 0)
            });
            v49:Play();
            Debris:AddItem(v49, 0.25);
            task.delay(u42 or 1.5, function() -- Line: 245
                -- upvalues: TweenService (ref), u46 (copy), Debris (ref)
                local v50 = TweenService:Create(u46, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    TextTransparency = 1,
                    BackgroundTransparency = 1
                });
                v50:Play();
                Debris:AddItem(v50, 1.25);
                Debris:AddItem(u46, 1.25);
            end);
        end);

        return;
    end;

    warn("no text given for popup\n", debug.traceback());
end;

function u1.PopTxt(p51, p52) -- Line: 256
    -- upvalues: uiPopup (copy), ReplicatedStorage (copy)
    if string.match(string.lower(p52), "ankle") then
        uiPopup(p51, ReplicatedStorage.Assets.UI.AnkleBreaker:Clone());

        return;
    end;

    if string.match(string.lower(p52), "goal") then
        uiPopup(p51, ReplicatedStorage.Assets.UI.Goal:Clone());

        return;
    end;

    if string.match(string.lower(p52), "steal") then
        uiPopup(p51, ReplicatedStorage.Assets.UI.Steal:Clone(), true);

        return;
    end;

    if string.match(string.lower(p52), "save") then
        if ReplicatedStorage.GameValues.AwakeningCutscene.Value then
            return;
        end;

        uiPopup(p51, ReplicatedStorage.Assets.UI.Save:Clone(), true);
    end;
end;

require(script.Parent.SoundManager);

function u1.BlackoutLocal(u53, u54, u55, p56, u57) -- Line: 272
    -- upvalues: TweenService (copy), Debris (copy)
    if p56 then
        task.spawn(function() -- Line: 301
            -- upvalues: u53 (copy), u54 (copy), TweenService (ref), u57 (copy), u55 (copy)
            if u53.PlayerGui.Misc[u54] ~= nil then
                TweenService:Create(u53.PlayerGui.Misc[u54], TweenInfo.new(0.7 / (u57 or 1), Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.5, 0, 0, 0)
                }):Play();
                TweenService:Create(u53.PlayerGui.Misc[u55], TweenInfo.new(0.7 / (u57 or 1), Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.5, 0, 1, 0)
                }):Play();
                task.delay(1.5 / (u57 or 1), function() -- Line: 306
                    -- upvalues: TweenService (ref), u53 (ref), u54 (ref), u57 (ref), u55 (ref)
                    TweenService:Create(u53.PlayerGui.Misc[u54], TweenInfo.new(1 / (u57 or 1), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        Position = UDim2.new(0.5, 0, -2, 0)
                    }):Play();
                    TweenService:Create(u53.PlayerGui.Misc[u55], TweenInfo.new(1 / (u57 or 1), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        Position = UDim2.new(0.5, 0, 3, 0)
                    }):Play();
                    task.delay(0.9 / (u57 or 1), function() -- Line: 309
                        -- upvalues: u53 (ref), u54 (ref), u55 (ref)
                        u53.PlayerGui.Misc[u54]:Destroy();
                        u53.PlayerGui.Misc[u55]:Destroy();
                    end);
                end);
            end;
        end);

        return;
    end;

    task.spawn(function() -- Line: 274
        -- upvalues: u54 (copy), u53 (copy), TweenService (ref), u57 (copy), Debris (ref), u55 (copy)
        local Frame = Instance.new("Frame");
        Frame.Name = u54;
        Frame.Parent = u53.PlayerGui.Misc;
        Frame.BorderSizePixel = 0;
        Frame.BackgroundColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588);
        Frame.Size = UDim2.new(2, 0, 1, 0);
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Position = UDim2.new(0.5, 0, -1, 0);
        local v58 = TweenService:Create(Frame, TweenInfo.new(0.35 / (u57 or 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, -0.368, 0)
        });
        v58:Play();
        Debris:AddItem(v58, 0.35 / (u57 or 1));
        local Frame2 = Instance.new("Frame");
        Frame2.Name = u55;
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588);
        Frame2.Parent = u53.PlayerGui.Misc;
        Frame2.Size = UDim2.new(2, 0, 1, 0);
        Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame2.Position = UDim2.new(0.5, 0, 2, 0);
        local v59 = TweenService:Create(Frame2, TweenInfo.new(0.35 / (u57 or 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 1.368, 0)
        });
        v59:Play();
        Debris:AddItem(v59, 0.35 / (u57 or 1));
    end);
end;

function u1.BlackoutLocalSemi(u60, u61, u62, p63) -- Line: 319
    -- upvalues: TweenService (copy), Debris (copy)
    if p63 then
        task.spawn(function() -- Line: 348
            -- upvalues: u60 (copy), u61 (copy), TweenService (ref), u62 (copy)
            if u60.PlayerGui.Misc[u61] ~= nil then
                local u64 = TweenService:Create(u60.PlayerGui.Misc[u61], TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.5, 0, -2, 0)
                });
                local u65 = TweenService:Create(u60.PlayerGui.Misc[u62], TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.5, 0, 3, 0)
                });
                u64:Play();
                u65:Play();
                task.delay(0.9, function() -- Line: 356
                    -- upvalues: u64 (copy), u65 (copy), u60 (ref), u61 (ref), u62 (ref)
                    u64:Destroy();
                    u65:Destroy();
                    u60.PlayerGui.Misc[u61]:Destroy();
                    u60.PlayerGui.Misc[u62]:Destroy();
                end);
            end;
        end);

        return;
    end;

    task.spawn(function() -- Line: 321
        -- upvalues: u61 (copy), u60 (copy), TweenService (ref), Debris (ref), u62 (copy)
        local Frame = Instance.new("Frame");
        Frame.Name = u61;
        Frame.Parent = u60.PlayerGui.Misc;
        Frame.BorderSizePixel = 0;
        Frame.BackgroundColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588);
        Frame.Size = UDim2.new(2, 0, 1, 0);
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Position = UDim2.new(0.5, 0, -1, 0);
        local v66 = TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, -0.368, 0)
        });
        v66:Play();
        Debris:AddItem(v66, 0.35);
        local Frame2 = Instance.new("Frame");
        Frame2.Name = u62;
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588);
        Frame2.Parent = u60.PlayerGui.Misc;
        Frame2.Size = UDim2.new(2, 0, 1, 0);
        Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame2.Position = UDim2.new(0.5, 0, 2, 0);
        local v67 = TweenService:Create(Frame2, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 1.368, 0)
        });
        v67:Play();
        Debris:AddItem(v67, 0.35);
    end);
end;

if game:GetService("RunService"):IsServer() then
    for i, _ in u1 do
        u1[i] = function(p68, ...) -- Line: 370
            -- upvalues: u3 (ref), i (copy)
            u3:FireClient(p68, i, ...);
        end;
    end;
else
    u3.OnClientEvent:Connect(function(p69, ...) -- Line: 375
        -- upvalues: u1 (copy)
        u1[p69](game.Players.LocalPlayer, ...);
    end);
end;

return u1;