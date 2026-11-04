 

 

local ValleyPanels = require(script.Parent.ValleyPanels);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 5
    -- upvalues: ValleyPanels (copy), u1 (copy)
    local v3 = {
        folder = ValleyPanels.make("ScreenGui", p2, "ReviveMarkers", {
            ResetOnSpawn = false,
            IgnoreGuiInset = true,
            ClipToDeviceSafeArea = false,
            DisplayOrder = 22,
            ScreenInsets = Enum.ScreenInsets.None
        }),
        records = {}
    };
    local u4 = setmetatable(v3, u1);
    u4.render = game:GetService("RunService").RenderStepped:Connect(function() -- Line: 9
        -- upvalues: u4 (copy)
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if not workspace_CurrentCamera then
            return;
        end;

        for _, v in u4.records do
            if v.root and v.root.Parent then
                local v5, v6 = workspace_CurrentCamera:WorldToViewportPoint(v.root.Position + Vector3.new(0, 3.4, 0));

                if v6 then
                    v6 = v5.Z > 0;
                end;

                v.gui.Visible = v6;
                v.gui.Position = UDim2.fromOffset(v5.X, v5.Y);
            else
                v.gui.Visible = false;
            end;
        end;
    end);

    return u4;
end;

function u1.create(p7, p8, p9) -- Line: 21
    -- upvalues: ValleyPanels (copy)
    local v10 = ValleyPanels.make("Frame", p7.folder, "Revive", {
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        Visible = false,
        Active = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(72, 68)
    });
    local v11 = ValleyPanels.make("Frame", v10, "Circle", {
        BackgroundTransparency = 0.36,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromOffset(35, 35),
        BackgroundColor3 = Color3.fromRGB(14, 39, 36)
    });
    ValleyPanels.corner(v11, 100);
    local v12 = ValleyPanels.make("UIStroke", v11, "Ring", {
        Thickness = 1.8,
        Transparency = 0.22,
        Color = Color3.fromRGB(132, 238, 201)
    });
    local v13 = {};

    for _, v in { Vector2.new(17, 5), Vector2.new(5, 17) } do
        local v14 = ValleyPanels.make("Frame", v11, "Cross", {
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(v.X, v.Y),
            BackgroundColor3 = v12.Color
        });
        ValleyPanels.corner(v14, 2);
        table.insert(v13, v14);
    end;

    local v15 = ValleyPanels.text(v10, "Label", "REVIVE", 0, 39, 72, 17, 10, v12.Color);
    v15.TextXAlignment = Enum.TextXAlignment.Center;
    v15.Font = Enum.Font.GothamBold;
    v15.TextStrokeTransparency = 0.45;
    local v16 = {
        root = p9,
        gui = v10,
        disc = v11,
        ring = v12,
        label = v15,
        bars = v13
    };
    p7.records[p8] = v16;

    return v16;
end;

function u1.update(p17, p18, p19, p20) -- Line: 38
    local v21 = {};
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if p20 and workspace_CurrentCamera then
        for _, v in p18 do
            local Character = v.Character;
            local v22;

            if Character then
                v22 = Character:FindFirstChild("HumanoidRootPart");
            else
                v22 = Character;
            end;

            if Character ~= p19.Character and (Character and (Character.Parent and (v22 and (Character:GetAttribute("RescueAvailable") == true and Character:GetAttribute("Ragdolled") == true)))) then
                local Magnitude = (workspace_CurrentCamera.CFrame.Position - v22.Position).Magnitude;

                if Magnitude < 150 then
                    v21[Character] = true;
                    local v23 = p17.records[Character] or p17:create(Character, v22);
                    v23.root = v22;
                    local Attribute = Character:GetAttribute("RescueHelperId");
                    local v24 = Attribute and Color3.fromRGB(239, 206, 137) or Color3.fromRGB(132, 238, 201);
                    local math_clamp_ret = math.clamp((Magnitude - 80) / 70, 0, 1);
                    v23.ring.Color = v24;
                    v23.ring.Transparency = math_clamp_ret * 0.65 + 0.22;
                    v23.disc.BackgroundTransparency = math_clamp_ret * 0.5 + 0.36;

                    for _, v2 in v23.bars do
                        v2.BackgroundColor3 = v24;
                        v2.BackgroundTransparency = math_clamp_ret * 0.75 + 0.1;
                    end;

                    v23.label.Text = Attribute and (Attribute == p19.UserId and "REVIVING" or "HELPING") or "REVIVE";
                    v23.label.TextColor3 = v24;
                    v23.label.TextTransparency = math_clamp_ret * 0.85;
                    v23.label.TextStrokeTransparency = math_clamp_ret * 0.5 + 0.45;
                end;
            end;
        end;
    end;

    for i, v in p17.records do
        if not v21[i] then
            v.gui:Destroy();
            p17.records[i] = nil;
        end;
    end;
end;

function u1.destroy(p25) -- Line: 61
    p25.render:Disconnect();
    p25.folder:Destroy();
    table.clear(p25.records);
end;

return u1;