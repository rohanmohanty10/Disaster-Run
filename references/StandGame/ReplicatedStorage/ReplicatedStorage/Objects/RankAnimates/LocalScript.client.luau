 

 

local l__TweenService__1 = game.TweenService;
local u1 = game["Run Service"];
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__FunctionLibrary__3 = require(l__ReplicatedStorage__2.Modules.FunctionLibrary);
local l__wait__4 = task.wait;
local l__LocalPlayer__5 = game.Players.LocalPlayer;
local l__HUD__6 = l__LocalPlayer__5.PlayerGui.HUD;
local l__Parent__7 = script.Parent;
local l__Part_1__8 = l__Parent__7.Part_1;
local l__Part_2__9 = l__Parent__7.Part_2;
local l__Frame__10 = l__Parent__7.Frame;
local l__Background__11 = l__Parent__7.Background;
local l__TextLabel__12 = l__Parent__7.TextLabel;
local u2 = {
    Bronze = {
        Time_Stamp = 0,
        End = 5,
        Player_Text_Stamp = 3,
        Part = l__Part_1__8
    },
    Silver = {
        Time_Stamp = 5,
        End = 9,
        Player_Text_Stamp = 7,
        Part = l__Part_1__8
    },
    Gold = {
        Time_Stamp = 9,
        End = 13,
        Player_Text_Stamp = 11,
        Part = l__Part_1__8
    },
    Platinum = {
        Time_Stamp = 13,
        End = 18.5,
        Player_Text_Stamp = 16,
        Part = l__Part_1__8
    },
    Diamond = {
        Time_Stamp = 18,
        End = 23,
        Player_Text_Stamp = 22,
        Part = l__Part_1__8
    },
    Crusader = {
        Time_Stamp = 0,
        End = 6.5,
        Player_Text_Stamp = 5,
        Part = l__Part_2__9
    },
    Requiem = {
        Time_Stamp = 5,
        End = 16.5,
        Player_Text_Stamp = 10,
        Part = l__Part_2__9
    },
    Ascended = {
        Time_Stamp = 16,
        End = 28,
        Player_Text_Stamp = 20,
        Part = l__Part_2__9
    }
};
(function(p3) --[[ Name: Animate, Line 75 ]]
    -- upvalues: u2 (copy), l__LocalPlayer__5 (copy), l__Parent__7 (copy), l__HUD__6 (copy), l__FunctionLibrary__3 (copy), l__ReplicatedStorage__2 (copy), l__TweenService__1 (copy), l__wait__4 (copy), l__Frame__10 (copy), l__Background__11 (copy), l__TextLabel__12 (copy), u1 (copy)
    local v4 = u2[p3];
    local l__Time_Stamp__13 = v4.Time_Stamp;
    local l__End__14 = v4.End;
    local l__Part__15 = v4.Part;
    local l__Player_Text_Stamp__16 = v4.Player_Text_Stamp;
    local v5, _ = game.Players:GetUserThumbnailAsync(l__LocalPlayer__5.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
    l__Parent__7.ImageLabel.Image = v5;
    l__Parent__7.TextLabel2.Text = l__LocalPlayer__5.Name;
    _G.CinematicMode(true);
    l__HUD__6.Enabled = false;
    l__FunctionLibrary__3.PlaySound({
        ClientOnly = true,
        Sound = l__ReplicatedStorage__2.Sounds.RankAnimates.Transition.Full
    });
    for v6 = 1, 2 do
        local v7 = v6 == 1 and l__Parent__7.Frame_1 or l__Parent__7.Frame_2;
        local l__Position__17 = v7.Position;
        v7.BackgroundTransparency = 0;
        v7.Position = UDim2.new(l__Position__17.X.Scale, l__Position__17.X.Offset, l__Position__17.Y.Scale + (v6 == 1 and -0.4 or 0.4), l__Position__17.X.Offset);
        v7.Visible = true;
        l__TweenService__1:Create(v7, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = l__Position__17
        }):Play();
    end;
    l__wait__4(1);
    l__Frame__10.Visible = true;
    l__Frame__10.BackgroundTransparency = 0;
    l__Background__11.Visible = true;
    l__Part__15.TimePosition = l__Time_Stamp__13;
    l__Part__15.Playing = true;
    l__Part__15.Visible = true;
    l__wait__4(0.5);
    repeat
        l__wait__4();
    until l__Part__15.IsLoaded and l__Time_Stamp__13 <= l__Part__15.TimePosition;
    l__Part__15.TimePosition = l__Time_Stamp__13;
    l__Part__15.Playing = false;
    for v8 = 1, 2 do
        local v9 = v8 == 1 and l__Parent__7.Frame_1 or l__Parent__7.Frame_2;
        v9.Visible = true;
        l__TweenService__1:Create(v9, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.new(v9.Position.X.Scale, v9.Position.X.Offset, v9.Position.Y.Scale + (v8 == 1 and -0.4 or 0.4), v9.Position.X.Offset),
            BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        }):Play();
    end;
    l__wait__4(0.7);
    l__TextLabel__12.Text = "PROMOTED TO " .. string.upper(p3);
    l__TextLabel__12.TextTransparency = 1;
    l__TextLabel__12.UIStroke.Transparency = 1;
    l__TextLabel__12.Visible = true;
    for v10 = 1, 2 do
        local v11 = v10 == 1 and ({
            TextTransparency = 0
        } or {
            Transparency = 0
        }) or {
            Transparency = 0
        };
        l__TweenService__1:Create(v10 == 1 and l__TextLabel__12 or l__TextLabel__12.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v11):Play();
    end;
    l__wait__4(0.3);
    l__TweenService__1:Create(l__Frame__10, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    l__wait__4(1.5);
    l__Part__15.Playing = true;
    repeat
        l__wait__4();
    until l__Part__15.Playing and l__Time_Stamp__13 < l__Part__15.TimePosition;
    l__FunctionLibrary__3.PlaySound({
        ClientOnly = true,
        Sound = l__ReplicatedStorage__2.Sounds.RankAnimates[p3 .. "Rank"]
    });
    local u12 = nil;
    local u13 = nil;
    u12 = u1.Heartbeat:connect(function(_) --[[ Line: 233 ]]
        -- upvalues: l__Part__15 (copy), l__Player_Text_Stamp__16 (copy), u13 (ref), l__Parent__7 (ref), l__TweenService__1 (ref), l__HUD__6 (ref), l__End__14 (copy), u12 (ref)
        if l__Player_Text_Stamp__16 <= l__Part__15.TimePosition and not u13 then
            u13 = true;
            for v14 = 1, 2 do
                local v15 = v14 == 1 and l__Parent__7.TextLabel2 or l__Parent__7.ImageLabel;
                local v16 = v14 == 1 and ({
                    TextTransparency = 0
                } or {
                    ImageTransparency = 0
                }) or {
                    ImageTransparency = 0
                };
                local v17 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                if v14 == 1 then
                    v15.TextTransparency = 1;
                    v15.UIStroke.Transparency = 1;
                    l__TweenService__1:Create(v15.UIStroke, v17, {
                        Transparency = 0
                    }):Play();
                else
                    v15.ImageTransparency = 1;
                end;
                v15.Visible = true;
                l__TweenService__1:Create(v15, v17, v16):Play();
            end;
            delay(3, function() --[[ Line: 272 ]]
                -- upvalues: l__Parent__7 (ref), l__HUD__6 (ref)
                l__Parent__7.TextButton.MouseButton1Click:Connect(function() --[[ Line: 273 ]]
                    -- upvalues: l__HUD__6 (ref), l__Parent__7 (ref)
                    l__HUD__6.Enabled = true;
                    l__Parent__7:Destroy();
                    _G.CinematicMode(false);
                end);
                l__Parent__7.TextButton.Visible = true;
            end);
        end;
        if l__End__14 <= l__Part__15.TimePosition then
            l__Part__15.Playing = false;
            u12:Disconnect();
            l__Parent__7:SetAttribute("Finished", true);
        end;
    end);
end)(l__Parent__7:GetAttribute("Rank") or "Bronze");