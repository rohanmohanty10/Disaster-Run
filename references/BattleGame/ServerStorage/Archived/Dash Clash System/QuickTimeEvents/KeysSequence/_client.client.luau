 

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__Debris__5 = game:GetService("Debris");
local _ = l__ReplicatedStorage__1.Packages.Modules;
local l__Services__6 = require(l__ReplicatedStorage__1.Services);
l__Services__6:GetService("Keybinds");
local l__CAS__7 = l__Services__6:GetService("CAS");
local l__Keybinds__8 = l__Services__6:GetService("Keybinds");
l__Services__6:GetService("AnimationService");
l__Services__6:GetService("Hitbox");
l__Services__6:GetService("StunService");
local l__Sound__9 = l__Services__6:GetService("Sound");
l__Services__6:GetService("Clock");
l__Services__6:GetService("RocksService");
local l__VFX_Utility__10 = l__Services__6:GetService("VFX_Utility");
local l__CameraShaker__11 = l__Services__6:GetService("CameraShaker");
local u1 = { l__Keybinds__8.GetAllDeviceTypes() };
local u2 = {
    Console = {
        Enum.KeyCode.ButtonX,
        Enum.KeyCode.ButtonY,
        Enum.KeyCode.ButtonA,
        Enum.KeyCode.ButtonB,
        Enum.KeyCode.ButtonR1,
        Enum.KeyCode.ButtonR1,
        Enum.KeyCode.ButtonL1,
        Enum.KeyCode.ButtonL2,
        Enum.KeyCode.DPadUp,
        Enum.KeyCode.DPadLeft,
        Enum.KeyCode.DPadRight,
        Enum.KeyCode.DPadDown
    },
    PC = {
        Enum.KeyCode.A,
        Enum.KeyCode.Q,
        Enum.KeyCode.W,
        Enum.KeyCode.E,
        Enum.KeyCode.S,
        Enum.KeyCode.E,
        Enum.KeyCode.D,
        Enum.KeyCode.Z,
        Enum.KeyCode.X,
        Enum.KeyCode.Space
    },
    Mobile = {
        "M1",
        "Block",
        "Dash",
        "Jump"
    }
};
local u3 = {};
local l__LocalPlayer__12 = l__Players__2.LocalPlayer;
local l__PlayerGui__13 = l__LocalPlayer__12.PlayerGui;
local l__QuickTimeEvents__14 = l__PlayerGui__13.QuickTimeEvents;
local l__Backpack__15 = l__PlayerGui__13.GameUI.Backpack;
local l__UI__16 = script.UI;
local l__BlueLabel__17 = l__UI__16.BlueLabel;
local l__RedLabel__18 = l__UI__16.RedLabel;
local l__remote__19 = script.remote;
l__UI__16.BlackLabel.Size = UDim2.fromScale(0, 0.491);
l__UI__16.Parent = l__QuickTimeEvents__14;
l__Backpack__15.Visible = false;
script.Destroying:Connect(function() --[[ Line: 76 ]]
    -- upvalues: l__Backpack__15 (copy), l__UI__16 (copy)
    l__Backpack__15.Visible = true;
    l__UI__16:Destroy();
end);
local u4 = false;
function newSequence()
    -- upvalues: u1 (copy), l__Keybinds__8 (copy), l__UI__16 (copy), u2 (copy), l__TweenService__3 (copy)
    local v5 = {};
    local v6 = u1[1] and "Console" or (u1[2] and not u1[3] and "Mobile" or "PC");
    local v7;
    if v6 == "Console" then
        v7 = l__Keybinds__8.GetGamepadType();
    else
        v7 = nil;
    end;
    for _, v8 in l__UI__16.Inputs:GetChildren() do
        if v8:IsA("Frame") then
            v8:Destroy();
        end;
    end;
    for v9 = 1, 5 do
        local v10 = u2[v6][math.random(1, #u2[v6])];
        local v11 = script.InputTemplate:Clone();
        local v12;
        if typeof(v10) == "string" then
            v12 = v10;
        else
            v12 = v10.Name;
        end;
        v11.Name = v12;
        v11.UIScale.Scale = 0.01;
        v11.Parent = l__UI__16.Inputs;
        local v13 = l__Keybinds__8.getIconForKeybind(v6, v7, v10);
        if string.find(v13, "rbxasset") then
            v11.InputIcon.Image = v13;
            if v6 == "Mobile" then
                v11.InputIcon.ImageRectOffset = Vector2.new(1, 146);
                v11.InputIcon.ImageRectSize = Vector2.new(144, 144);
            end;
        else
            v11.InputKey.Text = v13;
        end;
        l__TweenService__3:Create(v11.UIScale, TweenInfo.new(0.15), {
            Scale = v9 == 1 and 1.2 or 1
        }):Play();
        if v9 > 1 then
            v11.InputIcon.HideFrame.Visible = true;
        end;
        v5[v9] = {
            completed = false,
            completeState = "",
            key = v10,
            frame = v11
        };
    end;
    return v5;
end;
function updateProgressBar()
    -- upvalues: u4 (ref), l__UI__16 (copy), l__PlayerGui__13 (copy), l__BlueLabel__17 (copy), l__RedLabel__18 (copy)
    if u4 or not l__UI__16:IsDescendantOf(l__PlayerGui__13) then
    else
        local v14 = script:GetAttribute("goalPoints");
        local v15 = script:GetAttribute("leaderGoalPoints");
        if v14 or v15 then
            local v16 = script:GetAttribute("myId");
            if v16 then
                local v17, v18;
                if v16 == 1 then
                    v17 = script:GetAttribute("plr_1_points");
                    v18 = script:GetAttribute("plr_2_points");
                else
                    v17 = script:GetAttribute("plr_2_points");
                    v18 = script:GetAttribute("plr_1_points");
                end;
                if v17 or v18 then
                    if v14 then
                        if v14 <= v17 or v14 <= v18 then
                            u4 = true;
                        end;
                    elseif v15 then
                        local v19 = math.abs(v17 - v18);
                        if (v18 < v17 and 1 or (v17 < v18 and 2 or "draw")) ~= "draw" and v15 <= v19 then
                            u4 = true;
                        end;
                        local v20 = math.clamp(0.5 + (v17 - v18) * 0.12, 0, 1);
                        l__BlueLabel__17.UIGradient.Offset = Vector2.new(v20, 0);
                        l__RedLabel__18.UIGradient.Offset = Vector2.new(v20, 0);
                        l__BlueLabel__17.VFX.Position = UDim2.fromScale(v20, 0.5);
                    end;
                end;
            end;
        end;
    end;
end;
script:GetAttributeChangedSignal("plr_1_points"):Connect(updateProgressBar);
script:GetAttributeChangedSignal("plr_2_points"):Connect(updateProgressBar);
updateProgressBar();
local v21 = script:GetAttribute("delay") or 0;
if script:GetAttribute("serverTime") then
    local v22 = v21 - (workspace:GetServerTimeNow() - script:GetAttribute("serverTime"));
    v21 = math.max(v22, 0);
end;
local v23 = math.max(v21, 0);
if v23 and v23 > 0 then
    task.wait(v23);
end;
l__TweenService__3:Create(l__UI__16.BlackLabel, TweenInfo.new(0.3), {
    Size = UDim2.fromScale(1.025, 0.491)
}):Play();
if script:GetAttribute("timeoutTime") then
    l__UI__16.TimeoutTimer.Bar.Size = UDim2.fromScale(1, 1);
    l__TweenService__3:Create(l__UI__16.TimeoutTimer.Bar, TweenInfo.new(script:GetAttribute("timeoutTime")), {
        Size = UDim2.fromScale(0, 1)
    }):Play();
else
    l__UI__16.TimeoutTimer.Visible = false;
end;
local u24 = newSequence();
local function u30(p25, _) --[[ Line: 206 ]]
    -- upvalues: u4 (ref), l__UI__16 (copy), l__PlayerGui__13 (copy), u1 (copy), u24 (ref), l__TweenService__3 (copy), l__CameraShaker__11 (copy), l__LocalPlayer__12 (copy), l__VFX_Utility__10 (copy), l__Sound__9 (copy), l__remote__19 (copy)
    if u4 or not l__UI__16:IsDescendantOf(l__PlayerGui__13) then
        return;
    end;
    local v26;
    if u1[1] then
        v26 = Enum.UserInputType.Gamepad1;
    elseif u1[2] and not u1[3] then
        v26 = Enum.UserInputType.Touch;
    elseif u1[3] then
        v26 = Enum.UserInputType.Keyboard;
    else
        v26 = nil;
    end;
    if p25.UserInputType ~= v26 or p25.KeyCode == Enum.KeyCode.Unknown then
        return;
    end;
    for v27, v28 in u24 do
        if not v28.completed then
            v28.completed = true;
            if v28.key == p25.KeyCode then
                v28.completeState = "gained";
                l__TweenService__3:Create(v28.frame.Background, TweenInfo.new(0.15), {
                    ImageColor3 = v28.frame.Background:GetAttribute("GreenBackground")
                }):Play();
                l__CameraShaker__11.QuickShake({
                    magnitude = 3,
                    roughness = 13,
                    fadeInTime = 0,
                    fadeOutTime = 0.4,
                    posInfluence = Vector3.new(0.5, 0.2, 0.5),
                    rotInfluence = Vector3.new(0, 0, 0.05),
                    players = { l__LocalPlayer__12 }
                });
                l__VFX_Utility__10.emitVignetteEffect(Color3.fromRGB(85, 255, 0), Color3.fromRGB(85, 255, 0), 0, 0.6, 0);
            else
                v28.completeState = "missed";
                l__TweenService__3:Create(v28.frame.Background, TweenInfo.new(0.15), {
                    ImageColor3 = v28.frame.Background:GetAttribute("RedBackground")
                }):Play();
                l__CameraShaker__11.QuickShake({
                    magnitude = 4,
                    roughness = 16,
                    fadeInTime = 0,
                    fadeOutTime = 0.6,
                    posInfluence = Vector3.new(1, 0.5, 0),
                    rotInfluence = Vector3.new(0, 0, 0.3),
                    players = { l__LocalPlayer__12 }
                });
                l__VFX_Utility__10.emitVignetteEffect(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 0, 0), 0, 0.6, 0);
            end;
            pcall(l__Sound__9.Play, script["QTE_" .. v28.completeState], workspace.CurrentCamera);
            l__TweenService__3:Create(v28.frame.PressedFX, TweenInfo.new(0.35), {
                ImageTransparency = 1,
                Size = UDim2.fromScale(2.5, 2.5)
            }):Play();
            l__remote__19:FireServer(v28.completeState);
            l__TweenService__3:Create(v28.frame.UIScale, TweenInfo.new(0.15), {
                Scale = 1
            }):Play();
            v28.frame.InputIcon.ImageTransparency = 0.5;
            v28.frame.InputKey.TextTransparency = 0.5;
            if v27 < 5 and u24[v27 + 1] then
                local v29 = u24[v27 + 1];
                l__TweenService__3:Create(v29.frame.UIScale, TweenInfo.new(0.15), {
                    Scale = 1.2
                }):Play();
                v29.frame.InputIcon.HideFrame.Visible = false;
                return;
            end;
            break;
        end;
    end;
end;
l__UserInputService__4.InputBegan:Connect(u30);
if u1[2] and not u1[3] then
    coroutine.wrap(function() --[[ Line: 289 ]]
        -- upvalues: u2 (copy), l__CAS__7 (copy), u3 (copy), u30 (copy)
        local v33, v34 = pcall(function() --[[ Line: 290 ]]
            -- upvalues: u2 (ref), l__CAS__7 (ref), u3 (ref), u30 (ref)
            for _, u31 in u2.Mobile do
                local v32 = l__CAS__7.getActionButton(u31);
                u3[#u3 + 1] = v32.Activated:Connect(function() --[[ Line: 294 ]]
                    -- upvalues: u30 (ref), u31 (copy)
                    u30({
                        KeyCode = u31,
                        UserInputType = Enum.UserInputType.Touch
                    }, false);
                end);
            end;
        end);
        if not v33 then
            warn(v34);
        end;
    end)();
end;
coroutine.wrap(function() --[[ Line: 306 ]]
    -- upvalues: l__BlueLabel__17 (copy), l__Debris__5 (copy), l__TweenService__3 (copy), u4 (ref), l__UI__16 (copy), l__PlayerGui__13 (copy)
    local l__VFX__20 = l__BlueLabel__17.VFX;
    local l__Texture__21 = l__VFX__20.Texture;
    while true do
        local u35 = math.random(3, 5) / 10;
        local u36 = u35 * math.random(48, 60) / 10;
        local v38, v39 = pcall(function() --[[ Line: 316 ]]
            -- upvalues: l__Texture__21 (copy), l__Debris__5 (ref), u35 (copy), l__VFX__20 (copy), l__TweenService__3 (ref), u36 (copy)
            local v37 = l__Texture__21:Clone();
            l__Debris__5:AddItem(v37, 0.1);
            v37.Image = v37[math.random(1, 3)].Value;
            v37.Visible = true;
            v37.Size = UDim2.fromScale(u35, u35);
            v37.Rotation = math.random(-180, 180);
            v37.Parent = l__VFX__20;
            l__TweenService__3:Create(v37, TweenInfo.new(0.1), {
                Size = UDim2.fromScale(u36, u36),
                Rotation = v37.Rotation + math.random(-150, 150)
            }):Play();
        end);
        if not v38 then
            warn(v39);
        end;
        task.wait(0.025);
        if u4 or not l__UI__16:IsDescendantOf(l__PlayerGui__13) then
            return;
        end;
    end;
end)();
local v40 = u4;
while true do
    local v41 = 0;
    for _, v42 in u24 do
        if v42.completed then
            v41 = v41 + 1;
        end;
    end;
    if v41 >= 5 then
        u24 = newSequence();
    end;
    task.wait();
    if v40 or not l__UI__16:IsDescendantOf(l__PlayerGui__13) then
        l__Backpack__15.Visible = true;
        for _, v43 in u3 do
            v43:Disconnect();
        end;
        return;
    end;
end;