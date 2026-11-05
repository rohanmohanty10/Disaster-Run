task.wait();
local Button = script.Parent.TextButton
local l_Parent_0 = script.Parent;
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Parent_1 = script.Parent.Parent.Parent;
local l_Character_0 = l_LocalPlayer_0.Character;
local _ = l_Character_0.PrimaryPart;
local l_UserInputService_0 = game:GetService("UserInputService");
local v6 = false;
local v7 = nil;

local HideUltValue = Instance.new("BoolValue")
HideUltValue.Name = "HideUlt"
HideUltValue.Parent = l_Character_0

local function v10()
    local l_TextLabel_0 = l_Parent_1:FindFirstChild("TextLabel");
	if not (workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable and not v6 and l_Character_0:FindFirstChild("HideUlt").Value == false) or l_Character_0:FindFirstChild("HideUlt").Value == true and (not (l_Character_0:GetAttribute("Character") ~= "Bald") or l_Character_0:GetAttribute("Character") == "KJ") then
        if not v7 then
            l_Parent_1:TweenPosition(UDim2.new(0.5, 0, 1, 100), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 1, true);
            v7 = true;
            return ;
        end;
    elseif v7 then
        l_Parent_1:TweenPosition(UDim2.new(0.5, 0, 1, -90), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 1, true);
        v7 = false;
    end;
end;
local function _() -- Xbox controls, do not remove.
    local l_Ult_0 = script.Parent.Parent.Parent.Ult;
    local l_TextLabel_1 = l_Ult_0.TextLabel;
    if l_UserInputService_0.GamepadEnabled then
        l_Ult_0.Text = "[DPAD UP]";
        l_TextLabel_1.Text = "[DPAD UP]";
        return ;
    else
        l_Ult_0.Text = "[G]";
        l_TextLabel_1.Text = "[G]";
        return ;
    end;
end;
script.Parent.Parent.Parent.Ult:GetPropertyChangedSignal("Visible"):Connect(function()
    script.Parent.Parent.Parent.Ult.ImageLabel.Visible = l_UserInputService_0.GamepadEnabled and script.Parent.Parent.Parent.Ult.Visible or false;
end);
local v14 = nil;
local function v17()
    l_Parent_0:TweenSize(UDim2.new((v14 or l_LocalPlayer_0:GetAttribute("Ultimate")) / 100, 0, 0, 25), nil, nil, 0.4, true);
    local l_Ult_1 = script.Parent.Parent.Parent.Ult;
    local l_TextLabel_2 = l_Ult_1.TextLabel;
    if l_UserInputService_0.GamepadEnabled then
        l_Ult_1.Text = "[DPAD UP]";
        l_TextLabel_2.Text = "[DPAD UP]";
    else
        l_Ult_1.Text = "[G]";
        l_TextLabel_2.Text = "[G]";
    end;
    if l_LocalPlayer_0:GetAttribute("Ultimate") >= 100 then
        script.Parent.Parent.Parent.Ult.Visible = true;
        return ;
    else
        script.Parent.Parent.Parent.Ult.Visible = false;
        return ;
    end;
end;
--[[local _ = l_Character_0:GetAttributeChangedSignal("Ulted"):Connect(function(_)
    if not l_Character_0:GetAttribute("Ulted") then
        return ;
    elseif not (l_Character_0:GetAttribute("Character") ~= "Bald") or l_Character_0:GetAttribute("Character") == "KJ" then
        return ;
    elseif not l_Character_0:GetAttribute("UltimateTime") then
        return ;
    else
        local v19 = tick();
        local v20 = false;
        v6 = true;
        v14 = 100;
        v17();
        v10();
        local v21 = nil;
        v21 = l_LocalPlayer_0.Backpack.ChildAdded:Connect(function(v22)
            if tick() - v19 > 10 then
                return v21:Disconnect();
            elseif v22:IsA("Tool") and game:GetService("CollectionService"):HasTag(v22, "Ultimate" .. l_LocalPlayer_0.Name) then
                v20 = true;
                return v21:Disconnect();
            else
                return ;
            end;
        end);
        while true do
            task.wait();
            if not (not v20 and tick() - v19 <= 10) then
                break;
            end;
        end;
        v6 = nil;
        v10();
        if v21 then
            v21:Disconnect();
        end;
        if tick() - v19 > 10 then
            v14 = nil;
            return v17();
        else
            local l_NumberValue_0 = Instance.new("NumberValue");
            l_NumberValue_0.Value = 1;
            l_NumberValue_0:GetPropertyChangedSignal("Value"):Connect(function()
                v14 = l_NumberValue_0.Value * 100;
                v17();
            end);
            local l_PrimaryPart_1 = l_Character_0.PrimaryPart;
            local v25 = nil;
            v25 = l_PrimaryPart_1:GetAttributeChangedSignal("fill"):Connect(function()
                local l_l_PrimaryPart_1_Attribute_0 = l_PrimaryPart_1:GetAttribute("fill");
                if not l_l_PrimaryPart_1_Attribute_0 or l_l_PrimaryPart_1_Attribute_0 <= 0 then
                    v14 = nil;
                    l_NumberValue_0:Destroy();
                    l_NumberValue_0 = nil;
                    v25:Disconnect();
                    return v17();
                else
                    l_NumberValue_0.Value = l_l_PrimaryPart_1_Attribute_0;
                    return ;
                end;
            end);
            return ;
        end;
    end;
end);]]


l_LocalPlayer_0:GetAttributeChangedSignal("Ultimate"):Connect(v17); -- Function that detects if a signal was sent to the player.
if (l_LocalPlayer_0:GetAttribute("Ultimate") or 0) >= l_LocalPlayer_0:GetAttribute("UltimateMax") then
    local l_Ult_2 = script.Parent.Parent.Parent.Ult;
    local l_TextLabel_3 = l_Ult_2.TextLabel;
    if l_UserInputService_0.GamepadEnabled then
        l_Ult_2.Text = "[DPAD UP]";
        l_TextLabel_3.Text = "[DPAD UP]";
    else
        l_Ult_2.Text = "[G]";
        l_TextLabel_3.Text = "[G]";
    end;
    script.Parent.Parent.Parent.Ult.Visible = true;
end;
workspace.CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(v10);
l_Character_0:GetAttributeChangedSignal("Ulted"):Connect(v10);
l_Character_0.ChildAdded:Connect(v10);
l_Character_0.ChildRemoved:Connect(v10);
l_Character_0:FindFirstChild("HideUlt"):GetPropertyChangedSignal("Value"):Connect(v10);
l_Parent_0.Size = UDim2.new((l_LocalPlayer_0:GetAttribute("Ultimate") or 0) / 100, 0, 0, 25);


-- For mobile
Button.Activated:Connect(function()
	v17()
end)

-- Bar color
if l_LocalPlayer_0:GetAttribute("Character") == "Sou" then
	l_Parent_0.Bar.ImageColor3 = Color3.new(0.164706, 0.164706, 0.164706)
elseif l_LocalPlayer_0:GetAttribute("Character") == "Kai" then
	l_Parent_0.Bar.ImageColor3 = Color3.new(0.223529, 0, 0.00392157)
elseif l_LocalPlayer_0:GetAttribute("Character") == "Sunny" then
	l_Parent_0.Bar.ImageColor3 = Color3.new(0.984314, 1, 0)
elseif l_LocalPlayer_0:GetAttribute("Character") == "Alejo" then
	l_Parent_0.Bar.ImageColor3 = Color3.new(1, 0.25098, 0)
elseif l_LocalPlayer_0:GetAttribute("Character") == "Trigger" then
	l_Parent_0.Bar.ImageColor3 = Color3.new(1,1,1)
	l_Parent_0.Bar.ImageColor3 = Color3.new(1, 0.592157, 0.0235294)
end

local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

Remotes.HideUlt.OnClientEvent:Connect(function(value)
	if value == true then
		l_Character_0:FindFirstChild("HideUlt").Value = true
	else
		l_Character_0:FindFirstChild("HideUlt").Value = false
	end
	
end)