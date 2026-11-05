 

 

local l__TweenService__1 = game:GetService("TweenService");
local l__Players__2 = game:GetService("Players");
local l__HttpService__3 = game:GetService("HttpService");
local l__LocalPlayer__4 = l__Players__2.LocalPlayer;
local l__Parent__5 = script.Parent;
local l__Main__6 = l__Parent__5:WaitForChild("Main");
local l__Stats__7 = l__Main__6:WaitForChild("Stats");
local l__Rank__8 = l__Main__6:WaitForChild("Rank");
local l__Rewards__9 = l__Main__6:WaitForChild("Rewards");
local l__Buttons__10 = l__Parent__5:WaitForChild("Buttons");
local l__FunctionLibrary__11 = require(game.ReplicatedStorage.Modules.FunctionLibrary);
local u1 = false;
local function u2() --[[ Line: 18 ]]
    -- upvalues: u1 (ref), l__Main__6 (copy), l__TweenService__1 (copy)
    if u1 == true then
    else
        u1 = true;
        if l__Main__6.Visible == false then
            l__Main__6.Visible = true;
            l__Main__6.GroupTransparency = 1;
            l__Main__6.UIStroke.Transparency = 1;
            l__TweenService__1:Create(l__Main__6, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                GroupTransparency = 0
            }):Play();
            l__TweenService__1:Create(l__Main__6.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Transparency = 0
            }):Play();
            task.wait(0.5);
        elseif l__Main__6.Visible == true then
            l__TweenService__1:Create(l__Main__6, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                GroupTransparency = 1
            }):Play();
            l__TweenService__1:Create(l__Main__6.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Transparency = 1
            }):Play();
            task.wait(0.5);
            l__Main__6.Visible = false;
        end;
        u1 = false;
    end;
end;
(function() --[[ Name: UpdateStatsFrame, Line 83 ]]
    -- upvalues: l__Stats__7 (copy), l__LocalPlayer__4 (copy), l__Players__2 (copy), l__Rewards__9 (copy), l__HttpService__3 (copy), l__FunctionLibrary__11 (copy), l__Rank__8 (copy), l__Parent__5 (copy)
    local l__List__12 = l__Stats__7:WaitForChild("List");
    local l__Placement__13 = l__List__12:WaitForChild("Placement");
    local l__SurvivalTime__14 = l__List__12:WaitForChild("SurvivalTime");
    local l__Participants__15 = l__List__12:WaitForChild("Participants");
    local v3 = l__LocalPlayer__4:GetAttribute("SurvivalTimeStart");
    if v3 then
        local l__ValueText__16 = l__SurvivalTime__14.ValueText;
        local v4 = (v3 - v3 % 60) / 60;
        local v5 = v3 - v4 * 60;
        local v6 = (v4 - v4 % 60) / 60;
        local v7 = v4 - v6 * 60;
        l__ValueText__16.Text = string.format("%02i", v6) .. ":" .. string.format("%02i", v7) .. ":" .. string.format("%02i", v5);
    end;
    local v8 = l__LocalPlayer__4:GetAttribute("Placement");
    l__Placement__13.ValueText.Text = ({ "1st", "2nd", "3rd" })[v8] or "None";
    local v9 = l__Players__2:GetAttribute("Participants") or 0;
    l__Participants__15.ValueText.Text = v9;
    local l__List__17 = l__Rewards__9:WaitForChild("List");
    local v10 = l__LocalPlayer__4:GetAttribute("Rewards");
    if v10 then
        v10 = l__HttpService__3:JSONDecode(v10);
    end;
    local function v12(u11) --[[ Line: 112 ]]
        -- upvalues: l__FunctionLibrary__11 (ref)
        u11.MouseEnter:connect(function() --[[ Line: 113 ]]
            -- upvalues: l__FunctionLibrary__11 (ref), u11 (copy)
            l__FunctionLibrary__11.PlaySound({
                ClientOnly = true,
                Sound = game.ReplicatedStorage.Sounds.Click3
            });
            if u11:GetAttribute("HoverHint") then
                l__FunctionLibrary__11.GuiHoverHint({
                    Gui = u11
                });
            end;
            l__FunctionLibrary__11.GuiHoverAnimate({
                TweenTime = 0.5,
                Gui = u11
            });
        end);
        u11.MouseLeave:connect(function() --[[ Line: 131 ]] end);
    end;
    print(v10);
    if v10 then
        for v13, v14 in pairs(v10) do
            print(v13, v14);
            if typeof(v14) == "number" then
                local v15 = `+{v14}`;
                local v16 = script.RewardTemplate:Clone();
                v16.Name = v13;
                v16.LayoutOrder = 1;
                v16.Parent = l__List__17;
                v16.ItemText.Text = v13;
                v16.ValueText.Text = v15;
            else
                local v17 = v14 == "Item" and 2 or 3;
                local v18 = script.RewardTemplate:Clone();
                v18.Name = v14;
                v18.LayoutOrder = v17;
                v18.Parent = l__List__17;
                v18.ItemText.Text = v14;
                v18.ValueText.Text = v13;
            end;
        end;
    end;
    local v19 = l__LocalPlayer__4:findFirstChild("SBR_Blessings");
    local v20 = 0;
    if v19 then
        for _, v21 in pairs(v19:GetChildren()) do
            v20 = v20 + 1;
            local v22 = "Blessing #" .. v20;
            local l__Name__18 = v21.Name;
            local v23 = v21:GetAttribute("Desc");
            local v24 = l__Participants__15:Clone();
            v24.Name = v22;
            v24.LayoutOrder = #l__Participants__15.Parent:GetChildren() - 1;
            v24.Parent = l__Participants__15.Parent;
            v24.SubText.Text = v22;
            v24.ValueText.Text = l__Name__18;
            v24:SetAttribute("HoverHint", v23);
        end;
    end;
    l__Rank__8.Visible = false;
    for _, v25 in pairs(l__Parent__5:GetDescendants()) do
        if v25:GetAttribute("HoverHint") then
            v12(v25);
        end;
    end;
end)();
local l__Freecam__19 = require(script.Freecam);
local l__Spectate__20 = l__LocalPlayer__4.PlayerGui:WaitForChild("Spectate");
local l__Players__21 = l__Spectate__20:WaitForChild("Players");
l__Spectate__20:WaitForChild("Button").MouseButton1Down:Connect(function() --[[ Line: 213 ]]
    -- upvalues: l__Freecam__19 (copy), l__Spectate__20 (copy)
    l__Freecam__19.ToggleFreecam();
    l__Spectate__20.Enabled = false;
end);
local u26 = {
    View = function() --[[ Line: 219 ]]
        -- upvalues: u2 (copy)
        u2();
    end,
    Spectate = function() --[[ Line: 222 ]]
        -- upvalues: l__Freecam__19 (copy), l__Spectate__20 (copy)
        l__Freecam__19.ToggleFreecam();
        l__Spectate__20.Enabled = true;
    end,
    ServerList = function() --[[ Line: 226 ]]
        -- upvalues: l__LocalPlayer__4 (copy)
        l__LocalPlayer__4.Character.RemoteEvent:FireServer("SBR_Servers");
    end,
    Back = function() --[[ Line: 229 ]]
        -- upvalues: l__LocalPlayer__4 (copy)
        l__LocalPlayer__4.Character.RemoteEvent:FireServer("SBR_Back");
    end
};
for _, u27 in ipairs(l__Buttons__10:GetChildren()) do
    if u27:IsA("TextButton") ~= false then
        u27.MouseButton1Down:Connect(function() --[[ Line: 236 ]]
            -- upvalues: u27 (copy), u26 (copy)
            print(u27);
            local v28 = u26[u27.Name];
            if v28 then
                v28();
            end;
        end);
    end;
end;
local u29 = {};
local function v35(u30) --[[ Line: 254 ]]
    -- upvalues: u29 (copy), l__Players__2 (copy), l__Players__21 (copy), l__Freecam__19 (copy)
    if u29[u30] == nil then
        local v31 = l__Players__2:GetPlayerFromCharacter(u30);
        if v31 == nil then
        else
            u29[u30] = {};
            local u32 = script.Template:Clone();
            u32.Name = u30.Name;
            u32.Parent = l__Players__21;
            u32.Button.Text = `{u30.Name} ({v31.UserId})`;
            u32.Button.MouseButton1Down:Connect(function() --[[ Line: 272 ]]
                -- upvalues: u30 (copy), l__Freecam__19 (ref), u29 (ref)
                local v33 = u30;
                if v33 then
                    v33 = u30:FindFirstChild("HumanoidRootPart");
                end;
                if v33 then
                    l__Freecam__19.ForceUpdateCamera(u30.HumanoidRootPart.CFrame);
                else
                    local v34 = u30;
                    if u29[v34] ~= nil then
                        u29[v34].Destroy();
                    end;
                end;
            end);
            u29[u30].Destroy = function() --[[ Line: 281 ]]
                -- upvalues: u32 (copy)
                u32:Destroy();
            end;
        end;
    end;
end;
local l__Living__22 = workspace:WaitForChild("Living");
l__Living__22.ChildAdded:Connect(v35);
l__Living__22.ChildRemoved:Connect(function(p36) --[[ Name: PlayerRemoving, Line 248 ]]
    -- upvalues: u29 (copy)
    if u29[p36] ~= nil then
        u29[p36].Destroy();
    end;
end);
for _, v37 in ipairs(l__Living__22:GetChildren()) do
    task.spawn(v35, v37);
end;